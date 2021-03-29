class DiaryFavorite < ApplicationRecord
  belongs_to :diary
  belongs_to :customer
end
