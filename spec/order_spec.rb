require 'spec_helper'

describe Order do
  describe '#initializing' do
    it 'should initialize if source is valid' do
      expect { Order.new(quantity: 10, source_name: "ACompany") }.not_to raise_error
    end
    it 'should raise error if source is invalid' do
      expect { Order.new(quantity: 10, source_name: "invalid") }.to raise_error InvalidSource
    end
    it 'should total amount paid from source price times quantity' do
      source = instance_double('Source', name: 'test', price: 10)
      allow(Source).to receive(:find_by_name).and_return(source)
      order = Order.new(quantity: 10)
      expect(order.amount_paid).to eq 100
    end
  end
  # def initialize(attributes)
  #   raise InvalidSource unless source = Source.find_by_name(attributes[:source_name])
  #   @quantity = attributes[:quantity]
  #   @source_name = source.name
  #   @amount_paid = source.price * quantity
  # end

  # def self.last_month
  #   # This will change when dates are added, but checking dates was not in the
  #   # scope of the project description
  #   generate_random(100)
  # end

  # def self.generate_random(number)
  #   orders = []
  #   number.times do
  #     orders << new_random_order
  #   end
  #   orders
  # end

  # def self.new_random_order
  #   quantity = rand(100)
  #   source = Source.all.sample
  #   amount_paid = source.price * quantity
  #   new(quantity: quantity, source_name: source.name, amount_paid: amount_paid)
  # end

end