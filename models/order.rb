class Order
  attr_accessor :quantity, :source_name, :amount_paid

  def initialize(attributes)
    raise InvalidSource unless source = Source.find_by_name(attributes[:source_name])
    @quantity = attributes[:quantity]
    @source_name = source.name
    @amount_paid = source.price * quantity
  end

  def self.last_month
    # This will change when dates are added, but checking dates was not in the
    # scope of the project description
    generate_random(100)
  end

  def self.generate_random(number)
    orders = []
    number.times do
      orders << new_random_order
    end
    orders
  end

  def self.new_random_order
    quantity = rand(100)
    source = Source.all.sample
    new(quantity: quantity, source_name: source.name)
  end
end