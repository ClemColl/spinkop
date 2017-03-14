module IssuesHelper
	def post_issue_path issue
		if @theme.nil?
			create_main_issue_path
		else
			action_is?(:new, :create) ? create_issue_path(@theme.id) : update_issue_path(issue.theme.id, issue.id)
		end
	end

	def timeline_for issue
		theme = issue.theme
		articles = issue.articles

		dot = content_tag :span, nil, style: style(borderColor: theme.rgb_s(-50), background: theme.rgb_s(-50))
		border = content_tag :span, nil, style: style(borderBottomColor: theme.color)

		content_tag :div, class: :timeline, style: style(background: theme.rgb_s(-50)) do
			articles.each.with_index do |article, i|
				content = dot
				date = article.created_at.strftime '%d-%m-%Y'
				content += content_tag :span, border+date, style: style(background: theme.color)

				concat content_tag :span, content, data: { selected: i == 0 ? '' : nil }
			end
		end
	end
end
