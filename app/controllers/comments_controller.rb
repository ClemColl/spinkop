class CommentsController < ApplicationController
    before_action only: [:index] { authorize only: :admin }
    before_action only: [:create] { authorize only: [:erasmus, :admin] }
    before_action :set_comment, only: [:edit, :update, :destroy, :approve]
    before_action :set_article, except: :index
    before_action only: [:edit, :update, :destroy] { authorize only: [@comment.author, :admin] }
    before_action only: [:approve] { authorize only: [:contributor, :admin] }

    def index
        @comments = Comment.where approved: false
    end

    def edit
    end

    def create
        @comment = Comment.new comment_params
        @comment.author = current_user
        @comment.article = @article

        if @comment.save
            flash[:success] = 'Votre commentaire est en attente de validation'
        else
            flash[:error] = 'Impossible d\'ajouter le commentaire'
        end
        redirect_to issue_page_path(@comment.article.issue)
    end

    def update
        if comment_params[:content] == @comment.content
            flash[:notice] = 'Vous n\'avez apporté aucune modification à votre commentaire'
            redirect_to issue_page_path(@comment.article.issue)
        elsif @comment.update comment_params.to_h.merge(approved: false)
            flash[:success] = 'Votre commentaire modifé est en attente de validation'
            redirect_to issue_page_path(@comment.article.issue)
        else
            flash[:error] = 'Impossible d\'enregistrer les modifications'
            render :edit
        end

    end

    def destroy
        @comment.destroy
        flash[:notice] = 'Votre commentaire a bien été supprimé'
        redirect_to issue_page_path(@comment.article.issue)
    end

    def approve
        @comment.update approved: true
        flash[:success] = 'Le commentaire a été approuvé'
        redirect_to comments_path
    end

    private
        def set_article
            @article = action_is?(:new, :create) ? Article.find(params[:article_id]) : @comment.article
        end

        def set_comment
            @comment = Comment.find params[:id]
        end

        def comment_params
            params.require(:comment).permit(:content)
        end
end
