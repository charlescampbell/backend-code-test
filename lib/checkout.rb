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
      case item
      when :apple, :pear
        total += if (count % 2).zero?
                   prices.fetch(item) * (count / 2)
                 else
                   apply_no_discount(item, count)
                 end
      when :banana, :pineapple
        if item == :pineapple
          total += (prices.fetch(item) / 2)
          total += prices.fetch(item) * (count - 1)
        else
          total += (prices.fetch(item) / 2) * count
        end
      when :mango
        total += if (count % 4).zero?
                   prices.fetch(item) * (count * 0.75)
                 else
                   apply_no_discount(item, count)
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

  def itemized_basket
    basket.each_with_object(Hash.new(0)) { |item, items| items[item] += 1 }
  end

  def apply_no_discount(item, count)
    prices.fetch(item) * count
  end
end
