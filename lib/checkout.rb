# frozen_string_literal: true

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
          total += prices.fetch(item) * count
        end
      elsif item == :banana || item == :pineapple
        if item == :pineapple
          total += (prices.fetch(item) / 2)
          total += (prices.fetch(item)) * (count - 1)
        else
          total += (prices.fetch(item) / 2) * count
        end
      else
        total += prices.fetch(item) * count
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
end
