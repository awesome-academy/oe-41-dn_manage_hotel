

module Dry
  module Core
    class InvalidClassAttributeValue < StandardError
      def initialize(name, value)
        super(
          "Value #{value.inspect} is invalid for class attribute #{name.inspect}"
        )
      end
    end
  end
end
