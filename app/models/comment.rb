# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  article_id :integer
#  author_id  :integer
#  content    :text
#  approved   :boolean          default("false")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
    belongs_to :article
    belongs_to :author, class_name: 'User'
    has_one :issue, through: :article
    has_one :theme, through: :issue

    validates :content, presence: true
end
