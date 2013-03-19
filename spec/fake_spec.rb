require 'spec_helper'
require 'pry'

describe Stirlitz::Fake do
  let(:fake) { described_class.new(strict) }

  context 'non strict' do
    let(:strict) { false }

    it 'should catch method call' do
      fake.my_method

      expect(fake[:my_method].called?).to be_true
    end

    it 'should catch the number of method calls' do
      3.times { fake.my_method }

      expect(fake[:my_method].call_count).to eql(3)
    end

    it 'should catch given arguments' do
      fake.my_method :foo, 2

      expect(fake[:my_method].calls[0].args[0]).to eql(:foo)
      expect(fake[:my_method].calls[0].args[1]).to eql(2)
    end

    it 'should catch given block' do
      fake.my_method { 2 * 2 }

      expect(fake[:my_method].calls[0].block.call).to eq(4)
    end

    it 'should catch method names' do
      fake.foo
      fake.bar

      expect(fake.called_methods).to eq([:foo, :bar])
    end
  end
end