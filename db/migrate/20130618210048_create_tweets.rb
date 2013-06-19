class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
    	t.string :content
    	t.datetime :published_at
    	t.belongs_to :user

      t.timestamps
    end
  end
end
