require 'rubygems'
require 'GoogleFinance'

Broker = GoogleFinance.new
puts YAML::dump(Broker.symbol('GOOG').get_quotes_range(Date.today, Date.today - 250))   #get_quotes_range returns a max of 200 results, including
                                                                                        #   weekends you can normally set it to get 250 past days