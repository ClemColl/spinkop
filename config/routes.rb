Rails.application.routes.draw do
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	scope '/issues' do
		get '/new' => 'issues#new', as: :new_main_issue
		post '/new' => 'issues#create', as: :create_main_issue
	end

	scope '/articles' do
		get '/new' => 'articles#new', as: :new_main_article
		post '/new' => 'articles#create', as: :create_main_article
	end

	scope '/tags' do
		get '/' => 'tags#index', as: :tags
		get '/new' => 'tags#new', as: :new_tag
		post '/new' => 'tags#create', as: :create_tag
		get '/:tag_id/edit' => 'tags#edit', as: :edit_tag
		patch '/:tag_id/edit' => 'tags#update', as: :update_tag
		get '/:tag_id/destroy' => 'tags#destroy', as: :destroy_tag
	end

	scope '/themes' do
		get '/' => 'themes#index', as: :themes
		get '/new' => 'themes#new', as: :new_theme
		post '/new' => 'themes#create', as: :create_theme
		get '/:theme_id/edit' => 'themes#edit', as: :edit_theme
		patch '/:theme_id/edit' => 'themes#update', as: :update_theme
		get '/:theme_id/destroy' => 'themes#destroy', as: :destroy_theme

		scope '/:theme_id' do
			get '/' => 'issues#index', as: :issues
			get '/new' => 'issues#new', as: :new_issue
			post '/new' => 'issues#create', as: :create_issue
			get '/:issue_id/edit' => 'issues#edit', as: :edit_issue
			patch '/:issue_id/edit' => 'issues#update', as: :update_issue
			get '/:issue_id/destroy' => 'issues#destroy', as: :destroy_issue

			scope '/:issue_id' do
				get '/' => 'articles#index', as: :articles
				get '/new' => 'articles#new', as: :new_article
				post '/new' => 'articles#create', as: :create_article
				get '/:article_id/edit' => 'articles#edit', as: :edit_article
				patch '/:article_id/edit' => 'articles#update', as: :update_article
				get '/:article_id/destroy' => 'articles#destroy', as: :destroy_article
				# get '/:article_id' => 'articles#show', as: :article
			end
		end
	end


	scope '/users' do
		get '/' => 'users#index', as: :users
		get '/new' => 'users#new', as: :new_user
		post '/new' => 'users#create', as: :create_user
		get '/:id' => 'users#show', as: :show_user
		get '/:id/edit' => 'users#edit', as: :edit_user
		patch '/:id/edit' => 'users#update', as: :update_user
		get '/:id/destroy' => 'users#destroy', as: :destroy_user
	end

	scope '/search' do
		get '/' => 'search#all', as: :search
		get '/themes' => 'search#themes', as: :themes_search
		get '/issues' => 'search#issues', as: :issues_search
		get '/articles' => 'search#articles', as: :articles_search
		get '/tags' => 'search#tags', as: :tags_search
	end

	get '/admin', to: redirect('/themes'), status: 301, as: :admin

	get '/login' => 'sessions#new', as: :new_session
	post '/login' => 'sessions#create', as: :create_session
	get '/logout' => 'sessions#destroy', as: :destroy_session

	get '/theme/:id' => 'pages#theme', as: :theme_page
	get '/issue/:id' => 'pages#issue', as: :issue_page

	root to: 'pages#home'

	match '*path' => 'errors#http_404', via: :all
end
