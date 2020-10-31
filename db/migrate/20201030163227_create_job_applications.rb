class CreateJobApplications < ActiveRecord::Migration[6.0]
  def change
    create_table :job_applications do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :job_post, null: false, foreign_key: true
      t.boolean :seen, default: false

      t.timestamps
    end
  end
end
