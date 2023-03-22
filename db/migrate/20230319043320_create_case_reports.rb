class CreateCaseReports < ActiveRecord::Migration[7.0]
  def change
    create_table :case_reports do |t|
      t.integer :user_id
      t.datetime :occurrence_date
      t.string :name
      t.string :case_name
      t.string :content
      t.string :method
      t.string :result

      t.timestamps
    end
  end
end
