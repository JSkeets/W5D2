# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  url        :string
#  content    :text
#  author_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  validates :title, :author_id, presence: true


  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User

  # has_many :subs,
  #   through: :post_subs,
  #   source: :sub,
  #   class_name: :Sub

  has_many :sub, inverse_of: :posts

  has_many :post_subs, inverse_of: :post, dependent: :destroy
  has_many :subs, through: :post_subs, source: :sub



end
