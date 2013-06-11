class ChangeImageUrls < ActiveRecord::Migration
  def up
  	#this is here because the prod db got out of sync
  	# drop_table :merit_actions
  	# drop_table :merit_activity_logs
  	# drop_table :sashes
  	# drop_table :badges_sashes
  	# drop_table :merit_scores
   #  drop_table :merit_score_points
   #  remove_column :users, :sash_id
   #  remove_column :users, :level
  end

  def down
  end
end
