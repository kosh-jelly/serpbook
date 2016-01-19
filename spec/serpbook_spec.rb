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
        conf.email = 'josh@kellys.org'
      end
      expect(Serpbook.configuration.email).to eq 'josh@kellys.org'
    end
  end

  describe 'categories' do
    it 'gets a list of current categories' do
      expect(Serpbook.categories.keys).to include 'PBN Tests'
    end

    it 'gets view key and category key from categories' do
      pbn_tests = Serpbook.categories['PBN Tests']
      expect(pbn_tests[:viewkey]).to eq '1w5jv1'
      expect(pbn_tests[:auth]).to eq 'a85cdcd82dcd769bbd0c58dfb6f084b9'
    end
  end
end
