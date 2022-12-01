class Response::JsonResponse
  attr_accessor :status
  attr_accessor :message
  attr_accessor :payload
  include AbstractController::Rendering

  def initialize(message, payload)
    @payload = payload
    @message = message
  end

  def build
    {
      data: @payload,
      message: @message
    }
  end
end
