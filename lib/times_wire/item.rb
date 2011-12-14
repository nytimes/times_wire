module TimesWire
  class Item < Base
    
    attr_reader :section, :title, :abstract, :url, :byline, :item_type, :source, :updated_date, :created_date,
                :published_date, :material_type_facet, :kicker, :subheadline, :multimedia, :des_facets, :org_facets,
                :per_facets, :geo_facets, :related_urls
                
    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end
                    
    def self.create_from_api(params={})
      self.new :section => params['section'],
               :title => params['title'],
               :abstract => params['abstract'],
               :url => params['url'],
               :byline => params['byline'],
               :item_type => params['item_type'],
               :source => params['source'],
               :updated_date => date_parser(params['updated_date']),
               :created_date => date_parser(params['created_date']),
               :published_date => date_parser(params['published_date']),
               :material_type_facet => params['material_type_facet'],
               :kicker => params['kicker'],
               :subheadline => params['subheadline'],
               :multimedia => params['multimedia'],
               :des_facets => params['des_facet'],
               :org_facets => params['org_facet'],
               :per_facets => params['per_facet'],
               :geo_facets => params['geo_facet'],
               :related_urls => params['related_urls']
    end
    
    def self.latest(source="nyt", limit=20)
		  reply = Base.invoke("#{source}/all", {"limit" => limit})
			results = reply['results']
			@items = results.map {|r| Item.create_from_api(r)}
    end
    
    def self.section(source='nyt', section=section, limit=20)
		  reply = Base.invoke("#{source}/#{section}/", {"limit" => limit})
			results = reply['results']
			@items = results.map {|r| Item.create_from_api(r)}      
    end
    
    def self.blog_name(source='nyt', section=section, blog=blog, limit=20)
		  reply = Base.invoke("#{source}/#{section}/", {"limit" => limit})
			results = reply['results'].select{|i| i['blog_name'] == blog}
			@items = results.map {|r| Item.create_from_api(r)}    
    end
  end
end