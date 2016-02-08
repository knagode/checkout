require './lib/init'


pricing_rules = [ PricingRule::DiscountOnQuantity.new(  product_id = 'AP1',
                                                        new_price = 4.50,
                                                        when_quantity_is_at_least = 3),
                  PricingRule::BuyOneGetOneFree.new(    product_id = 'FR1')]

co = Checkout.new(pricing_rules)
co.scan('FR1')
co.scan('AP1')
co.scan('FR1')
co.scan('CF1')

puts "Total price: #{co.total}"

