class CreateStudyPlans < ActiveRecord::Migration[7.0]
  def change
    create_table :study_plans do |t|
      t.string :title
      t.integer :weekly_target_time, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
