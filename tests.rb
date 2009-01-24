require 'rubygems'
require 'activesupport'
require 'GoogleFinance'
broker = GoogleFinance.new
puts YAML::dump(broker.symbol('GOOG').get_quotes_range(Date.today, Date.today.years_ago(1)))