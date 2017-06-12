# == Schema Information
#
# Table name: articles
#
#  id                 :integer          not null, primary key
#  issue_id           :integer
#  author_id          :integer
#  content            :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  title              :string
#

class Article < ApplicationRecord
    include Searchable

    search_display :sure_title
    search_properties :title, :content

    RELATED = 6

    belongs_to :issue
    has_one :theme, through: :issue
    belongs_to :author, class_name: 'User'
    has_and_belongs_to_many :tags

    validates :issue, presence: { message: 'Cette problématique n\'existe pas' }
    validates :author, presence: { message: 'Aucun auteur n\'est enregistré pour cet article' }
    validates :title, length: { maximum: 60, message: 'Le titre doit contenir %{count} caractères ou moins' }
    validates :content, presence: { message: 'Veuillez écrire un contenu pour l\'article' }

    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/, size: { in: 0..2.megabytes }

    before_save :clear_content

    def comments
        Comment.where(article: self).order(created_at: :desc)
    end

    def approved_comments
        Comment.where(article: self, approved: true).order(created_at: :desc)
    end

    def theme_id
        if self.issue
            if self.issue.theme
                return self.issue.theme.id
            end
        end

        nil
    end

    def main_content
        if self.image.exists? && !self.title.blank?
            self.content
        else
            self.title.blank? ? self.content : '<p>'+self.title+'</p>'+self.content
        end
    end

    def tag
    end

    def related
        related = []
        self.tags.shuffle.each do |tag|
            if related.length < RELATED
                article = tag.articles.where.not(
                    id: related.map{ |a| a.id },
                    issue_id: self.issue.id
                ).take
                related << article unless article.nil?
            else
                break
            end
        end

        related
    end

    def sure_title
        self.title.blank? ? self.issue.content+' '+self.created_at.strftime('%d-%m-%Y') : self.title
    end

    private
        def clear_content
            self.content.gsub! /<p>(?:\s|&nbsp;)*<\/p>/, ''
            self.content.gsub! /(?:\s|&nbsp;)+/, ' '
            self.content.gsub! /(?:\s|&nbsp;)<\/p>/, '</p>'
            self.content.gsub! /<p>(?:\s|&nbsp;)/, '<p>'
            self.content.gsub! /\s([:;,\.\?\!€\$\%])/, '&nbsp;\1'
        end
end
