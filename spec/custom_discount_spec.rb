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
    end
  end
end
