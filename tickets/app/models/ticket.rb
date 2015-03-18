class Ticket < ActiveRecord::Base
  include ActiveModel::Transitions

  DEPARTMENTS = ['payments', 'technical_issues', 'other']
  SELECT_DEPARTMENTS = DEPARTMENTS.map { |s| [s.capitalize, s] }

  belongs_to :user
  has_many :comments

  validates :name, presence: true
  validates :email, presence: true
  validates :department, presence: true, :inclusion => { :in => DEPARTMENTS }
  validates :subject, presence: true
  validates :description, presence: true
  validates :uref, presence: true, uniqueness: true

  before_validation :set_uref, on: :create

  scope :fresh, -> { where(user_id: nil, state: 'waiting_for_staff_response') }
  scope :in_process, -> { where.not(user_id: nil).where(state: %w(waiting_for_staff_response waiting_for_customer on_hold)) }
  scope :done, -> { where(state: %w(cancelled completed)) }

  state_machine auto_scopes: true do
    state :waiting_for_staff_response
    state :waiting_for_customer
    state :on_hold
    state :cancelled
    state :completed

    event :cancel do
      transitions :to => :cancelled, :from => [:waiting_for_staff_response, :waiting_for_customer, :on_hold]
    end

    event :complete do
      transitions :to => :completed, :from => [:waiting_for_staff_response, :waiting_for_customer, :on_hold]
    end

    event :hold do
      transitions :to => :on_hold, :from => [:waiting_for_staff_response, :waiting_for_customer]
    end

    event :to_customer do
      transitions :to => :waiting_for_customer, :from => [:waiting_for_staff_response]
    end

    event :to_staff do
      transitions :to => :waiting_for_staff_response, :from => [:on_hold, :waiting_for_customer]
    end
  end

  def self.valid_uref? uref
    (/\A[A-Z]{3}-[0-9A-F]{2}-[A-Z]{3}-[0-9A-F]{2}-[A-Z]{3}\z/ =~ uref).present?
  end

  def set_uref
    self.uref = "#{rand_string 3}-#{rand_hex 2}-#{rand_string 3}-#{rand_hex 2}-#{rand_string 3}"
  end

  def rand_string size, library = ('A'..'Z').to_a
    ([nil] * size).map {|x| library.sample }.join
  end

  def rand_hex size
    hex_library = [*'0'..'9', *'A'..'F']
    rand_string size, hex_library
  end
end
