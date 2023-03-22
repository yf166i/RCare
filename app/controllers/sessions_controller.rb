class SessionsController < ApplicationController
  def new
  end

  def create
    # 小文字に変換したメールアドレスでユーザーを検索
    user = User.find_by(email: params[:session][:email].downcase)
    # ユーザーの認証
    if user && user.authenticate(params[:session][:password])
      # 認証に成功した場合、セッションにuser.idを保持
      log_in(user)
      # 利用者一覧へリダイレクトし、メッセージ表示をする
      redirect_to useroffacilitys_path, success: "ログインしました。"
    else
      # 認証に失敗した場合、ログイン画面へ遷移し、メッセージを表示する
      flash.now[:danger] = "ログインに失敗しました"
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    # セッションからuser_idを削除し、ログアウト
    log_out
    # ログイン画面へリダイレクト
    redirect_to login_path
  end
end
