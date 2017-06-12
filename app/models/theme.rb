# == Schema Information
#
# Table name: themes
#
#  id                 :integer          not null, primary key
#  name               :string
#  color              :string
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Theme < ApplicationRecord
	include Searchable

	has_many :issues, dependent: :delete_all
	has_many :articles, through: :issues, dependent: :delete_all

	search_property :name

	validates :name, presence: { message: 'Veuillez indiquer le nom du thème' }
    validates :color, presence: { message: 'Veuillez indiquer une couleur' }, format: { with: /\A(?:#[abcdef0-9]{6})\z/i, message: 'Veuillez indiquer une couleur au format hexadécimal' }


	def to_s
		self.name
	end

	def rgb delta = nil
		rgb = [
			self.color[1..2].hex,
			self.color[3..4].hex,
			self.color[5..6].hex
		]

		if delta.is_a? Integer
			rgb.map! do |c|
				c += delta
				c = c < 0 ? 0 : (c > 255 ? 255 : c)
			end
		end

		rgb
	end

	def rgb_s delta = nil
		'rgb('+self.rgb(delta).join(',')+')'
	end

	def issues_label
		issues.length.to_s+' problématique'+(issues.length > 1 ? 's' : '')
	end

	def articles_label
		articles.length.to_s+' article'+(articles.length > 1 ? 's' : '')
	end

	def gradient alpha1 = 1, alpha2 = 1
		[
			'rgba('+self.rgb.join(',')+','+alpha1.to_s+')',
			'rgba('+self.rgb(-50).join(',')+','+alpha2.to_s+')'
		]
	end
end
