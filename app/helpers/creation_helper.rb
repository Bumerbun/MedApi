
class CreationHelper
  def self.create(params, active_record, validator)
    validation_result = validator.call(params)
    response_form = ResponseFormHelper.new

    # validation fail handler
    unless validation_result.success?
      response_form.set_status(:validation_failure)
      response_form.add_extra(:error_data, validation_result.errors.map { |error| { "text": error.text, "path": error.path } })
      return response_form
    end

    # create and save patient unless fail
    new_record = active_record.new(validation_result.to_h)
    unless new_record.save
      response_form.set_status(:save_failure)
      return response_form
    end

    response_form.set_status(:created)
    return response_form
  end
end