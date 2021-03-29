class Batch::ExpReset
  def self.day_exp_reset
    Customer.update(day_exp: 0)
    p "1日の合計経験値をリセットしました"
  end

  def self.week_exp_reset
    Customer.update(week_exp: 0)
    p "1週間の合計経験値をリセットしました"
  end

  def self.month_exp_reset
    Customer.update(month_exp: 0)
    p "1ヶ月の合計経験値をリセットしました"
  end
end
