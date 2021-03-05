class CheckListCollection
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations
  LIST_NUM = 3  # 同時にチェックリストを作成する数
  attr_accessor :collection  # ここに作成したチェックリストモデルが格納される
  
  # コレクションをDBに保存するメソッド
  def save
    is_success = true
    ActiveRecord::Base.transaction do
      collection.each do |result|
        # バリデーションを全てかけたいからsave!ではなくsaveを使用
        is_success = false unless result.save
      end
      # バリデーションエラーがあった時は例外を発生させてロールバックさせる
      raise ActiveRecord::RecordInvalid unless is_success
    end
    rescue
      p 'エラー'
    ensure
      return is_success
  end

  # 初期化メソッド
  def initialize(attributes = [])
    if attributes.present?
      self.collection = attributes.map do |value|
        CheckList.new(
          body: value['body'],
          diet_method_id: value['diet_method_id']
        )
      end
    else
      self.collection = LIST_NUM.times.map{ CheckList.new }
    end
  end

  # レコードが存在するか確認するメソッド
  def persisted?
    false
  end
  
end