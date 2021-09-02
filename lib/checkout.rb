# frozen_string_literal: true

require 'pry'

class Checkout
  attr_reader :prices
  private :prices

  def initialize(prices)
    @prices = prices
  end

  def scan(item)
    basket << item.to_sym
  end

  def total
    total = 0

    itemized_basket.each do |item, count|
      if item == :apple || item == :pear
        if (count % 2 == 0)
          total += prices.fetch(item) * (count / 2)
        else
          total += apply_no_discount(item, count)
        end
      elsif item == :banana || item == :pineapple
        if item == :pineapple
          total += (prices.fetch(item) / 2)
          total += (prices.fetch(item)) * (count - 1)
        else
          total += (prices.fetch(item) / 2) * count
        end
      elsif item == :mango
        if (count % 4 == 0)
          total += prices.fetch(item) * (count * 0.75)
        else
          total += apply_no_discount(item, count)
        end
      else
        total += apply_no_discount(item, count)
      end
    end

    total
  end

  private

  def basket
    @basket ||= Array.new
  end

  # TODO: Investigate looking at each_with_object
  def itemized_basket
    basket.inject(Hash.new(0)) { |items, item| items[item] += 1; items }
  end

  def apply_no_discount(item, count)
    prices.fetch(item) * count
  end
end
