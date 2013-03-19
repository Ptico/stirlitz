module Stirlitz
  class Spy < ::Proc
    Call = Struct.new(:args, :block, :time).freeze

    attr_reader :calls, :call_count

    def called?
      call_count > 0
    end

    def call(*args, &block)
      @call_count += 1
      @calls << Call.new(args, block, Time.now)
      super
    end

  private

    def initialize(&block)
      @calls = []
      @call_count = 0

      super(&block)
    end

  end
end