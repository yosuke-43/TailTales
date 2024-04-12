crumb :root do
  link "Home", root_path
end

crumb :new_diagnosis do
  link "診断", new_diagnosis_path
  parent :root
end

crumb :diagnosis_result do
  link "診断結果", new_diagnosis_path
  parent :new_diagnosis
end

crumb :dogs do
  link "犬種一覧", dogs_path
  parent :root
end

crumb :dog_show do |dog|
  link "犬種詳細_#{dog.breed}", dog_path(dog)
  parent :dogs
end

crumb :login do
  link "ログイン", login_path
  parent :root
end

crumb :user_setup do
  link 'ユーザー登録', new_user_path
  parent :login
end

crumb :board_index do
  link '投稿一覧', boards_path
  parent :root
end

crumb :bookmark_board_index do
  link 'お気に入り投稿一覧', bookmarks_boards_path
  parent :board_index
end

crumb :new_board do
  link '投稿作成', new_board_path
  parent :board_index
end

crumb :board_show do |board|
  link '投稿詳細', board_path(board)
  parent :board_index
end

crumb :board_edit do |board|
  link '投稿編集', edit_board_path(board)
  parent :board_show, board
end
