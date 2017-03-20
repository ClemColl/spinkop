class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	before_action only: [:index, :new, :create, :destroy] { authorize only: :admin }
	before_action only: [:edit, :update] { authorize only: [:current, :admin] }

	def index
		@users = User.all
	end

	def show
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new user_params
		@user.status = current_user?(is: :admin) ? user_params[:status] : @user.status

		if @user.save
			flash[:success] = 'L\'utilisateur a été créé'
			redirect_to users_path
		else
			flash[:error] = 'Impossible de créer l\'utilisateur'
			render :new
		end
	end

	def edit
	end

	def update
		@user.update user_params
		@user.status = current_user?(is: :admin) ? user_params[:status] : @user.status

		if !@user.admin? && User.admins.length == 1 && @user.id == User.admins.first.id
			flash[:error] = 'La plateforme doit avoir au moins un administrateur'
		else
			if @user.save
				flash[:success] = 'Les modifications ont été enregistrées'
			else
				flash[:error] = 'Impossible d\'enregistrer les modifications'
			end
		end

		render :edit
	end

	def destroy
		if @user.admin? && User.admins.length == 1
			flash[:error] = 'La plateforme doit avoir au moins un administrateur'
		else
			@user.destroy
			flash[:success] = 'L\'utilisateur a été supprimé'
		end

		redirect_to users_path
	end

	private
		def user_params
			params.require(:user).permit(:email, :password, :password_confirmation, :firstname, :lastname, :image, :status)
		end

		def set_user
			@user = User.find(params[:id])
		end
end
