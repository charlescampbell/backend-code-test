# frozen_string_literal: true

class CustomDiscount
  def initialize
    @discounts = { nhs: 50, student: 10 }
  end

  attr_reader :discounts

  def add(title:, percentage:)
    title = title.downcase.to_sym

    discounts[title] = percentage
  end

  def fetch(title)
    discounts[title]
  end
end
