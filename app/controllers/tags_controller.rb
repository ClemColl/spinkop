class TagsController < ApplicationController
	before_action { authorize only: [:admin, :contributor] }
	before_action :set_tag, only: [:edit, :update, :destroy]
	before_action :set_breadcrump, only: [:index, :edit]

	def index
		@tags = Tag.all
	end

	def new
		@tag = Tag.new
	end

	def create
		@tag = Tag.new tag_params
		if @tag.save
			flash[:success] = 'Le tag a été enregistré'
			redirect_to tags_path
		else
			flash[:error] = 'Impossible d\'enregistrer le tag'
			render :new
		end
	end

	def edit
	end

	def update
		@tag.update tag_params
		if @tag.save
			flash[:success] = 'Les modifications ont été enregistrées'
			render :edit
		else
			flash[:error] = 'Impossible d\'enregistrer les modifications'
			render :edit
		end
	end

	def destroy
		if @tag.destroy
			flash[:success] = 'Le tag a bien été supprimé'
		else
			flash[:error] = 'Impossible de supprimer le tag'
		end

		redirect_to tags_path
	end

	private
		def set_tag
			@tag = Tag.find(params[:tag_id])
		end

		def tag_params
			params.require(:tag).permit(:name)
		end
end
