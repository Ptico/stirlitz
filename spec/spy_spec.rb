require 'spec_helper'

describe Stirlitz::Spy do
  let(:spy) { described_class.new {} }

  it 'should catch method call' do
    spy.call

    expect(spy.called?).to be_true
  end

  it 'should catch the number of method calls' do
    3.times { spy.call }

    expect(spy.call_count).to eql(3)
  end

  it 'should catch given arguments' do
    spy.call :foo, 2

    expect(spy.calls[0].args[0]).to eql(:foo)
    expect(spy.calls[0].args[1]).to eql(2)
  end

  it 'should catch given block' do
    spy.call { 2 * 2 }

    expect(spy.calls[0].block.call).to eq(4)
  end
end