class CreateStudyCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :study_categories do |t|
      t.string :name, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :study_categories, [:user_id, :name], unique: true
  end
end
