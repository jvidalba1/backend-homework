class FormatPasswordValidator < ActiveModel::EachValidator

  PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#?\]])(?=.*[\W]).{10,}\z/

  def validate_each(record, attribute, value)
    unless value =~ PASSWORD_REGEX
      record.errors.add(attribute, 'is invalid')
    end
  end
end
