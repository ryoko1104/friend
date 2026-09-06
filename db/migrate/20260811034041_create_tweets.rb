class CreateTweets < ActiveRecord::Migration[7.2]
  def change
    create_table :tweets do |t|
      t.string :name
      t.integer :age
      t.string :community
      t.date :birthday
      t.string :photo
      t.text :personality
      t.string :birthplace

      t.timestamps
    end
  end
end
