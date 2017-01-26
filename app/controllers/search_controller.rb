class SearchController < ApplicationController
	def all
		render json: search(:theme)+search(:issue)+search(:article)
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

		def search record
			record = "#{record}"
			record_class = record.camelize.constantize
			results = record_class.search(input, send("#{record}_params")).to_a

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
			params.permit(:theme_id)
		end

		def article_params
			params.permit(:issue_id)
		end

		def tag_params
			{}
		end
end
