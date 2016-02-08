require 'spec_helper'

describe Checkout do

  context 'without pricing rules' do
    let(:checkout) do
      pricing_rules = []
      co = Checkout.new(pricing_rules)
    end

    describe '#scan' do
      it 'must change total price' do
        expect{ checkout.scan('FR1') }.to change { checkout.total }
      end

      it 'should raise error if scanned product is not in the datastore' do
        expect{ checkout.scan('*__*') }.to raise_error(ArgumentError)
      end
    end

    describe '#total' do
      it 'should return sum of all products in checkout' do
        checkout.scan('FR1')
        checkout.scan('FR1')
        expect(checkout.total).to eq(Product.find('FR1').price * 2)
      end
    end
  end

  context 'with pricing rule' do
    let(:discount_on_quantity) do
      PricingRule::DiscountOnQuantity.new(product_id = 'FR1',
                                          new_price = 1.00,
                                          when_quantity_is_at_least = 1)
    end

    let(:checkout) do
      first_rule =
      pricing_rules = [discount_on_quantity]
      co = Checkout.new(pricing_rules)
    end

    describe '#total' do
      it 'should return sum which also use pricing rule' do
        checkout.scan('FR1')
        expect(checkout.total).to eq(discount_on_quantity.new_price * 1)
      end
    end
  end

end
