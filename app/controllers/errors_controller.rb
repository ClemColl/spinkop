class ErrorsController < ApplicationController
	UNKNOWN_ERROR = "Erreur inconnue"
	MESSAGES = {
		http_404: "La page que vous recherchez n'existe pas",
		http_422: "Les modifications que vous souhaitiez effectuer ont été rejetées",
		http_500: "Nous sommes désolés mais quelque chose n'a pas fonctionné...",
		http_unknown: "Nous sommes désolés mais quelque chose n'a pas fonctionné...",
	}

	def http_404
		@code = 404
		http
	end

	def http_402
		@code = 402
		http
	end

	def http_500
		@code = 500
		http
	end

	def http
		@http_error = true
		@error = @code.nil? ? UNKNOWN_ERROR : "Erreur #{@code}"
		key = @code.nil? ? nil : (MESSAGES.key?(:"http_#{@code.to_s}") ? :"http_#{@code.to_s}" : nil)
		@message = key.nil? ? MESSAGES[:http_unknown] : MESSAGES[key]

		render 'http.html.erb'
	end

	def infos
		{
			code: @code,
			error: @error,
			message: @message
		}
	end
end
