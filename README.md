# Backend Engineer Code Test

## The tasks

- Refactor code
- Buy 3 get 1 free on Mangos: [8ca257b](https://github.com/charlescampbell/backend-code-test/commit/6c9f46201c1b0c64f70d9008e1dae441fafddc6c)
- Being able to dynamically specify discounts: [8387d32](https://github.com/charlescampbell/backend-code-test/commit/8387d32159c3c2e69d20194bb8cbe3f9935407f5)

## Tools

- In order to lint the project run `rubocop`
- To run the test suite `rspec` or in some cases `bundle exec rspec`

## Assumptions

- Where it has been specified that discounts can be dynamically added this has been inffered as adding a discount to the total cost of the basket

## New Usage

A new object can be created to act as a temporary database called CustomDiscount. In order to add fetch and add new data to this object the two follow methods can be used.

```ruby
discount = CustomDiscount.new

discount.add(title: 'student', percentage: 50)

discount.fetch(:student)
```
