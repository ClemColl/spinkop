class ThemesController < ApplicationController
	before_action :authorize
	before_action :set_theme, only: [:edit, :update, :destroy]
	before_action :set_breadcrump, only: [:index, :edit]

	def index
		@themes = Theme.all
	end

	def new
		@theme = Theme.new
	end

	def create
		@theme = Theme.new theme_params
		if @theme.save
			flash[:success] = 'Le thème a été enregistré'
			redirect_to themes_path
		else
			flash[:error] = 'Impossible d\'enregistrer le thème'
			render :new
		end
	end

	def edit
	end

	def update
		@theme.update theme_params
		if @theme.save
			flash[:success] = 'Les modifications ont été enregistrées'
			render :edit
		else
			flash[:error] = 'Impossible d\'enregistrer les modifications'
			render :edit
		end
	end

	def destroy
		if @theme.destroy
			flash[:success] = 'Le thème a bien été supprimé'
		else
			flash[:error] = 'Impossible de supprimer le thème'
		end

		redirect_to themes_path
	end

	private
		def set_theme
			@theme = Theme.find(params[:theme_id])
		end

		def theme_params
			params.require(:theme).permit(:name, :color, :image)
		end
end
