require 'dry-validation'

module Types
  include Dry.Types
  Phone = Types::String.constrained(format: "^(\+7)+\d{10}")
  Email = Types::String.constrained(format: URI::MailTo::EMAIL_REGEXP)
end

class PatientContract < Dry::Validation::Contract
  params do
    required(:name).filled(:string, max_size?:100, min_size?:2)
    required(:surname).filled(:string, max_size?:100, min_size?:2)
    required(:patronymic).filled(:string, max_size?:100, min_size?:2)
    required(:phone).filled(:string, size?:12)
    required(:email).filled(Types::Email)
  end

  register_macro(:unique) do |macro:|
    field_name = macro.args[0]
    key.failure("User with this #{field_name} already exists") if Patient.find_by("#{field_name} = '#{value}'")
  end

  rule(:phone) do
    key.failure("Phone number must start with +7") unless value.start_with?("+7")
  end
  rule(:phone).validate(unique: :phone)
  rule(:email).validate(unique: :email)
end