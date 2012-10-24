#!/bin/ruby

require 'rubygems'
require 'rss/maker'
require 'yaml'

# config
script_location = File.expand_path(File.dirname(__FILE__))

test_location = script_location + "/tests/"
output_file = script_location + "/output/service_status.rss" # local file to write

# load all test types
Dir.new(script_location + "/types/").entries.each { |file|
    if file =~ /.+\.rb$/ then
        require "#{script_location + "/types"}/#{file}"
    end
}

# check for output directory
if (!(File.exists?(File.dirname(output_file)) && File.directory?(File.dirname(output_file)))) then
    abort("you need an output directory")
end

results = Array.new

# for each file do 
Dir.new(test_location).entries.each { |file|
    
    # only read files ending in .txt
    if file =~ /.+\.yml$/ then 
    
        file = test_location + file
        
        # read the yaml into a string - there must be a better way of doing this
        data = ''
        f = File.open(file, "r") 
        f.each_line do |line|
            data += line
        end
        
        test = YAML::load(data)
        
        if (test["type"] == "website") then 
            results << doWebsiteTest(test["name"], test["url"]);
        elsif (test["type"] == "mysql") then
            puts "mysql"
        elsif (test["type"] == "oracle") then
            puts "oracle"
        elsif (test["type"] == "tomcat") then
            puts "tomcat"
        else
            puts "other"
        end
    end
    # end the for each
}

# create the output RSS feed 
version = "2.0" # ["0.9", "1.0", "2.0"]

content = RSS::Maker.make(version) do |m|
    m.channel.title = "Web Services Services. On the Web."
    m.channel.link = "http://www.bath.ac.uk/"
    m.channel.description = "Status of the services run by Web Services"
    m.items.do_sort = true # sort items by date
    
    # for each result, add an entry in the output feed
    results.each { |result|
        i = m.items.new_item
        i.title = result[0]
        i.link = result[1]
        i.description = result[2]
        i.date = Time.now    
    }
    
end

File.open(output_file,"w") do |f|
    f.write(content)
end

def get_file_as_string(filename)
    data = ''
    f = File.open(filename, "r") 
    f.each_line do |line|
        data += line
    end
    return data
end
