
class CreationHelper
  def self.create(params, active_record, validator)
    validation_result = validator.call(params)

    unless validation_result.success?
      return {
        data: {
           status: "FAILURE",
           message: "Request could not be saved",
           error_text: validation_result.errors.map { |error| { "text": error.text, "path": error.path } }
       },
        status: :bad_request
      }
    end

    # create and save patient unless fail
    new_record = active_record.new(validation_result.to_h)
    unless new_record.save
      return {
        data: {
          status: "FAILURE",
          message: "Request could not be saved"
      },
        status: :bad_request
      }
    end

    return {
      data: {
        status: "SUCCESS",
        message: "Successfully created" },
      status: :created
    }
  end
end