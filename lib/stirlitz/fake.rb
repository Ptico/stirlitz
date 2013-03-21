require 'stirlitz/stub'

module Stirlitz
  class Fake
    attr_reader :called_methods

    def stub(method_name, options={})
      @stubs[method_name.to_sym] ||= Stub.new(options)
    end

    def [](name)
      @spies[name.to_sym]
    end
    alias :method :[]

    def method_missing(method_name, *args, &block)
      if @strict && !@stubs.has_key?(method_name)
        raise NoMethodError, "undefined method `#{method_name}' for #{self}"
      end

      @called_methods << method_name unless @called_methods.include?(method_name)

      @spies[method_name].call(*args, &block)

      @stubs[method_name].call(args) if @stubs.has_key?(method_name)
    end

  private

    def initialize(strict=false)
      @called_methods = []
      @stubs  = {}
      @strict = !!strict
      @spies  = Hash.new { |h, k| h[k] = Spy.new {} }
    end

  end
end