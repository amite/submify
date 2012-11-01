require 'open-uri'
require 'uri'
require 'pismo'
require 'net/http'
class LinksController < ApplicationController

  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy

 def show

	@link = Link.find_by_id(params[:id])
	@comments = @link.comments.paginate(page: params[:page])
 end
  def create

    if check_url

	if @link= Link.find_by_url_link(params[:link][:url_link])
		current_user.link_with_user!(@link)
      		flash[:success] = "Link submitted"
	      	redirect_to root_url
	else
	    @link = current_user.links.build(params[:link]) 
	
	    if @link!= nil && @link.save

	    current_user.link_with_user!(@link)
	      flash[:success] = "Link submitted"
	      redirect_to root_url
	    else
	  	redirect_to root_url
     	    end
	end
     else
	  redirect_to root_url
     end
  end

  def destroy
    
    current_user.unlink_with_user!(@link)

    redirect_to root_url unless @link.users.exists? current_user
  end

  private
    def correct_user
      @link = current_user.links.find_by_id(params[:id])
      redirect_to root_url if @link.nil?
    end
   
    def check_url
	given =params[:link][:url_link]
	given = "http://" + given if /https?:\/\/[\S]+/.match(given) == nil
	begin       	
		page =  open(given).base_uri.to_s
		doc = Pismo::Document.new(page)

		page.slice! "http://"
		page.slice! "https://"
		page.slice! "www."
		
		params[:link][:url_link] = page
		params[:link][:url_heading] = doc.title
		true

	rescue URI::InvalidURIError
    		host = given.match(".+\:\/\/([^\/]+)")[1]
    		path = given.partition(host)[2] || "/"
		begin    		
		doc = Net::HTTP.get host, path
		given.slice! "http://"
		given.slice! "https://"
		given.slice! "www."

		params[:link][:url_link] = given
		params[:link][:url_heading] = doc.match(/<title>(.*?)<\/title>/)[1]
		true
		rescue
		flash[:error] = "Invalid url"
		false
		end	
	rescue
	       	flash[:error] = "Invalid url"
		false
	end
   end   

  
end

