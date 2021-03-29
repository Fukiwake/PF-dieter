class Report < ApplicationRecord
  belongs_to :diary, optional: true
  belongs_to :diary_comment, optional: true
  belongs_to :diet_method, optional: true
  belongs_to :diet_method_comment, optional: true
  belongs_to :visitor, class_name: 'Customer', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'Customer', foreign_key: 'visited_id', optional: true
end
