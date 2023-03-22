class UseroffacilitysController < ApplicationController
    # edit、update、destroyアクション実行前にset_useroffacilityメソッドを実行し、利用者の特定をする
    before_action :set_useroffacility, only: [ :edit, :update, :destroy ]

    def index
        # ユーザーに紐づく一覧を格納
        @q = UserOfFacility.ransack(params[:q])
        @useroffacility = @q.result.where(user_id: session[:user_id])
            .order("created_at")
            .page(params[:page]).per(15)
    end

    def new
        # 利用者情報登録のためのインスタンスを作成
        @useroffacility = UserOfFacility.new
    end

    def create
        # フォームで入力されたデータとuser_idにログインユーザーのidを格納
        # **はコントローラで値を受け取るために必要
        @useroffacility = UserOfFacility.new(
            **useroffacility_params,
            user_id: session[:user_id]
        )
        if @useroffacility.save
            # 登録に成功した場合、一覧へリダイレクトしメッセージを表示
            redirect_to useroffacilitys_path, success: "利用者情報を登録しました。"
        else
            # 登録に失敗した場合、新規登録画面へ遷移し、メッセージを表示
            flash.now[:danger] = "登録に失敗しました。"
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        if @useroffacility.update(useroffacility_params)
            # 更新に成功した場合、編集画面へリダイレクトし、メッセージを表示
            redirect_to request.referer, success: "利用者情報を更新しました。"
        else
            # 更新に失敗した場合、編集画面へ遷移し、メッセージを表示
            flash.now[:danger] = "編集に失敗しました"
            render 'edit', status: :unprocessable_entity
        end
    end

    def destroy
        # 削除
        @useroffacility.destroy
        # 一覧画面へリダイレクトし、メッセージを表示
        redirect_to useroffacilitys_path, danger: "利用者情報を削除しました。"
    end

    private
        # パラメータで渡されたidをもとに利用者を検索
        def set_useroffacility
            @useroffacility = UserOfFacility.find(params[:id])
        end

        # 利用者情報のパラメータ
        def useroffacility_params
            params.require(:user_of_facility).permit(:name, :organization, :group, :address, :tel, :email, :handicap_name, :handicap_level)
        end
end