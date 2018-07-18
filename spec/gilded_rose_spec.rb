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
      expect { gildedrose.update_quality }.to change { gildedrose.items[0].sell_in }.by -1
    end

    it 'decreases the quality, twice as fast, after sell by date' do
      nickelback = ItemWrapper.item(name: 'Nickelback', sell_in: 0, quality: 10)
      gildedrose = GildedRose.new([nickelback])
      expect { gildedrose.update_quality }.to change { gildedrose.items[0].quality }.by -2
    end

    it 'increases the quality of aged brie by amount to increment' do
      agedbrie = ItemWrapper.item(name: 'Aged Brie', sell_in: 10, quality: 30)
      gildedrose = GildedRose.new([agedbrie])
      expect { gildedrose.update_quality }.to change { gildedrose.items[0].quality }.by 1
    end
  end
end
