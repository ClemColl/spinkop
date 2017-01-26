class PagesController < ApplicationController
	def home
		@themes = Theme.all
	end

	def theme
		@theme = Theme.find(params[:id])
		@issues = @theme.issues

		render :theme, params.key?(:partial) ? { layout: false } : {}
	end

	def issue
		@issue = Issue.find(params[:id])
		@theme = @issue.theme
		@articles = @issue.articles

		render :issue, params.key?(:partial) ? { layout: false } : {}
	end
end