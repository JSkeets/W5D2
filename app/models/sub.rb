# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :string
#  moderator_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ApplicationRecord

  belongs_to :moderator,
    primary_key: :id,
    foreign_key: :moderator_id,
    class_name: :User



  has_many :post_subs, inverse_of: :sub, dependent: :destroy
   has_many :posts, through: :post_subs, source: :post

  validates :description,:moderator_id,presence: true
  validates :title,uniqueness: true, presence: true
end
