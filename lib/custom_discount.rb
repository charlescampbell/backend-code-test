# frozen_string_literal: true

class CustomDiscount
  def initialize
    @discounts = {}
  end

  attr_reader :discounts

  def add(title:, percentage:)
    title = title.downcase.to_sym

    discounts[title] = percentage
  end
end
