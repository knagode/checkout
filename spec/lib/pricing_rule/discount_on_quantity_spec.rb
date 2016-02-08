require 'spec_helper'

describe PricingRule::DiscountOnQuantity do
  subject do
    PricingRule::DiscountOnQuantity.new product_id = 'FR1', new_price = 1.00, when_quantity_is_at_least = 2
  end

  it 'should respond to its attributes' do
    expect(subject).to respond_to(:product_id, :new_price, :when_quantity_is_at_least)
  end

  describe '#price_per_unit_for_quantity' do
    it 'should return non discounted price for quantity = 1' do
      expect(subject.price_for_quantity(1)).to eq(Product.find('FR1').price)
    end

    it 'should return discounted price for quantity = 2' do
      expect(subject.price_for_quantity(2)).to eq(subject.new_price * 2)
    end
  end
end
