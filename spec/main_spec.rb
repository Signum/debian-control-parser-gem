require 'rspec'
require 'debian_control_parser'

RSpec.describe DebianControlParser do
  describe "parsing Release file" do
    before :example do
      @fields = {}
      filename_release = File.dirname(__FILE__) + '/fixtures/Release'
      open(filename_release) do |data|
        DebianControlParser::fields(data) do |name,value|
          @fields[name]=value
        end
      end
    end

    it "finds all fields" do
      expect(@fields.length).to eq(12)
    end
    it "finds the Codename field" do
      expect(@fields['Codename']).to eq 'precise'
    end

    it "counts 160 lines as the value for the 'MD5Sum' field" do
      expect(@fields['MD5Sum'].lines.length).to be 160
    end
  end

  describe "parsing part of a Packages file with multiple paragraphs" do
    before :example do
      @paragraphs = []
      filename_release = File.dirname(__FILE__) + '/fixtures/Packages'
      open(filename_release) do |data|
        DebianControlParser::paragraphs(data) do |paragraph|
          @fields = {}
          DebianControlParser::fields(paragraph) do |name,value|
            @fields[name]=value
          end
          @paragraphs << @fields
        end
      end
    end

    it "finds all 5 paragraphs" do
      expect(@paragraphs.length).to eq 5
    end

    it "counts 19 names in the first paragraph" do
      expect(@paragraphs.first.length).to eq 19
    end

    it "finds the last name 'Supported' in all paragraphs" do
      @paragraphs.each do |paragraph|
        expect(paragraph).to include 'Supported'
      end
    end
  end

  describe "parsing part of a Release file as an enumerator" do
    before :example do
      @fields = {}
      filename_release = File.dirname(__FILE__) + '/fixtures/Release'
      open(filename_release) do |data|
        DebianControlParser::fields(data).each do |name,value|
          @fields[name]=value
        end
      end
    end

    it "parses all fields" do
      expect(@fields.length).to eq(12)
    end

    it "finds the Codename field" do
      expect(@fields['Codename']).to eq 'precise'
    end

    it "counts 160 lines as the value for the 'MD5Sum' field" do
      expect(@fields['MD5Sum'].lines.length).to be 160
    end
  end
end
