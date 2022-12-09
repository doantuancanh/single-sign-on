module BaseCmd
  include SimpleCommand

  def self.prepended(base)
    base.extend SimpleCommand::ClassMethods
  end

  class FinishSignal < StandardError; end

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

end
