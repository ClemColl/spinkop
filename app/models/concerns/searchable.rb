module Searchable extend ActiveSupport::Concern
	DEFAULT_LIMIT = 10
	DEFAULT_PROPERTIES = [:content]

	included do
		def self.search input, options = nil
			input = {input: input } unless input.is_a? Hash
			input = input.merge(options) if options.is_a? Hash
			params = []
			query = ''

			search_properties.each do |property|
				current_input = input[input.key?(property) ? property : :input]
				unless current_input.nil?
					query += "LOWER(#{property}) LIKE ? OR "
					params << "%#{I18n.transliterate(current_input).downcase}%"
				end
			end

			input.except!(*(search_properties + [:input]))
			if query.length != 0
				query = '('+query.gsub(/ OR \z/, '')+')'
				query += ' AND ' if input.length != 0
			end

			input.each do |property, value|
				query += "#{property} = ? AND "
				params << "#{value}"
			end

			query.gsub!(/ AND \z/, '')

			where(query, *params).limit(search_limit)
		end

		def self.search_limit limit = nil
			if limit.nil?
				@search_limit.nil? ? DEFAULT_LIMIT : @search_limit
			else
				@search_limit = limit.to_i
			end
		end

		def self.search_properties *properties
			if properties.length == 0
				@search_properties.nil? ? DEFAULT_PROPERTIES : @search_properties
			else
				@search_properties = []
				properties.flatten.each do |property|
					@search_properties << :"#{property}" unless property.nil?
				end
				@search_properties = nil if @search_properties.length == 0
			end
		end

		def self.search_property property = nil
			if property.nil?
				search_properties[0]
			else
				@search_properties = [:"#{property}"]
			end
		end

		def self.search_display display = nil
			if display.nil?
				@search_display.nil? ? search_property : @search_display
			else
				@search_display = :"#{display}"
			end
		end
	end

    module ClassMethods
		# attr_reader :search_limit
		# attr_reader :search_properties

		private
			# def search_limit limit
			# 	@search_limit = limit.nil? ? nil : limit.to_i
			# end
			#
			# def search_property property
			# 	@search_properties = property.nil? ? nil : [:"#{property}"]
			# end
			#
			# def search_properties *properties
			# 	@search_properties = []
			# 	properties.flatten.each do |property|
			# 		@search_properties << :"#{property}" unless property.nil?
			# 	end
			# 	@search_properties = nil if @search_properties.length == 0
			# end
    end
end
