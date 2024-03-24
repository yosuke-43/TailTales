class Comment < ApplicationRecord
  # 他テーブルとの関係
  belongs_to :user
  belongs_to :board

  # バリデーション
  validates :body, presence: true, length: { maximum: 65_535 }
end
