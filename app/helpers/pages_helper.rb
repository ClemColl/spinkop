module PagesHelper
	def theme_bubbles themes, &block
		i = 0
		bubbles = ''

		[3, 4, 5, 4, 3].each do |amount|
			bubbles += '<div><div class="theme" data-empty></div>'
			j = 0
			while j < amount-2 && i < themes.length
				bubbles += capture {block.call(themes[i]).html_safe}
				i += 1
				j += 1
			end
			bubbles += '<div class="theme" data-empty></div></div>'
		end

		bubbles.html_safe
	end
end
