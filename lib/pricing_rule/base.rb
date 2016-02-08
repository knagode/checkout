module PricingRule
  class Base
    attr_accessor :product_id

    def initialize product_id
      @product_id = product_id
    end

    def price_for_quantity quantity
      raise 'price_for_quantity should be overriden in child class'
    end

  end
end
