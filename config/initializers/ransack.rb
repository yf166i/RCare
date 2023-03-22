Ransack.configure do |config|
    config.add_predicate 'lteq_end_of_day',
        # カスタムの元となるpredicate
        arel_predicate: 'lteq',
        # 検索対象を23:59:59にする
        formatter: proc { |v| v.end_of_day }
end