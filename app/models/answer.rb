class Answer < ApplicationRecord
  # 他テーブルとの関係性
  belongs_to :question
  has_many :dog_answer_relationships, dependent: :destroy
end
