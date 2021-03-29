class CheckListDiary < ApplicationRecord
  belongs_to :diary, optional: true
  belongs_to :check_list, optional: true
end
