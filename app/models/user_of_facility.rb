class UserOfFacility < ApplicationRecord
    # name のバリデーション
    validates :name,
        presence: true,
        length: { maximum: 25 }

    # tel のバリデーション
    validates :tel,
        length: { maximum: 11 }

    # runsack(検索gem)で必要処理
    def self.ransackable_attributes(auth_object = nil)
        ["name", "organization", "group"]
    end
end
