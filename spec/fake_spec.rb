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

  context 'strict' do
    let(:strict) { true }

    it 'should throw an exception if method is not stubbed' do
      expect{ fake.my_method }.to raise_error(NoMethodError)
    end

    it 'should success if method is stubbed' do
      fake.stub(:my_method)

      expect{ fake.my_method}.to_not raise_error
      expect(fake.called_methods).to include(:my_method)
    end
  end

  describe 'Stubs' do
    let(:strict) { true }

    it 'should stub method' do
      fake.stub(:find)

      expect(fake.find).to eq(nil)
    end

    it 'should stub method and return result' do
      fake.stub(:find).and_return('find')

      expect(fake.find).to eq('find')
    end

    it 'should stub method with arguments and return results' do
      fake.stub(:where).with(:name => 'Joe').and_return(1)
      fake.stub(:where).with(:name => 'Jay').and_return(2)

      expect(fake.where(:name => 'Joe')).to eql(1)
      expect(fake.where(:name => 'Jay')).to eql(2)
    end
  end
end