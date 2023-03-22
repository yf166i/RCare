class ApplicationController < ActionController::Base
    # SessionsHelperをコントローラで使用可能にする
    include SessionsHelper
    # メッセージ用のclassを追加
    add_flash_types :success, :info, :warning, :danger
end
