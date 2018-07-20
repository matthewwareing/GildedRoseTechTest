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

  def pastSellByDate?(item)
    item.sell_in <= 0
  end

  def default_quality_change(item, quality_rate, quality_multiplier)
    if pastSellByDate?(item)
      decrease_quality(item, quality_rate * quality_multiplier)
    else
      decrease_quality(item, quality_rate)
    end
  end
    
  def agedBrie(item)
    increase_quality(item, 1) if item.quality < MAX_ITEM_QUALITY
    item.sell_in -= 1
  end

  def backstagePass(item)
    increase_quality(item, 1) if item.quality < MAX_ITEM_QUALITY
    if item.sell_in < 11
      increase_quality(item, 1)
    end
    if item.sell_in < 6
      increase_quality(item, 1)
    end
    item.sell_in -=1
    decrease_quality(item, item.quality) if pastSellByDate?(item)
  end

  def update_product
    @items.each do |item|
      case item.name 
      when "Sulfuras, Hand of Ragnaros"
        return
      when "Aged Brie" 
        return agedBrie(item)
      when "Backstage passes to a TAFKAL80ETC concert"
        return backstagePass(item)
      else
        default_quality_change(item, 1, 2)
        item.sell_in -= 1
      end
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
