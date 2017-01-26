class IssuesController < ApplicationController
	before_action :authorize, except: :index
	before_action :set_issue, only: [:edit, :update, :destroy]
	before_action :set_issues, only: [:index, :new, :create, :edit, :update]
	before_action :set_breadcrump

	def index
		respond_to do |format|
			format.html { authorize }
			format.json do
				render json: @issues
			end
		end
	end

	def new
		@issue = Issue.new
		@issue.theme = Theme.find(params[:theme_id]) if params.key? :theme_id
	end

	def create
		@issue = Issue.new issue_params
		if @issue.save
			flash[:success] = 'La problématique a été enregistrée'
			redirect_to issues_path(@issue.theme.id)
		else
			flash[:error] = 'Impossible d\'enregistrer la problématique'
			render :new
		end
	end

	def edit
	end

	def update
		@issue.update issue_params
		if @issue.save
			flash[:success] = 'Les modifications ont été enregistrées'
			render :edit
		else
			flash[:error] = 'Impossible d\'enregistrer les modifications'
			render :edit
		end
	end

	def destroy
		if @issue.destroy
			flash[:success] = 'La problématique a bien été supprimée'
		else
			flash[:error] = 'Impossible da supprimer la problématique'
		end

		redirect_to issues_path(@issue.theme.id)
	end

	private
		def set_issue
			@issue = Issue.find params[:issue_id]
		end

		def set_issues
			@theme = Theme.find params[:theme_id] if @theme.nil? && params.key?(:theme_id)
			@issues = @theme.issues if @theme
		end

		def issue_params
			params.require(:issue).permit(:content, :theme_id)
		end
end
