class Diagnosis < ApplicationRecord
  belongs_to :user
  #診断結果を配列で保存するカラムを追加する予定

  #回答内容から診断結果を作成するメソッド
  def diagnosis_result()
  end

end
