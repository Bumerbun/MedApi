
# creating easy to access data for different response statuses
class ResponseStatus < ResponseStatusBase
  status :default, "UNDEFINED", "Undefined result", :im_used
  status :undefined, "UNDEFINED", "Undefined result", :im_used
  status :success, "SUCCESS", "Request was successfully fulfilled", :ok
  status :failure, "FAILURE", "Failure during request processing", :internal_server_error
  status :save_failure, "SAVE_FAILURE", "Error during parameters validations", :bad_request
  status :validation_failure, "VALIDATION_FAILURE", "Failure during saving, possibly conflicts", :conflict
  status :created, "CREATED", "Successfully created", :created

  # method for instancing without making global classes
  # it works, but a subject to rewrite
  def self.instance
    @@instance = self.new
    @@instance
  end
end