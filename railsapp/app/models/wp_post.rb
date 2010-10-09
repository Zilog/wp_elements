class WpPost < ActiveRecord::Base
  establish_connection :blog
  set_primary_key 'ID'
  set_table_name "wp_posts"
  #Only in case you want to add comments as well:
  has_many :comments, :class_name => "WpComment", :foreign_key => "comment_post_ID"

  def to_hash
  {
    "title" => post_title,
    "date" => post_date,
    "teaser" => post_excerpt,
    "body" => post_content,
    "link" => pinged,
    "guid" => guid,
    "author" => post_author,
    "tags" => post_tags,
    "categories" => post_categories
  }
  end

end
