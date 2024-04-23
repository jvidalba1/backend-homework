class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :producer
      t.integer :accessibility
      t.date :released_date

      t.timestamps
    end
  end
end
