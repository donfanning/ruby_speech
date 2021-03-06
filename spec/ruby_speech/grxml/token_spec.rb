require 'spec_helper'

module RubySpeech
  module GRXML
    describe Token do
      its(:name) { should == 'token' }

      it 'registers itself' do
        Element.class_from_registration(:token).should == Token
      end

      describe "from a document" do
        let(:document) { '<token>hello</token>' }

        subject { Element.import parse_xml(document).root }

        it { should be_instance_of Token }

        its(:content) { should == 'hello' }
      end

      describe "#language" do
        before { subject.language = 'jp' }

        its(:language) { should == 'jp' }
      end

      describe "comparing objects" do
        it "should be equal if the content is the same" do
          Token.new(:content => "hello").should == Token.new(:content => "hello")
        end

        describe "when the content is different" do
          it "should not be equal" do
            Token.new(:content => "Hello").should_not == Token.new(:content => "Hello there")
          end
        end
      end

      describe "<<" do
        it "should accept String" do
          lambda { subject << 'anything' }.should_not raise_error
        end
      end
    end # Token
  end # GRXML
end # RubySpeech
