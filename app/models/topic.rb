class Topic < ApplicationRecord
  belongs_to :author
  has_many :posts

  include PgSearch::Model
  multisearchable against: :topic
end
