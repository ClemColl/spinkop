module UsersHelper
	def post_user_path user
		action_is?(:new, :create) ? create_user_path : update_user_path(user.id)
	end
end
