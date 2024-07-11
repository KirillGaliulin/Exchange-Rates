require 'net/http'
require 'rexml/document'

URL = "https://www.cbr.ru/scripts/XML_daily.asp"
response = Net::HTTP.get_response(URI.parse(URL))
doc = REXML::Document.new(response.body)

array_of_currency = {
  'USD': 'R01235',
  'EUR': 'R01239',
  'CNY': 'R01375'
}

array_of_currency.each do |abbr_currency, id_currency|
  currency = doc.elements["//Valute[@ID='#{id_currency}']"]
  name = currency.elements['Name'].text
  price = currency.elements['Value'].text

  puts "#{name}: #{price} руб."
end