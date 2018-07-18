require 'gilded_rose.rb'

describe GildedRose do
  describe '#update_quality' do
    it 'decreases the quality by amount to decrement' do
      chicken = ItemWrapper.item(name: 'Chicken', sell_in: 5, quality: 2)
      gildedrose = GildedRose.new([chicken])
      expect { gildedrose.update_quality }.to change { gildedrose.items[0].quality }.by -1
    end
    it 'decreases the sell-in by amount to decrement' do
      chicken = ItemWrapper.item(name: 'Chicken', sell_in: 5, quality: 2)
      gildedrose = GildedRose.new([chicken])
      gildedrose.update_quality
      expect(gildedrose.items[0].sell_in).to eq(4)
    end
  end
end
