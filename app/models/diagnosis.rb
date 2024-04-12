class Diagnosis < ApplicationRecord
  belongs_to :user
  # 診断結果を配列で保存するカラムを追加する予定
end
