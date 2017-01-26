# == Schema Information
#
# Table name: issues
#
#  id         :integer          not null, primary key
#  content    :string
#  theme_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Issue < ApplicationRecord
    include Searchable

    belongs_to :theme
    has_many :articles, dependent: :delete_all

    validates :theme, presence: { message: 'Ce thème n\'existe pas' }
    validates :content, presence: { message: 'Veuillez indiquer un contenu' }

    def to_s
        self.content
    end
end
