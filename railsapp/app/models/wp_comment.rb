class WpComment < ActiveRecord::Base
  establish_connection :blog
  set_table_name "wp_comments"
  set_primary_key "comment_ID"
  belongs_to :post , :class_name => "WpPost", :foreign_key => "comment_post_ID"
end
