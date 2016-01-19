require 'spec_helper'

describe Serpbook, :vcr do
  it 'has a version number' do
    expect(Serpbook::VERSION).not_to be nil
  end

  describe 'configures' do
    it 'configures master_key' do
      Serpbook.config do |conf|
        conf.master_key = 'blah'
      end
      expect(Serpbook.configuration.master_key).to eq 'blah'
    end

    it 'configures email' do
      Serpbook.config do |conf|
        conf.email = 'myemail@gmail.com'
      end
      expect(Serpbook.configuration.email).to eq 'myemail@gmail.com'
    end
  end

  describe 'categories' do
    it 'gets a list of current categories' do
      expect(Serpbook.categories.keys).to include ENV['test_category_name']
    end

    it 'gets view key and category key from categories' do
      
      pbn_tests = Serpbook.categories[ENV['test_category_name']]
      expect(pbn_tests[:viewkey]).to be_a String
      expect(pbn_tests[:auth]).to be_a String
    end
  end
end
