# frozen_string_literal: true

require 'spec_helper'
require 'checkout'
require 'custom_discount'

RSpec.describe Checkout do
  describe '#total' do
    subject(:total) { checkout.total }

    let(:checkout) { Checkout.new(pricing_rules) }
    let(:pricing_rules) do
      {
        apple: 10,
        orange: 20,
        pear: 15,
        banana: 30,
        pineapple: 100,
        mango: 200
      }
    end

    context 'when no offers apply' do
      before do
        checkout.scan(:apple)
        checkout.scan(:orange)
      end

      it 'returns the base price for the basket' do
        expect(total).to eq(30)
      end
    end

    context 'when a two for 1 applies on apples' do
      before do
        checkout.scan(:apple)
        checkout.scan(:apple)
      end

      it 'returns the discounted price for the basket' do
        expect(total).to eq(10)
      end

      context 'and there are other items' do
        before do
          checkout.scan(:orange)
        end

        it 'returns the correctly discounted price for the basket' do
          expect(total).to eq(30)
        end
      end
    end

    context 'when a two for 1 applies on pears' do
      before do
        checkout.scan(:pear)
        checkout.scan(:pear)
      end

      it 'returns the discounted price for the basket' do
        expect(total).to eq(15)
      end

      context 'and there are other discounted items' do
        before do
          checkout.scan(:banana)
        end

        it 'returns the correctly discounted price for the basket' do
          expect(total).to eq(30)
        end
      end
    end

    context 'when a half price offer applies on bananas' do
      before do
        checkout.scan(:banana)
      end

      it 'returns the discounted price for the basket' do
        expect(total).to eq(15)
      end
    end

    context 'when a half price offer applies on pineapples restricted to 1 per customer' do
      before do
        checkout.scan(:pineapple)
        checkout.scan(:pineapple)
      end

      it 'returns the discounted price for the basket' do
        expect(total).to eq(150)
      end
    end

    context 'when only buying 2 mangos' do
      it 'returns the price for two mangos' do
        2.times { checkout.scan(:mango) }

        expect(total).to eq(400)
      end
    end

    context 'when a buy 3 get 1 free offer applies to mangos' do
      it 'returns the discounted price for the basket with 4 mangos' do
        4.times { checkout.scan(:mango) }

        expect(total).to eq(600)
      end

      it 'returns the discounted price for the basket with 8 mangos' do
        8.times { checkout.scan(:mango) }

        expect(total).to eq(1200)
      end
    end

    context 'when applying a student discount' do
      let(:checkout) { Checkout.new(pricing_rules, :student) }

      it 'returns the discounted 10% price for the basket with 4 mangos' do
        4.times { checkout.scan(:mango) }

        expect(total).to eq(540)
      end
    end
  end
end
