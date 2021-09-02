# frozen_string_literal: true

require 'spec_helper'
require 'custom_discount'

RSpec.describe CustomDiscount do
  describe '#add' do
    context 'when adding a new discount' do
      it 'adds a new discount to the hash' do
        discount = CustomDiscount.new
        discount.add(title: 'staff', percentage: 50)

        expect(discount.discounts).to include({ staff: 50 })
      end

      it 'makes sure that the string is all lowercase before converting to symbol' do
        discount = CustomDiscount.new
        discount.add(title: 'cApS', percentage: 20)

        expect(discount.discounts).to include({ caps: 20 })
      end
    end
  end

  describe '#fetch' do
    context 'when fetching a discount that exists' do
      it 'returns the percentage discount by symbol passed in' do
        discount = CustomDiscount.new
        discount_by = discount.fetch(:student)

        expect(discount_by).to eq(10)
      end
    end
  end
end
