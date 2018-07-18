require 'gilded_rose.rb'

describe GildedRose do
  describe '#update_quality' do
    it 'decreases the quality by amount to decrement' do
      chicken = ItemWrapper.item(name: 'Chicken', sell_in: 5, quality: 2)
      gildrose = GildedRose.new([chicken])
      gildrose.update_quality
      expect(gildrose.items[0].quality).to eq 1
    end
  end
end
