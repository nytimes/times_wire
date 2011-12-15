class TestTimesWire::TestSection < Test::Unit::TestCase
	include TimesWire
	
	context "list all Sections" do
		setup do
		  reply = Base.invoke("section-list", {"limit" => 20})
			results = reply['results']
			@sections = results.map {|r| Section.create_from_api(r)}
		end
		
		should "return objects of the Section type" do		  
			assert_kind_of(Section, @sections.first)
		end
  end
end