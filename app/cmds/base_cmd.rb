module BaseCmd    
  include SimpleCommand    
    
  def self.prepended(base)    
    base.extend SimpleCommand::ClassMethods    
  end    
    
end
