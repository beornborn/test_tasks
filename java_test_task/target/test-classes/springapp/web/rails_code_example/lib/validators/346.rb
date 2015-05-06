class ValideCounterValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    if object.id.blank?
      if value.present?
        if Background.exists?(:active => true, :counter => value)
          object.errors[attribute] << (options[:message] || 'Priority already exists')
        end
      end
    else
      if value.present?
        if Background.exists?(["active =? and counter = ? and id <> ?", true, value, object.id])
          object.errors[attribute] << (options[:message] || 'Priority already exists')
        end
      end
    end 
  end
end
