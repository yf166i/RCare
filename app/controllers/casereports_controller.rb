class CasereportsController < ApplicationController
    # edit、update、destroyアクション実行前にset_casereportメソッドを実行し、利用者の特定をする
    before_action :set_casereport, only: [ :edit, :update, :destroy ]

    def index
        # ユーザーに紐づく一覧を格納
        @q = CaseReport.ransack(params[:q])
        @casereport = @q.result.where(user_id: session[:user_id])
            .order("occurrence_date")
            .page(params[:page]).per(15)
    end

    def new
        # 事例記録登録のためのインスタンスを作成
        @casereport = CaseReport.new
        # 利用者名をUserOfFacilityから取得しドロップダウン表示
        @useroffacility = UserOfFacility.where(user_id: session[:user_id])
    end

    def create
        # フォームで入力されたデータとuser_idにログインユーザーのidを格納
        # **はコントローラで値を受け取るために必要
        @casereport = CaseReport.new(
            **casereport_params,
            user_id: session[:user_id]
        )
        if @casereport.save
            # 登録に成功した場合、一覧へリダイレクトしメッセージを表示
            redirect_to casereports_path, success: "事例記録を登録しました。"
        else
            # 登録に失敗した場合、新規登録画面へ遷移し、メッセージを表示
            flash.now[:danger] = "登録に失敗しました。"
            # 利用者名をUserOfFacilityから取得しドロップダウン表示
            @useroffacility = UserOfFacility.where(user_id: session[:user_id])
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        if @casereport.update(casereport_params)
            # 更新に成功した場合、編集画面へリダイレクトし、メッセージを表示
            redirect_to request.referer, success: "事例記録を更新しました。"
        else
            # 更新に失敗した場合、編集画面へ遷移し、メッセージを表示
            flash.now[:danger] = "編集に失敗しました"
            render 'edit', status: :unprocessable_entity
        end
    end

    def destroy
        # 削除
        @casereport.destroy
        # 一覧画面へリダイレクトし、メッセージを表示
        redirect_to casereports_path, danger: "事例記録を削除しました。"
    end

    private
        # パラメータで渡されたidをもとに利用者を検索
        def set_casereport
            @casereport = CaseReport.find(params[:id])
        end

        # 利用者情報のパラメータ
        def casereport_params
            params.require(:case_report).permit(:occurrence_date, :name, :case_name, :content, :method, :result)
        end
end
