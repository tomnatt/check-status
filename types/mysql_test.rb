require File.expand_path(File.dirname(__FILE__)) + "/base_test.rb"

class MysqlTest < BaseTest

    @type = "mysql"

    def run_test
        return ["mysql - not yet implemented", "http://www.example.com", false.to_s]
    end

end
