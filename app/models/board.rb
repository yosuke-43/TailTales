class Board < ApplicationRecord
  # アップローダークラスとカラムを紐づける
  mount_uploader :board_image, BoardImageUploader

  # バリデーション
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }

  # 他テーブルとの関係性
  belongs_to :user
  belongs_to :dog, optional: true
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy

  # ransackを使用するための設定
  def self.ransackable_attributes(_auth_object = nil)
    %w[body created_at dog_id id id_value title updated_at user_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[bookmarks comments dog user]
  end
end
