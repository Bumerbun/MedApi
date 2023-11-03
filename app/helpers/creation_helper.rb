
class CreationHelper
  def self.create(caller, params, active_record, validator)
    validation_result = validator.call(params)

    unless validation_result.success?
      caller.render json: {
        status: "FAILURE",
        message: "Request could not be saved",
        error_text: validation_result.errors.first&.text
      }, status: :bad_request
      return
    end

    # create and save patient unless fail
    new_record = active_record.new(validation_result.to_h)
    unless new_record.save
      caller.render json: {status: "FAILURE", message: "Request could not be saved"}, status: :bad_request
    end

    caller.render json: {status: "SUCCESS", message: "Successfully created"}, status: :created
  end
end