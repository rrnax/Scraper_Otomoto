#Exceptions
class NilAppear < StandardError
  def initialize(message)
    super(message)
    puts message
  end
end

class NegativNumber < StandardError
  def initialize(message)
    super(message)
    puts message
  end
end
