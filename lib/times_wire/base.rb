require 'rubygems'
require 'open-uri'
require 'json'
require 'date'

module TimesWire
  class Base
  	API_SERVER = 'api.nytimes.com'
  	API_VERSION = 'v3'
  	API_NAME = 'news'
  	API_BASE = "/svc/#{API_NAME}/#{API_VERSION}/content"

  	@@api_key = nil
  	@@debug = false
  	@@copyright = nil
  	@@semantic_api_key = nil

		# The copyright footer to be placed at the bottom of any data from the New York Times. Note this is only set after an API call.
		def copyright
			@@copyright
		end
				
		##
		# Set the API key used for operations. This needs to be called before any requests against the API. To obtain an API key, go to http://developer.nytimes.com/
		def self.api_key=(key)
			@@api_key = key
		end

		def self.api_key
			@@api_key
		end
		
		def self.semantic_api_key=(key)
		  @@semantic_api_key = key
		end
		
		def self.api_key
		  @@semantic_api_key
		end
		
		def self.datetime_parser(datetime)
		  datetime ? DateTime.parse(datetime) : nil
		end
		
		##
		# Builds a request URI to call the API server
		def self.build_request_url(path, params)
			URI::HTTP.build :host => API_SERVER, :path => "#{API_BASE}/#{path}.json", :query => params.map {|k,v| "#{k}=#{v}"}.join('&')
		end

		def self.invoke(path, params={})
			begin
				if @@api_key.nil?
					raise "You must initialize the API key before you run any API queries"
				end

				full_params = params.merge 'api-key' => @@api_key

				uri = build_request_url(path, full_params)

				reply = uri.read
				parsed_reply = JSON.parse reply

				if parsed_reply.nil?
					raise "Empty reply returned from API"
				end

				@@copyright = parsed_reply['copyright']

				parsed_reply
			rescue OpenURI::HTTPError => e
				if e.message =~ /^404/
					return nil
				end

				raise "Error connecting to URL #{uri} #{e}"
			end
		end
  end
end
