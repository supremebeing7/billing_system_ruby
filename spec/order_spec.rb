require 'spec_helper'

describe Order do
  describe '#initializing' do
    it 'should work fine if source is valid' do
      expect { Order.new(quantity: 10, source_name: "ACompany") }.not_to raise_error
    end
    it 'raises an error if source is invalid' do
      expect { Order.new(quantity: 10, source_name: "invalid") }.to raise_error InvalidSource
    end
    it 'sets the total amount paid equal to source price times quantity' do
      source = instance_double('Source', name: 'test', price: 10)
      allow(Source).to receive(:find_by_name).and_return(source)
      order = Order.new(quantity: 10)
      expect(order.amount_paid).to eq 100
    end
  end

  describe '.last_month' do
    # This statement is not actually accurate in the current implementation
    # but it is what this method would do if we were not working with random data
    it 'retrieves orders from the last month' do
      expect(Order).to receive(:generate_random).with(100)
      Order.last_month
    end
  end

  describe '.generate_random' do
    it 'builds new random orders' do
      expect(Order).to receive(:new_random_order).exactly(42).times
      Order.generate_random(42)
    end
    it 'generates as many orders as requested' do
      expect(Order.generate_random(100).size).to eq 100
      expect(Order.generate_random(42).size).to eq 42
    end
  end

  describe '.new_random_order' do
    it 'builds a new order with random sample data' do
      order = Order.new_random_order
      expect(order.quantity).to be_between(1,100)
      expect(Source.names).to include order.source_name
    end
  end
end