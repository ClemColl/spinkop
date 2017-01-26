# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#

class Tag < ApplicationRecord
	include Searchable

	has_and_belongs_to_many :articles
	search_property :slug
	search_display :name
	before_save :normalize_name
	before_save :update_slug

	validates :name, presence: { message: 'Veuillez indiquer le nom du tag' }

	private
		def normalize_name
			self.name = self.name.downcase.titleize
		end

		def update_slug
			self.slug = I18n.transliterate(self.name).downcase
		end
end
