require 'spec_helper'

describe "Given examples" do
  let(:co) do
    pricing_rules = [
      PricingRule::DiscountOnQuantity.new(  product_id = 'AP1',
                                            new_price = 4.50,
                                            when_quantity_is_at_least = 3),
      PricingRule::BuyOneGetOneFree.new(    product_id = 'FR1')
    ]

    co = Checkout.new(pricing_rules)
  end

  def scan_multiple array
    array.each do |id|
      co.scan(id)
    end
  end

  it "should properly sum discount for FR1" do
    scan_multiple(['FR1', 'AP1', 'FR1', 'CF1'])
    expect(co.total).to eq 19.34
  end

  it "should work with buy one - get one for free" do
    scan_multiple(['FR1', 'FR1'])
    expect(co.total).to eq 3.11
  end

  it "should add discount for AP1" do
    scan_multiple(['AP1', 'AP1', 'FR1', 'AP1'])
    expect(co.total).to eq 16.61
  end
end
