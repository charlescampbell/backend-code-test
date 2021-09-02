# frozen_string_literal: true

require 'pry'

class Checkout
  attr_reader :prices
  private :prices

  def initialize(prices, discount_status = nil)
    @prices = prices
    @discount_status = discount_status
  end

  def scan(item)
    basket << item.to_sym
  end

  # rubocop:disable Metrics/MethodLength
  def total
    total = 0

    itemized_basket.each do |item, count|
      total += case item
               when :apple, :pear
                 apple_and_pears_cost(item, count)
               when :banana, :pineapple
                 pineapple_cost(item, count)
               when :mango
                 mango_cost(count)
               else
                 apply_no_discount(item, count)
               end
    end

    total
  end
  # rubocop:enable Metrics/MethodLength

  private

  def apple_and_pears_cost(item, count)
    return prices.fetch(item) * (count / 2) if (count % 2).zero?

    apply_no_discount(item, count)
  end

  def pineapple_cost(item, count)
    total = 0

    if item == :pineapple
      total += (prices.fetch(item) / 2)
      total += prices.fetch(item) * (count - 1)
    else
      total += (prices.fetch(item) / 2) * count
    end

    total
  end

  def mango_cost(count)
    return prices.fetch(:mango) * (count * 0.75) if (count % 4).zero?

    apply_no_discount(item, count)
  end

  def basket
    @basket ||= []
  end

  def itemized_basket
    basket.each_with_object(Hash.new(0)) { |item, items| items[item] += 1 }
  end

  def apply_no_discount(item, count)
    prices.fetch(item) * count
  end
end
