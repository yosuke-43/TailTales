class Question < ApplicationRecord
  # 他のテーブルとの関係性
  has_many :answers, dependent: :destroy
end
