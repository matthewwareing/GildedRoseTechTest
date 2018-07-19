require 'gilded_rose.rb'
# change numeric values after .by to variables
describe GildedRose do
  describe '#update_product' do
    it 'decreases the quality by amount to decrement' do
      chicken = ItemWrapper.item(name: 'Chicken', sell_in: 5, quality: 2)
      gildedrose = GildedRose.new([chicken])
      expect { gildedrose.update_product }.to change { gildedrose.items[0].quality }.by -1
    end

    it 'decreases the sell-in by amount to decrement' do
      chicken = ItemWrapper.item(name: 'Chicken', sell_in: 5, quality: 2)
      gildedrose = GildedRose.new([chicken])
      expect { gildedrose.update_product }.to change { gildedrose.items[0].sell_in }.by -1
    end

    it 'decreases the quality, twice as fast, after sell by date' do
      nickelback = ItemWrapper.item(name: 'Nickelback', sell_in: 0, quality: 10)
      gildedrose = GildedRose.new([nickelback])
      expect { gildedrose.update_product }.to change { gildedrose.items[0].quality }.by -2
    end

    it 'increases the quality of aged brie by amount to increment' do
      agedbrie = ItemWrapper.item(name: 'Aged Brie', sell_in: 10, quality: 30)
      gildedrose = GildedRose.new([agedbrie])
      expect { gildedrose.update_product }.to change { gildedrose.items[0].quality }.by 1
    end
    
    it 'prevents quality going above maximum quality' do
        agedbrie = ItemWrapper.item(name: 'Aged Brie', sell_in: 10, quality: 50)
        gildedrose = GildedRose.new([agedbrie])
        expect { gildedrose.update_product }.to change { gildedrose.items[0].quality }.by 0
    end

    it 'increases aged brie quality if less than maximum amount and sell_in is less than 0' do
      agedbrie = ItemWrapper.item(name: 'Aged Brie', sell_in: -1, quality: 49)
      gildedrose = GildedRose.new([agedbrie])
      expect { gildedrose.update_product }.to change { gildedrose.items[0].quality }.by 1
    end

    it 'Sulfuras neither reduces quality or has to be sold' do
      sulfuras = ItemWrapper.item(name:"Sulfuras, Hand of Ragnaros", sell_in: 10, quality: 50)
      gildedrose = GildedRose.new([sulfuras])
      expect { gildedrose.update_product }.to change { gildedrose.items[0].quality }.by 0
      expect { gildedrose.update_product }.to change { gildedrose.items[0].sell_in }.by 0
    end

    
    it 'increases the quality of backstage pass while sell_in value decreases' do
        backstagepass = ItemWrapper.item(name:"Backstage passes to a TAFKAL80ETC concert", sell_in:15, quality: 10)
        gildedrose = GildedRose.new([backstagepass])
        expect{gildedrose.update_product}.to change { gildedrose.items[0].quality}.by 1
        expect{gildedrose.update_product}.to change { gildedrose.items[0].sell_in}.by -1
    end

    it 'increases backstage pass quality, twice as fast, when 10 days left' do
        backstagepass = ItemWrapper.item(name:"Backstage passes to a TAFKAL80ETC concert", sell_in:10, quality: 10)
        gildedrose = GildedRose.new([backstagepass])
        expect{gildedrose.update_product}.to change { gildedrose.items[0].quality }.by 2
        end

    it 'increases backstage pass quality, three times as fast, when 5 days left' do
        backstagepass = ItemWrapper.item(name:"Backstage passes to a TAFKAL80ETC concert", sell_in:5, quality: 10)
        gildedrose = GildedRose.new([backstagepass])
        expect{gildedrose.update_product}.to change { gildedrose.items[0].quality }.by 3
    end

    it 'decreases backstage pass quality to 0 after concert' do
        backstagepass = ItemWrapper.item(name:"Backstage passes to a TAFKAL80ETC concert", sell_in:0, quality: 40)
        gildedrose = GildedRose.new([backstagepass])
        gildedrose.update_product
        expect(gildedrose.items[0].quality).to eq 0
    end
  end
end
