
%w(rubygems sinatra json active_record).each do |lib|
  require lib
end

enable :static
enable :sessions


ActiveRecord::Base.establish_connection(
  :adapter => "mysql",
  :encoding => "utf8",
  :host => "localhost",
  :database => "wordpress",
  :username => "railsapp_user",
  :password => "xxxxxxxx"
)



class WpPost < ActiveRecord::Base

  set_primary_key 'ID'
  set_table_name "wp_posts"
  #Only in case you want to add comments as well:
  has_many :comments, :class_name => "WpComment", :foreign_key => "comment_post_ID"

  def self.last_post
	  find	:last, 
		:conditions => ['post_status = "publish" and post_type = "post"'], 
		:order => 'post_date ASC', 
		:select => 'post_title,post_date,post_excerpt,post_content,pinged,guid,post_author,"tags,di,mock" as post_tags,"categorie,di,mock" as post_categories'
  end

  def self.get_by_id(wpid)
	find_by_ID wpid,
		   :conditions => ['post_status = "publish" and post_type = "post"'],
		   :select => 'post_title,post_date,post_excerpt,post_content,pinged,guid,post_author,"mock" as post_tags,"mock" as post_categories'
  end

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



get '/lastpost' do
  WpPost.last_post.to_hash.to_json
end

get '/post/:postid' do
  WpPost.get_by_id( params[:postid] ).to_hash.to_json
end


