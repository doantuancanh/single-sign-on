class CustomWardenFailure < Devise::FailureApp
  def respond
    if http_auth?
      http_auth
    elsif request.content_type == "application/json"
      self.status = 401
      self.content_type = "application/json"
      self.response_body = {errors: { code: StatusConstant::UNAUTHORIZED}}.to_json
    else
      redirect
    end
  end
end
