class Report
  attr_accessor :orders

  def initialize
    @orders = Order.last_month
  end

  def total_revenue
    total = 0
    Source.all.each do |source|
      total += total_billed_for_source(source)
    end
    total
  end

  def total_billed_for_source(source)
    quantity = total_quantity_sold(source)
    quantity * source.cost_per_unit(quantity)
  end


  def profit_for_source(source)
    revenue_for_source(source) - total_billed_for_source(source)
  end

  def total_quantity_sold(source)
    quantity = 0
    orders.each do |order|
      quantity += order.quantity if order.source_name == source.name
    end
    quantity
  end

  def revenue_for_source(source)
    total_quantity_sold(source) * source.price
  end
end
