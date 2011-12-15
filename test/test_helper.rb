require 'test/unit'
require 'rubygems'
require 'shoulda'
require 'json'

%w(base item section).each do |f|
  require File.join(File.dirname(__FILE__), '../lib/times_wire', f)
end

# set your NYT Times Newswire API key as an environment variable to run the tests
API_KEY = ENV['NYT_TIMESWIRE_API_KEY']
TimesWire::Base.api_key = API_KEY

module TestTimesWire
end
