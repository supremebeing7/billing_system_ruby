class Source
  attr_accessor :name, :price, :affiliate, :reseller

  def initialize(attributes)
    @name = attributes[:name]
    @price = attributes[:price]
    @affiliate = attributes[:affiliate]
    @reseller = attributes[:reseller]
  end

  def self.find_by_name(name)
    all.select { |source| source.name == name }.first
  end

  def self.names
    all.collect { |source| source.name }    
  end

  def self.all
    all_raw_data.collect do |source_data|
      new(name: source_data[:name], price: source_data[:price], 
          affiliate: source_data[:affiliate], reseller: source_data[:reseller])
    end    
  end

  def self.all_raw_data
    [
      { name: 'Direct', price: 100, affiliate: false, reseller: false },
      { name: 'ACompany', price: 75, affiliate: true, reseller: false  },
      { name: 'AnotherCompany', price: 65, affiliate: true, reseller: false  },
      { name: 'EvenMoreCompany', price: 80, affiliate: true, reseller: false  },
      { name: 'ResellThis', price: 75, affiliate: false, reseller: true  },
      { name: 'SellMoreThings', price: 85, affiliate: false, reseller: true  }
    ]
  end

  def affiliate?
    affiliate
  end

  def reseller?
    reseller
  end

  def cost_per_unit(quantity)
    return 50 if reseller?
    return affiliate_cost_per_unit(quantity) if affiliate?
    return 100
  end

  def affiliate_cost_per_unit(quantity)
    return 40 if quantity > 1000
    return 50 if quantity > 500
    return 60      
  end
end