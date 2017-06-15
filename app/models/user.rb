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
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  status             :integer
#

class User < ApplicationRecord
	has_many :articles

	has_secure_password

	enum status: {
		erasmus: 1,
		contributor: 2,
		admin: 3
	}

	validates :password, presence: { message: 'Veuillez indiquer un mot de passe' }, confirmation: { message: 'La confirmation ne correspond pas' }, length: { minimum: 6, message: 'Votre mot de passe doit comprendre au moins %{count} caractères' }, on: :create
    validates :email, presence: { message: 'Veuillez indiquer votre adresse email' }, email: { message: 'Adresse email invalide' }, uniqueness: { message: 'Cette adresse email est déjà utilisée' }
    validates :firstname, presence: { message: 'Veuillez indiquer votre prénom' }
	validates :lastname, presence: { message: 'Veuillez indiquer votre nom' }

	def select_status
		[self.class.statuses.keys.map { |s| [s.to_s.humanize, s] }, { selected: self.status }]
	end

	def self.admins
		where status: :admin
	end

	def self.erasmuses
		where status: :erasmus
	end

	def fullname
		self.firstname+' '+self.lastname
	end
end
