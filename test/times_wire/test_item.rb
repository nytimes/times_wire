class TestTimesWire::TestItem < Test::Unit::TestCase
	include TimesWire
	
	context "create single Item" do
		setup do
		  reply = Base.invoke('', {"url" => "http://www.nytimes.com/2010/12/17/world/asia/17sanger.html"})
			@result = reply['results'].first
			@item = Item.create_from_api(@result)
		end
		
		should "return an object of the Item type" do
			assert_kind_of(Item, @item)
		end
  end

	context "create list of items from NYT only" do
		setup do
		  @items = Item.latest('nyt')
		end
		
		should "return an array of 20 objects of the Item type from the NYT alone" do
		  assert_equal(20, @items.size)
			assert_kind_of(Item, @items.first)
			assert_equal(["The New York Times"], @items.map {|i| i.source}.uniq)
		end
  end
  
  context "create list of 15 items from IHT only" do
		setup do
		  @items = Item.latest('iht', 15)
		end

		should "return an array of 15 objects of the Item type from the IHT alone" do
		  assert_equal(15, @items.size)
			assert_kind_of(Item, @items.first)
			assert_equal(["International Herald Tribune"], @items.map {|i| i.source}.uniq)
		end
  end
  
end