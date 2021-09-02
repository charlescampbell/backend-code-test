# frozen_string_literal: true

class CustomDiscount
  def initialize
    @discounts = {}
  end

  attr_reader :discounts

  def add(title:, percentage:)
    discounts[title.to_sym] = percentage
  end
end
