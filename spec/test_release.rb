require 'rspec'
require 'debian_control_parser'
require 'byebug'

RSpec.describe DebianControlParser do
  describe "parsing Release file" do
    it "parses the one block" do
      keyval = {}
      filename_release = File.dirname(__FILE__) + '/fixtures/Release'
      open(filename_release) do |data|
        byebug
        #DebianControlParser::blocks(data) do |block|
          DebianControlParser::parse(data) do |key,value|
            keyval[key]=value
          end
        #end
      end

      expect(keyval.length).to eq(6)
    end
  end
end
