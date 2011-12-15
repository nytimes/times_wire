module TimesWire
  class Section < Base
    
    attr_reader :name
    
    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end
    
    def self.create_from_api(params={})
      self.new :name => params['section'],
               :display_name => params['display_name']
    end
    
    def self.all
		  reply = Base.invoke("section-list", {"limit" => 20})
			results = reply['results']
			sections = results.map {|r| Section.create_from_api(r)}
    end
    
  end
end
