class DiagnosesController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :result]

  def new
    @questions = Question.all.includes(:answers).order(id: :asc)
  end

  def create
    user_answers_hash = params[:answers]
    user_answers_array = user_answers_hash.values
    redirect_to diagnoses_result_path(user_answers: user_answers_array)
  end

  def result
    user_answers_array = params[:user_answers].map(&:to_i)

    # ユーザーの回答（answer_id）と、DogAnswerRelationship の answer_id が合致するレコードを全て取得する
    matching_records = DogAnswerRelationship.none  # 空のActiveRecordリレーションを作成する
    user_answers_array.each do |user_answer|
      matching_records_for_answer = DogAnswerRelationship.where(answer_id: user_answer)
      matching_records = matching_records.or(matching_records_for_answer)  # 合致するレコードを追加
    end

    # 取得したレコードに対して dog_id 毎にカウントを取る,格納されている形はハッシュで、{dog_id: count}の形で格納されている
    count_by_dog_id = matching_records.group(:dog_id).count

    # match_dogに該当するdog_idとカウントをハッシュ形式で格納していく
    dog_with_temp_count_array = []
    # attr_accessorの:temp_countにマッチした回答数を格納する
    count_by_dog_id.each do |dog_id, match_count|
      dog_with_temp_count = Dog.find_by(id: dog_id)
      dog_with_temp_count.temp_count = match_count
      dog_with_temp_count_array << dog_with_temp_count
    end

    # 最大のtemp_count(回答マッチ数)の値を取得する
    max_temp_count = dog_with_temp_count_array.map(&:temp_count).max
    # 最大のtemp_countを持つ犬種のみに絞る
    @recommend_dogs = dog_with_temp_count_array.select { |dog| dog.temp_count == max_temp_count }
    # シェア用に名前だけにする
    @share_recommend_dogs = @recommend_dogs.pluck(:breed).map { |breed| "「#{breed}」" }.join("")
  end

end
