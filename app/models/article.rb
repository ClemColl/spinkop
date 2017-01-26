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

    def theme_id
        if self.issue
            if self.issue.theme
                return self.issue.theme.id
            end
        end

        nil
    end

    def tag
    end
end
