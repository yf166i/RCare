class CaseReport < ApplicationRecord
    # 発生日時 のバリデーション
    validates :occurrence_date,
        presence: true

    # 利用者名 のバリデーション
    validates :name,
        presence: true
    
    # 事例名 のバリデーション
    validates :case_name,
    presence: true

    # 事例内容 のバリデーション
    validates :content,
    presence: true

    # runsack(検索gem)で必要処理
    def self.ransackable_attributes(auth_object = nil)
        ["occurrence_date"]
    end
end
