class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActionController::UnknownController, with: :not_found
    rescue_from ActionController::RoutingError, with: :not_found

    private
        def current_user
            if session[:user_id]
                user = User.find_by(id: session[:user_id])
                if user
                    return @current_user ||= user
                else
                    session.delete :user_id
                end
            end
            nil
        end
        helper_method :current_user

        def current_user?
            current_user ? true : false
        end
        helper_method :current_user?

        def is_current_user? user
            return user.id == current_user.id if current_user?
            false
        end
        helper_method :is_current_user?

        def is_admin?
            return false unless current_user?
            return false unless current_user.admin
            true
        end
        helper_method :is_admin?

        def is_admin_or_current_user? user
            is_admin? || is_current_user?(user)
        end
        helper_method :is_admin_or_current_user?

        def authorize message = nil, destination = nil, type = :notice
            unless current_user?
                flash[type] = message unless message == nil
                set_destination destination unless destination == nil

                redirect_to create_session_path
                false
            else
                true
            end
        end

        def authorize_admin message = nil, destination = nil, type = :notice
            unless is_admin?
                flash[type] = message unless message == nil
                set_destination destination unless destination == nil

                redirect_to create_session_path
                false
            else
                true
            end
        end

        def unauthorize message = nil, destination = nil, type = :notice
            if current_user
                flash[type] = message unless message == nil
                session[:destination] = destination unless destination == nil

                redirect_to root_path
                false
            else
                true
            end
        end

        def controller_is? *options
    		options.flatten!
    		options.map{ |option| option.to_s }.include? controller_name
    	end
        helper_method :'controller_is?'

    	def action_is? *options
    		options.flatten!
    		options.map{ |option| option.to_s }.include? action_name
    	end
        helper_method :'action_is?'

        def not_found
            @not_found = true
            @errors_controller = ErrorsController.new
            @errors_controller.request = request
            @errors_controller.response = response
            @errors_controller.http_404
        end

        def render_not_found
            not_found

            @code = @errors_controller.infos[:code]
            @error = @errors_controller.infos[:error]
            @message = @errors_controller.infos[:message]

            render 'errors/http.html.erb'
        end

        def set_breadcrump
            @breadcrump = []
            @breadcrump << ['Tous les thèmes', themes_path] unless @theme.nil? && !(controller_is?(:themes) && action_is?(:index))
            @breadcrump << [@theme.name, issues_path(@theme.id)] unless @theme.nil?
            @breadcrump << [@issue.content, articles_path(@theme.id, @issue.id)] unless @issue.nil?
            @breadcrump << [@article.created_at, edit_article_path(@theme.id, @issue.id, @article.id)] unless @article.nil?

            @breadcrump = nil if @breadcrump.length == 0
        end
end
