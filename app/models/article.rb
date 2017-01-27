# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  issue_id   :integer
#  author_id  :integer
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Article < ApplicationRecord
    include Searchable

    belongs_to :issue
    has_one :theme, through: :issue
    belongs_to :author, class_name: 'User'
    has_and_belongs_to_many :tags

    has_attached_file :image, styles: { cover: '1000x>' }

    validates :issue, presence: { message: 'Cette problématique n\'existe pas' }
    validates :author, presence: { message: 'Aucun auteur n\'est enregistré pour cet article' }
    validates :content, presence: { message: 'Veuillez écrire un contenu pour l\'article' }

    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/, size: { in: 0..2.megabytes }

    before_save :clear_content

    def theme_id
        if self.issue
            if self.issue.theme
                return self.issue.theme.id
            end
        end

        nil
    end

    def header_content
        header = self.content.gsub /\A([^\.,\?\!]{40,195}[\.,\?\!]).*\z/m, '\1'
        header.length > 195 ? header[0..196]+'...' : header
    end

    def main_content
        self.content[self.header_content.length-(self.header_content[-3..-1] == '...' ? 3 : 0)..-1]
    end

    def tag
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
