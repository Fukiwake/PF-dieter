class ChangeColumnOfCheckListToNull < ActiveRecord::Migration[5.2]
  def up
    change_column_null :check_lists, :diet_method_id, true
  end

  def down
    change_column_null :check_lists, :diet_method_id, false
  end
end
