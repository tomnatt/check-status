class BaseTest

    attr_reader :type, :result

    def run_test
        return ["base test - this should have been overwritten", "http://www.example.com", false.to_s]
    end

end
