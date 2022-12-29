class Author < ApplicationRecord
  include PgSearch::Model
  multisearchable against: :name
end
