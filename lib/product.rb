require 'csv'

class Product
  attr_reader :name, :price

  def initialize name, price
    @name = name
    @price = price
  end

  def self.all
    csv_text = File.read('datastore/products.csv')
    csv = CSV.parse(csv_text)
    hash = csv.inject({}) do |products, row|
      products[row[0]] = Product.new(row[1], row[2].to_f)
      products
    end
  end

  def self.find(id)
    Product.all[id]
  end

end
