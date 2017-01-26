class SessionsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: :create

    before_action :authorize, only: :destroy
    before_action :unauthorize, only: [:new, :create]

	def new
		@user = User.new
	end

	def create
		if session_params[:email] == '' || session_params[:password] == ''
			flash[:error] = 'Veuillez indiquer votre adresse mail et votre mot de passe'
			redirect_to create_session_path
		else
			@user = User.find_by_email(session_params[:email])
			if @user && @user.authenticate(session_params[:password])
				session[:user_id] = @user.id
				flash[:success] = "Bienvenue #{@user.firstname} !"
				redirect_to themes_path
			else
				flash[:error] = 'Identifiants incorrects'
				redirect_to create_session_path
			end
		end
	end

	def destroy
		if current_user
			session.delete :user_id
			flash[:notice] = 'Vous avez été déconnecté'
		end
		redirect_to root_path
	end

	private
		def session_params
			params.require(:user).permit(:email, :password)
		end
end
