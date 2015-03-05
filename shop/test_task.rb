class Checkout

  def initialize(*rules)
    @rules = rules
  end

  def self.prices
    @prices ||= {
      'FR1' => 3.11,
      'SR1' => 5.00,
      'CF1' => 11.23
    }
  end  

  attr_accessor :rules

  def item_prices
    temp_prices = []
    @basket.each {|item| temp_prices << Checkout.prices[item]} if @item_prices.nil?
    @item_prices ||= temp_prices
  end

  def scan(item)
    @basket ||=[]
    @basket << item
  end

  def total
    sum = 0.0
    @rules.each {|rule| @item_prices = Rule.send rule, @basket, item_prices }
    
    # puts @item_prices.inspect
    @basket.each_with_index {|item, index| sum+=item_prices[index]}
    sum
  end
end

class Rule
  class << self
    def two_as_one(items, prices, item = 'FR1')
      even = false
      items.each_with_index do |basket_element, index|
        next if basket_element != item
        if even
          prices[index] = 0
          even = false
          next
        end
        even = true
      end
      prices 
    end

    def discount(items, prices, item = 'SR1', new_price = 4.50, amount = 3)
      count = items.count { |basket_element| basket_element == item }
      if count >= amount
        items.each_with_index do |basket_element, index|
          prices[index] = new_price if basket_element == item
        end
      end
      prices
    end
  end
end

co = Checkout.new('two_as_one', 'discount')
# co.scan('FR1')
# co.scan('SR1')
# co.scan('FR1')
# co.scan('FR1')
# co.scan('CF1')


# co.scan('FR1')
# co.scan('FR1')

co.scan('SR1')
co.scan('SR1')
co.scan('FR1')
co.scan('SR1')
price = co.total





