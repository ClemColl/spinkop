module IssuesHelper
	def post_issue_path issue
		if @theme.nil?
			create_main_issue_path
		else
			action_is?(:new, :create) ? create_issue_path(@theme.id) : update_issue_path(issue.theme.id, issue.id)
		end
	end
end
