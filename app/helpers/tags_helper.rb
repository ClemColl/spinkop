module TagsHelper
	def post_tag_path tag
		action_is?(:new, :create) ? create_tag_path : update_tag_path(tag.id)
	end
end
