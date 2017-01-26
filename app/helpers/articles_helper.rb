module ArticlesHelper
	def post_article_path article
		if @theme.nil? || @issue.nil?
			create_main_article_path
		else
			action_is?(:new, :create) ? create_article_path(@theme.id, @issue.id) : update_article_path(@theme.id, @issue.id, article.id)
		end
	end
end
