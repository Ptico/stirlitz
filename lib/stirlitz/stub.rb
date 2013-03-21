module Stirlitz
  class Stub
    Expectation = Struct.new(:args, :ret_value) {
      def and_return(val)
        self.ret_value = val
      end
    }.freeze

    def with(*args)
      Expectation.new(args, nil).tap { |exp| @expectations << exp }
    end

    def and_return(value)
      @default_return = value
    end

    def call(args=nil)
      @expectations.each do |exp|
        return exp.ret_value if exp.args == args
      end if args

      @default_return
    end

  private

    def initialize(options={})
      @expectations = []
      @default_return = nil
    end

  end
end