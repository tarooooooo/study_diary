class CreateLearningDiaries < ActiveRecord::Migration[7.0]
  def change
    create_table :learning_diaries do |t|
      t.text :body, null: false
      t.date :study_day, null: false
      t.integer :study_time, null: false
      t.references :study_category, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
