class Response::Message
  attr_accessor :code
  attr_accessor :message

  def initialize(code, message)
    @code = code
    @message = message
  end
end
