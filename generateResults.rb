#!/bin/ruby

require 'rubygems'
require 'test_runner.rb'


# config
script_location = File.expand_path(File.dirname(__FILE__))

tests = TestRunner.new(script_location)
tests.run_tests
tests.create_output
