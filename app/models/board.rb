class Board < ApplicationRecord
  # バリデーション
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }

  # 他テーブルとの関係性
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
end
