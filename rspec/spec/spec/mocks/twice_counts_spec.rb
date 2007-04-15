require File.dirname(__FILE__) + '/../../spec_helper.rb'

module Spec
  module Mocks
    context "TwiceCounts" do
      setup do
        disable_auto_verification_of_mocks
        @mock = mock("test mock")
      end

      specify "twice should fail when call count is higher than expected" do
        @mock.should_receive(:random_call).twice
        @mock.random_call
        @mock.random_call
        @mock.random_call
        lambda do
          @mock.rspec_verify
        end.should raise_error(MockExpectationError)
      end
      
      specify "twice should fail when call count is lower than expected" do
        @mock.should_receive(:random_call).twice
        @mock.random_call
        lambda do
          @mock.rspec_verify
        end.should raise_error(MockExpectationError)
      end
      
      specify "twice should fail when called twice with wrong args on the first call" do
        @mock.should_receive(:random_call).twice.with("1", 1)
        lambda do
          @mock.random_call(1, "1")
        end.should raise_error(MockExpectationError)
      end
      
      specify "twice should fail when called twice with wrong args on the second call" do
        @mock.should_receive(:random_call).twice.with("1", 1)
        @mock.random_call("1", 1)
        lambda do
          @mock.random_call(1, "1")
        end.should raise_error(MockExpectationError)
      end
      
      specify "twice should pass when called twice" do
        @mock.should_receive(:random_call).twice
        @mock.random_call
        @mock.random_call
        @mock.rspec_verify
      end
      
      specify "twice should pass when called twice with specified args" do
        @mock.should_receive(:random_call).twice.with("1", 1)
        @mock.random_call("1", 1)
        @mock.random_call("1", 1)
        @mock.rspec_verify
      end
      
      specify "twice should pass when called twice with unspecified args" do
        @mock.should_receive(:random_call).twice
        @mock.random_call("1")
        @mock.random_call(1)
        @mock.rspec_verify
      end
    end
  end
end