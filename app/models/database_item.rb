class DatabaseItem < ApplicationRecord
  validates :integer, uniqueness: true
end
