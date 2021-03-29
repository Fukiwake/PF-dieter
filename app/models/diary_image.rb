class DiaryImage < ApplicationRecord
  belongs_to :diary
  attachment :image
end
