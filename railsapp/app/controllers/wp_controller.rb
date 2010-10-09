class WpController < ApplicationController
    def index
	@blogposts = WpPost.find(	:all, 
					:conditions => ['post_status = "publish" and post_type = "post"'], 
					:limit => 10, 
					:order => 'post_date DESC')
    end

    def lastpost
	@blogpost = WpPost.find(:last, 
				:conditions => ['post_status = "publish" and post_type = "post"'], 
				:order => 'post_date ASC', 
				:select => 'post_title,post_date,post_excerpt,post_content,pinged,guid,post_author,"fake,tags,mock" as post_tags,"category,mock" as post_categories'
                  		).to_hash

    end


  def show
	@blogposts = WpPost.find_by_ID(	params[:id],
					:conditions => ['post_status = "publish" and post_type = "post"'],
					:select => 'post_title,post_date,post_excerpt,post_content,pinged,guid,post_author,"fake,mock,tags" as post_tags,"category,mock" as post_categories'
					).to_hash

  end

end
