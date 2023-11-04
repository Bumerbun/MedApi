class ResponseStatusBase
  private
  # basically every line with status in classes that inherit it would make methods for them
  # creates entries for different response statuses for easy data access
  def self.status(name, literal, message, html_status)
    name = name.to_s
    define_method(name) do
      {
        literal: literal,
        message: message,
        html_status: html_status
      }
    end
    define_method(name+"_literal") do
      literal
    end
    define_method(name+"_message") do
      message
    end
    define_method(name+"_html_status") do
      html_status
    end
  end

  public

  # set of methods to use previously created status methods by string or symbol names
  def get_status(name)
    name = name.to_s
    self.send(name)
  end

  def get_literal(name)
    name = name.to_s
    self.send(name+"_literal")
  end

  def get_message(name)
    name = name.to_s
    self.send(name+"_message")
  end

  def get_html_status(name)
    name = name.to_s
    self.send(name+"_html_status")
  end
end