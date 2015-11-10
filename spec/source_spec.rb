require 'spec_helper'

describe Source do
  let(:direct_source) { Source.new(name: 'Direct', price: 100, affiliate: false, reseller: false) }
  let(:affiliate_source) { Source.new(name: 'ACompany', price: 75, affiliate: true, reseller: false) }
  let(:reseller_source) { Source.new(name: 'SellMoreThings', price: 85, affiliate: false, reseller: true) }

  describe '.find_by_name' do
    it 'returns a source when given its name' do
      expect(Source.find_by_name('Direct')).to be_an_instance_of(Source)
    end
    it 'returns nothing if the source does not exist' do
      expect(Source.find_by_name('Not a Source')).to be_nil
    end
  end

  describe '.names' do
    it 'gives an array of the names of all the sources' do
      expect(Source.names).to eq ['Direct', 'ACompany', 'AnotherCompany',
                                  'EvenMoreCompany', 'ResellThis', 'SellMoreThings']
    end
  end

  describe '.all' do
    it 'gives all 6 sources' do
      expect(Source.all.count).to eq 6
    end
    it 'gives the full source objects and attributes' do
      source = Source.all.first
      expect(source.name).to eq 'Direct'
      expect(source.price).to eq 100
      expect(source.affiliate).to be false
      expect(source.reseller).to be false
    end
  end

  describe '#cost_per_unit' do
    it 'gives the cost per unit for a direct sale' do
      expect(direct_source.cost_per_unit).to eq 100
    end
    it 'gives the cost per unit for a reseller' do
      expect(reseller_source.cost_per_unit).to eq 50
    end
    context 'gives the cost per unit for an affiliate, with quantity discounts' do
      it 'gives no discount for 500 units or fewer sold' do
        expect(affiliate_source.cost_per_unit(500)).to eq 60
      end
      it 'gives a discount for 501-1000 units sold' do
        expect(affiliate_source.cost_per_unit(700)).to eq 50
      end
      it 'gives a bigger discount for 1001 units or more sold' do
        expect(affiliate_source.cost_per_unit(1001)).to eq 40
      end
    end
  end
end