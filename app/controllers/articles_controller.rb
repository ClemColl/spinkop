class ArticlesController < ApplicationController
	before_action :authorize, except: [:show, :index]
	before_action :set_article, only: [:edit, :update, :destroy]
	before_action :set_articles, only: [:index, :new, :create, :edit, :update]
	before_action :set_breadcrump, only: [:index, :edit]

	def show
		respond_to do |format|
			format.json { render json: @article }
		end
	end

	def index
		respond_to do |format|
			format.html { authorize }
			format.json do
				render json: @articles
			end
		end
	end

	def new
		@article = Article.new
		@article.issue = Issue.find(params[:issue_id]) if params.key? :issue_id
	end

	def create
		@article = Article.new article_params
		@article.author = current_user
		set_tags @article

		if @article.save
			flash[:success] = 'L\'article a été enregistré'
			redirect_to articles_path(@article.theme.id, @article.issue.id)
		else
			flash[:error] = 'Impossible d\'enregistrer l\'article'
			render :new
		end
	end

	def edit
	end

	def update
		@article.update article_params
		set_tags @article

		if @article.save
			flash[:success] = 'Les modifications ont été enregistrées'
			render :edit
		else
			flash[:error] = 'Impossible d\'enregistrer les modifications'
			render :edit
		end
	end

	def destroy
		if @article.destroy
			flash[:success] = 'L\'article a bien été supprimé'
		else
			flash[:error] = 'Impossible da supprimer l\'article'
		end

		redirect_to articles_path(@article.theme.id, @article.issue.id)
	end

	private
		def set_article
			@article = Article.find params[:article_id]
		end

		def set_articles
			@issue = action_is?(:index, :new, :create) ? (params.key?(:issue_id) ? Issue.find(params[:issue_id]) : nil) : @article.issue
			if @issue
				@theme = @issue.theme
				@articles = @issue.articles
			end
		end

		def article_params
			params.require(:article).permit(:content, :issue_id, :image, :title)
		end

		def set_tags article
			if params[:article].is_a? ActionController::Parameters
				article.tags = []
				ids = params[:article][:tag_ids]
				if ids.is_a? ActionController::Parameters
					ids.each do |i, id|
						if id.is_a?(Integer) || id.is_a?(String)
							tag = Tag.find_by id: id
							article.tags << tag if tag
						end
					end
				end
			end
		end
end
