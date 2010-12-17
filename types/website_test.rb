#!/bin/ruby

require 'net/http'

def doWebsiteTest(name, address)
    
    url = URI.parse(address)
    # can add proxy here if we need it later
    http = Net::HTTP.new(url.host, url.port)
    res = http.request(Net::HTTP::Get.new(url.request_uri))
    
    result = "failed"
    if (res.code.to_i < 400) then 
        result = "passed"
    end
    
    return [name, address, result]
end
