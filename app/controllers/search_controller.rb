class SearchController < ApplicationController
	def all
		render json: [:theme, :issue, :article, :tag].map{ |r| search r, 3 }.flatten
	end

	def themes
		render json: search(:theme)
	end

	def issues
		render json: search(:issue)
	end

	def articles
		render json: search(:article)
	end

	def tags
		render json: search(:tag)
	end

	private
		def input
			params[:q]
		end

		def search record, limit = nil
			record = record.to_s
			record_class = record.camelize.constantize
			options = send("#{record}_params")
			options.merge! limit: limit if limit.is_a? Fixnum
			results = record_class.search(input, options).to_a

			results.map do |result|
				{
					id: result.id,
					content: result.send(record_class.search_display),
					theme_id: result.respond_to?(:theme_id) ? result.theme_id : nil,
					issue_id: result.respond_to?(:issue_id) ? result.issue_id : nil,
					type: record
				}
			end
		end

		def theme_params
			{}
		end

		def issue_params
			params.key?(:theme_id) ? { theme_id: params[:theme_id] } : {}
		end

		def article_params
			params.key?(:issue_id) ? { issue_id: params[:issue_id] } : {}
		end

		def tag_params
			{}
		end
end
