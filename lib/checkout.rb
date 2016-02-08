class Checkout

  def initialize pricing_rules
    @pricing_rules_hash = pricing_rules.inject({}){ |hash,rule| hash.merge(rule.product_id => rule) }
    @products = {}
  end

  def scan id
    raise ArgumentError, 'Product doesnt exist in database' unless Product.find(id)
    @products[id] = 0 unless @products.key?(id)
    @products[id] +=  1
  end

  def total
    @products.inject(0) do |total, (product_id, quantity)|
      total += total_price_for_product(product_id, quantity)
    end
  end

  private

  def total_price_for_product product_id, quantity
    total = nil
    if @pricing_rules_hash.key?(product_id)
      total = @pricing_rules_hash[product_id].price_for_quantity(quantity)
    else
      total = Product.find(product_id).price * quantity
    end
    total
  end
end
