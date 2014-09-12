require 'rspec'
require 'debian_control_parser'

RSpec.describe DebianControlParser do
  describe "parsing Release file" do
    before :example do
      @keyval = {}
      filename_release = File.dirname(__FILE__) + '/fixtures/Release'
      open(filename_release) do |data|
        DebianControlParser::parse(data) do |key,value|
          @keyval[key]=value
        end
      end
    end

    it "parses all keys" do
      expect(@keyval.length).to eq(12)
    end
    it "finds the Codename key" do
      expect(@keyval['Codename']).to eq 'precise'
    end

    it "counts 160 lines as the value for the 'MD5Sum' key" do
      expect(@keyval['MD5Sum'].lines.length).to be 160
    end
  end

  describe "parsing part of a Packages file with multiple blocks" do
    before :example do
      @blocks = []
      filename_release = File.dirname(__FILE__) + '/fixtures/Packages'
      open(filename_release) do |data|
        DebianControlParser::blocks(data) do |block|
          keyval = {}
          DebianControlParser::parse(block) do |key,value|
            keyval[key]=value
          end
          @blocks << keyval
        end
      end
    end

    it "finds all 5 blocks" do
      expect(@blocks.length).to eq 5
    end

    it "counts 19 keys in the first block" do
      expect(@blocks.first.length).to eq 19
    end

    it "finds the last key 'Supported' in all blocks" do
      @blocks.each do |block|
        expect(block).to include 'Supported'
      end
    end
  end
end
