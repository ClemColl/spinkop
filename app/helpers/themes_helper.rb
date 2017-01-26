module ThemesHelper
	def post_theme_path theme
		action_is?(:new, :create) ? create_theme_path : update_theme_path(theme.id)
	end
end
