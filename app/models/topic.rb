class Topic < ApplicationRecord
  belongs_to :author
  has_many :posts
end
