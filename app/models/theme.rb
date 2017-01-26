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

	has_attached_file :image, styles: { medium: '200x200#', cover: '1000x>' }, default_url: '/default/theme/image/:style.jpg'

	validates :name, presence: { message: 'Veuillez indiquer le nom du thème' }
    validates :color, presence: { message: 'Veuillez indiquer une couleur' }, format: { with: /\A(?:#[abcdef0-9]{6})\z/i, message: 'Veuillez indiquer une couleur au format hexadécimal' }

	validates_attachment_presence :image
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/, size: { in: 0..2.megabytes }

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
