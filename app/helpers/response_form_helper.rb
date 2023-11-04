

# Creating response forms in json format. With it response data format is more unified
class ResponseFormHelper

  @status = ResponseStatus.instance.default[:literal]
  @message = ResponseStatus.instance.default[:message]
  @html_status = ResponseStatus.instance.default[:html_status]
  @@extra = Hash.new # for some reason instance hash is always nil

  def set_status(status)
    response_status = ResponseStatus.instance.get_status(status)
    @status = response_status[:literal]
    @message = response_status[:message]
    @html_status = response_status[:html_status]
    self
  end

  # add new key data from outside
  def add_extra(key, value)
    key = key.to_s
    @@extra.store(key, value)
    self
  end

  #get unified result. if extras are empty - deletes it
  def result
    final_result = {
      data: {
        status: @status,
        message: @message,
        extra: @@extra
      },
      status: @html_status
    }
    unless @@extra
      final_result[:data].delete(:extra)
    end
    final_result
  end

  def initialize
    @@extra = Hash.new
  end

end