class UsersController < ApplicationController
    # edit、update、destroyアクション実行前にset_userメソッドを実行し、ユーザーの特定をする
    before_action :set_user, only: [ :edit, :update, :destroy ]

    def new
        # ユーザー登録のためのインスタンスを作成
        @user = User.new
    end

    def create
        # フォームで入力された値を格納
        @user = User.new(user_params)
        if @user.save
            # 登録に成功した場合、セッションにuser.idを保持
            log_in @user
            # 利用者一覧へリダイレクト・メッセージ表示をする
            redirect_to useroffacilitys_path, success: "アカウントが作成されました。"
        else
            # 登録に失敗した場合、アカウント作成画面へ遷移し、メッセージを表示する
            flash.now[:danger] = "アカウント登録に失敗しました。"
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        if @user.update(user_params)
            # 更新に成功した場合、編集画面へリダイレクトし、メッセージを表示する
            redirect_to request.referer, success: "アカウント情報を編集しました。"
        else
            # 更新に失敗した場合、編集画面へ遷移し、メッセージを表示
            flash.now[:danger] = "アカウント情報編集に失敗しました。"
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        # 削除
        @user.destroy
        # ログイン画面に遷移し、メッセージを表示する
        redirect_to login_path, danger: "退会しました。"
    end

    private
        # パラメータで渡されたidをもとにユーザーを検索
        def set_user
            @user = User.find(params[:id])
        end

        # ユーザーのパラメータ
        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end
end