class IndefAPI

	def parse_json(url)
		response = HTTParty.get(url)
		json = JSON.parse(response.body)
		json
	end

	def get_indefs
		stat_url = "https://intense-spire-30880.herokuapp.com/indefinitions.json"
    	indefs = parse_json(stat_url)
    	indefs
	end
end