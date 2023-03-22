module SessionsHelper
    # ログイン時にセッションIDを付与する
    def log_in(user)
        session[:user_id] = user.id
    end

    # 現在ログインしているユーザーの情報を取得する
    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    # ユーザーがログインしているかどうかをチェックする
    def logged_in?
        !current_user.nil?
    end

    # ログインしていないユーザーがアクセスしてきた場合、ログイン画面にリダイレクトさせる
    def require_user
        if !logged_in?
            flash[:alert] = "ログインしてください。"
            redirect_to login_path
        end
    end

    # ログアウトする（セッション情報を削除する）
    def log_out
        session.delete(:user_id)
        @current_user = nil
    end
end
