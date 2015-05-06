class CreatePollQuestions < ActiveRecord::Migration
  def change
    create_table :poll_questions do |t|
      t.string :heading
      t.string :adress

      t.timestamps
    end
  end
end
