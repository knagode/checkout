require 'spec_helper'

describe PricingRule::BuyOneGetOneFree do
  subject do
    PricingRule::BuyOneGetOneFree.new product_id = 'FR1'
  end

  describe '#price_per_unit_for_quantity' do
    let(:original_price) { Product.find('FR1').price }

    it 'should return price for single product' do
      expect(subject.price_for_quantity(1)).to eq(original_price)
    end

    it 'should return price for single product (second product is free)' do
      expect(subject.price_for_quantity(2)).to eq(original_price)
    end

    it 'should return price for two product (only one product is free)' do
      expect(subject.price_for_quantity(3)).to eq(original_price * 2)
    end
  end
end
