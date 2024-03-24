class User < ApplicationRecord
  authenticates_with_sorcery!

  # 認証関係のバリデーション
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 3}, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  # 他テーブルとの関係性
  has_many :boards, dependent: :destroy

  #独自メソッド
  # current_userかどうか確認する
  def own?(object)
    id == object.user_id
  end
end
