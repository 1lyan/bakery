# Test Project that simulates delivery of a Bakery Shop
# Requirements
- Ruby = 2.6.5

# Setup
- Goto project's folder in your terminal
- run: `rvm install ruby-2.6.5` if required
- do `cd ..` and `cd bakery` so that rvm created a gemset
- once a gemset is created run `bundle install`
- now run `ruby bin/runner.rb $COUNT $PRODUCT_CODE $PRODUCT_FILE`. For example:
$ ruby bin/runner.rb 13 CF ./bin/products.csv
$ ruby bin/runner.rb 10 VS5
- default file with products is located at bin/products.csv in order to not clutter the code with
hardcoded product objects

# Specs
Run `rspec` to launch tests