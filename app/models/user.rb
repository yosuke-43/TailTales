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
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_boards, through: :bookmarks, source: :board #bookmark_boardsは仮想的なテーブルで、bookmarksテーブルを通したboardsテーブルの情報を持っている
  has_many :comments, dependent: :destroy
  has_one :diagnosis, dependent: :destroy

  #独自メソッド------------------------------------------------------------------------------------

  # current_userかどうか確認する
  def own?(object)
    id == object.user_id
  end

  # ブックマークに追加する
  def bookmark(board)
    bookmark_boards << board
  end

  # ブックマークを外す
  def unbookmark(board)
    bookmark_boards.destroy(board)
  end

  # ブックマークしているか確認する
  def bookmark?(board)
    bookmark_boards.include?(board)
  end
  
end
