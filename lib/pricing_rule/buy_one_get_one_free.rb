module PricingRule
  class BuyOneGetOneFree < PricingRule::Base
    def price_for_quantity quantity
      price = Product.find(product_id).price
      quantity = (quantity.to_f / 2).ceil
      price * quantity
    end
  end
end
