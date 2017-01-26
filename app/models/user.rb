# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string
#  password_digest    :string
#  firstname          :string
#  lastname           :string
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  admin              :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class User < ApplicationRecord
	has_many :articles

	has_secure_password

	has_attached_file :image, styles: { medium: '300x300#', thumb: '50x50#' }, default_url: '/default/user/image.svg'

	validates :password, presence: { message: 'Veuillez indiquer un mot de passe' }, confirmation: { message: 'La confirmation ne correspond pas' }, length: { minimum: 6, message: 'Votre mot de passe doit comprendre au moins %{count} caractères' }, on: :create
    validates :email, presence: { message: 'Veuillez indiquer votre adresse email' }, email: { message: 'Adresse email invalide' }, uniqueness: { message: 'Cette adresse email est déjà utilisée' }
    validates :firstname, presence: { message: 'Veuillez indiquer votre prénom' }
	validates :lastname, presence: { message: 'Veuillez indiquer votre nom' }

	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/, size: { in: 0..2.megabytes }

	def self.admins
		where admin: true
	end
end