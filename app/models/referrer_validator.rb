class ReferrerValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless (value =~ /\A(http|https):\/\/([a-z0-9\-\.]+\.(com|org|net|mil|edu))/i) ||
        (value =~ /\A(http|https):\/\/(localhost:\d*)/i)
      record.errors[attribute] << (options[:message] || "is not a domain")
    end
  end
end
