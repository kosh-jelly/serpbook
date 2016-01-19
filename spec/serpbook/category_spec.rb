require 'spec_helper'

describe Serpbook::Category, :vcr do

   before :each do
      @cat = Serpbook::Category.new(name: 'PBN Tests')
    end

  describe 'setup' do
    it 'gets the view key' do
      expect(@cat.viewkey).not_to be_nil
    end

    it 'gets the cat auth from the name' do
      expect(@cat.cat_auth).not_to be_nil
    end
  end

  it 'gets all rankings' do
    expect(@cat.rankings.first.keys).to include('url', 'kw')
  end

  describe 'rankings' do

    it 'gets a specific urls keywords' do
      expect(@cat.rankings.for_url('www.iwantoneofthose.com/gifts/gifts-for-her.list').first).to include('url' => 'www.iwantoneofthose.com/gifts/gifts-for-her.list')
    end

    it 'gets urls for a specific keyword' do
      expect(@cat.rankings.for_keyword('ideas for birthday presents for her').first).to  include('kw' => 'ideas for birthday presents for her')
    end
  end

  describe 'add keyword' do
    before :each do
      @url = 'http://test.com/applebees'
      @keyword = 'test'
    end

    it 'creates a new keyword-url combo' do
      @cat.create(@url, @keyword)
      expect(@cat.rankings.for_keyword(@keyword).first['url']).to eq 'test.com/applebees'
      @cat.delete(@url, @keyword)
    end

    it 'deletes a keyword' do
      @cat.create(@url, @keyword)
      @cat.delete(@url, @keyword)
      expect(@cat.reload.rankings.for_keyword(@keyword).first).to be_nil
    end
  end

end