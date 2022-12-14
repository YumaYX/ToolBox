#!/usr/bin/env ruby

require 'selenium-webdriver'

# options
options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--headless')

# driver
driver = Selenium::WebDriver.for :chrome, capabilities: [options]

=begin
driver = Selenium::WebDriver.for :chrome
driver.manage.window.resize_to(800,600)
=end

url='http://www.yahoo.co.jp'

# access
driver.get(url)
sleep 1
driver.navigate.to "https://google.com/"
sleep 1

p driver.title
p driver.page_source.encode('utf-8')[0,40]

driver.close # window
driver.quit # app
