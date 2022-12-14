module BaseCmd
  include SimpleCommand

  def self.prepended(base)
    base.extend SimpleCommand::ClassMethods
  end

  class FinishSignal < StandardError; end

  class Errors < SimpleCommand::Errors
    def add(key, value, _opts = {})
      self[key] = value
    end
  end

  def call
    begin
      super
    rescue FinishSignal; end

    self
  end

  def invoke_cmd(cmd_class, params)
    cmd = cmd_class.call(**params)

    errors.add_multiple_errors(cmd.errors) if cmd.failure? 

    cmd.result
  end

  def step(runner, *args)
    @result = send(runner, *args)

    raise FinishSignal if errors.any?

    @result
  end

  def chance(runner)
    @result = send(runner)

    raise FinishSignal if @result
  end

  def add_model_errors model
    model.errors.each do |error|
      errors.add(error.attribute, error.full_message) 
    end
  end

  def errors
    @errors ||= Errors.new
  end

  def status
    set_status
  end

  def set_status(status = :bad_request)
    @status ||= status

    if errors.present?
      case errors[:code]
      when StatusConstant::PERMISSION_DENIED # Không có quyền
        :forbidden
      when StatusConstant::INVALID_PARAMS # Tham số không hợp lệ
        :bad_request
      when StatusConstant::UNAUTHORIZED # Xác thực không thành công
        :unauthorized
      when StatusConstant::RESOURCE_NOT_EXIST # Tham số không thỏa mãn điều kiện nghiệp vụ
        :not_acceptable
      when StatusConstant::NOT_FOUND # Không tìm thấy đối tượng
        :not_found
      end
    end
  end
end
