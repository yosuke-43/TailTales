class ApplicationController < ActionController::Base
    # bootstrapに準備されているフラッシュメッセージを追加
    add_flash_types :success, :info, :warning, :danger 
    before_action :require_login
end
