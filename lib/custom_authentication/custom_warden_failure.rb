class CustomWardenFailure < Devise::FailureApp
  def respond
    if http_auth?
      http_auth
    elsif request.content_type == "application/json"
      self.status = 401
      self.content_type = "application/json"
      self.response_body = {success: false, message: "Unauthorized", data: {}}.to_json
    else
      redirect
    end
  end
end
