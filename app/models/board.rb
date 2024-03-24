class Board < ApplicationRecord
  # バリデーション
  validates :title, presence: true
  validates :body, presence: true

  # 他テーブルとの関係性
  belongs_to :user
end
