require 'spec_helper'

describe Product do
  describe '#find' do
    it 'must return product if product is within our store' do
      expect(Product.find('FR1')).not_to eq(nil)
    end
  end

  describe '#all' do
    it 'must return array with products' do
      expect(Product.all.count).to be > 0
    end
  end
end
