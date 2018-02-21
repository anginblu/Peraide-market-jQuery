class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :title
      t.belongs_to :user
      t.decimal :hourly, precision: 10, scale: 2
      t.date :available_from, default: Date.today
      t.timestamps null: false
    end
  end
end
