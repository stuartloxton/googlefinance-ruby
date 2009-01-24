require 'rubygems'
require 'mechanize'
require 'yaml'

class Date
  def to_s_format (format)
    pieces = self.to_s.split('-')
    format.sub!('%y', pieces[0])
    format.sub!('%m', pieces[1])
    format.sub!('%d', pieces[2])
    return format
  end
end

class GoogleFinance
  
  def initialize
    @@agent = WWW::Mechanize.new
  end
  
  def symbol (symbol)
    return GoogleFinance::Symbol.new(symbol)
  end
  
  class Symbol
    
    def initialize (symbol)
      @symbol = symbol
      return self
    end
    
    def get_quotes
      return GoogleFinance.get_quotes_for_url('http://finance.google.co.uk/finance/historical?cid=694653&startdate=01+26+2008&enddate=01+24+2009')
    end
    
    def get_quotes_range (date_start, date_end)
      if date_start > date_end then
        dateStart = date_end.to_s_format('%m+%d+%y')
        dateEnd = date_start.to_s_format('%m+%d+%y')
      else
        dateStart = date_start.to_s_format('%m+%d+%y')
        date_end = date_end.to_s_format('%m+%d+%y')
      end
      return GoogleFinance.get_quotes_for_url('http://finance.google.co.uk/finance/historical?q=' + @symbol+ '&startdate=' + dateStart + '&enddate=' + dateEnd + '&num=200')
    end
    
  end
  
  def self.get_quotes_for_url (url)
    page = @@agent.get(url)
    rows = []
    page.search('#prices tr').each do |tr|
      tds = tr.search('td:nth(1)').text
      rows << {
        :date => tr.search('td:nth(0)').text,
        :open => tr.search('td:nth(1)').text,
        :high => tr.search('td:nth(2)').text,
        :low => tr.search('td:nth(3)').text,
        :close => tr.search('td:nth(4)').text,
        :volume => tr.search('td:nth(5)').text
      }
    end
    rows.shift
    return rows
  end
  
end