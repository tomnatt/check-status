#!/bin/ruby

require 'rubygems'
require 'haml'
require 'test_runner.rb'
require 'sinatra'
require 'rss/parser'

# config
set :public_folder, 'public'
script_location = File.expand_path(File.dirname(__FILE__))

tests = TestRunner.new(script_location)

get '/run' do
    tests.run_tests
    tests.create_output
    puts "done"
end

get '/output' do
    send_file tests.output_file
end

get '/' do

    # Read the feed into rss_content
    rss_content = ""
    open(tests.output_file, "r") do |f|
       rss_content = f.read
    end

    # Parse the feed, dumping its contents to rss
    rss = RSS::Parser.parse(rss_content, false)

    title = "Results"
    haml :index, :format => :html5, :locals => {:title => title, :rss => rss}
end
