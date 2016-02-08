module PricingRule
  class DiscountOnQuantity < PricingRule::Base
    attr_accessor :product_id, :new_price, :when_quantity_is_at_least

    def initialize product_id, new_price, when_quantity_is_at_least
      @product_id = product_id
      @new_price = new_price
      @when_quantity_is_at_least = when_quantity_is_at_least
    end

    def price_for_quantity quantity
      price = Product.find(product_id).price
      price = new_price if quantity >= when_quantity_is_at_least
      price * quantity
    end
  end
end
