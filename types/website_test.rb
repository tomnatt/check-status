require File.expand_path(File.dirname(__FILE__)) + "/base_test.rb"
require 'net/http'

class WebsiteTest < BaseTest

    @type = "website"
    attr_reader :name, :addr

    def initialize(name, addr)
        @name = name
        @addr = addr
    end

    def run_test
        url = URI.parse(@addr)
        # can add proxy here if we need it later
        http = Net::HTTP.new(url.host, url.port)
        res = http.request(Net::HTTP::Get.new(url.request_uri))
        
        @result = false
        if (res.code.to_i < 400) then 
            @result = true
        end

        return [@name, @addr, @result.to_s]
    end

end
