require File.dirname(__FILE__) + '/../../test_helper'
module Spec
  module Runner
    class SpecificationTest < Test::Unit::TestCase
      
      def setup
        @reporter = Mock.new "reporter"
      end

      def test_should_run_spec_in_different_scope_than_exception
        spec = Specification.new("should pass") do
          self.should.not.be.instance_of Specification
          self.should.be.instance_of Object
        end
        @reporter.should_receive(:spec_passed).with spec
        spec.run @reporter
      end

      def test_should_add_itself_to_reporter_when_passes
        spec = Specification.new("spec") { }
        @reporter.should_receive(:spec_passed).with spec
        spec.run(@reporter)
      end

      def test_should_add_itself_to_reporter_when_fails
        error = RuntimeError.new
        spec = Specification.new("spec") { raise error }
        @reporter.should_receive(:spec_failed).with spec, error
        spec.run(@reporter)
      end
      
      def teardown
        @reporter.__verify
      end
    end
  end
end