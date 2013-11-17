ENV['RACK_ENV'] = 'test'

require_relative 'myapp'
require 'test/unit'
require 'rack/test'

class MyAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    @app ||= MyApp.new
  end

  def test_it_returns_ok
    get '/test'
    puts last_response.body
    assert last_response.ok?
    assert_equal 'test3', last_response.body
  end

end