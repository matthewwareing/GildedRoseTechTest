class GildedRose
  MAX_ITEM_QUALITY = 50
  attr_reader :items
  def initialize(items)
    @items = items
  end

  def decrease_quality(item, amount)
    item.quality -= amount
  end

  def increase_quality(item, amount)
    item.quality += amount
  end

  def update_quality(item)
    if (item.name != 'Aged Brie') && (item.name != 'Backstage passes to a TAFKAL80ETC concert')
      if item.quality > 0
        decrease_quality(item, 1) if item.name != 'Sulfuras, Hand of Ragnaros'
      end
    else
      if item.quality < MAX_ITEM_QUALITY
        increase_quality(item, 1)
        if item.name == 'Backstage passes to a TAFKAL80ETC concert'
          if item.sell_in < 11
            increase_quality(item, 1) if item.quality < MAX_ITEM_QUALITY
          end
          if item.sell_in < 6
            increase_quality(item, 1) if item.quality < MAX_ITEM_QUALITY
          end
        end
      end
    end
  end

  def update_sell_in(item)
    item.sell_in = item.sell_in - 1 if item.name != 'Sulfuras, Hand of Ragnaros'

    if item.sell_in < 0
      if item.name != 'Aged Brie'
        if item.name != 'Backstage passes to a TAFKAL80ETC concert'
          if item.quality > 0
            if item.name != 'Sulfuras, Hand of Ragnaros'
              decrease_quality(item, 1)
            end
          end
        else
          decrease_quality(item, item.quality)
        end
      else
        increase_quality(item, 1) if item.quality < MAX_ITEM_QUALITY
      end
    end
  end

  def update_product
    @items.each do |item|
      update_quality(item)
      update_sell_in(item)
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

module ItemWrapper
  def self.item(args)
    Item.new(args[:name],
             args[:sell_in],
             args[:quality])
  end
end
