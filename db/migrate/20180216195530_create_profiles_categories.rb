class CreateProfilesCategories < ActiveRecord::Migration
  def change
    create_table :profiles_categories do |t|
      t.belongs_to :profile
      t.belongs_to :category
      t.string :content
      t.timestamps null: false
    end
  end
end
