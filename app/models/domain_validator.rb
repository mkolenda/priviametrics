class DomainValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless (value =~ /\A([a-z0-9\-\.]+\.(com|org|net|mil|edu))\z/i) ||
        (value =~ /\A(localhost:\d*)\z/i)
      record.errors[attribute] << (options[:message] || "is not a valid domain name")
    end
  end
end
