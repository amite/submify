class CommentsController < ApplicationController
  before_filter :get_parent
  def new
    @comment = @parent.comments.build
  end

  def create
    @comment = @parent.comments.build(params[:comment])

    if @comment.save
      flash[:notice] = "Commented"
      redirect_to root_path
    else
      render :new
    end
  end
  protected
  
def get_parent
  @parent = Link.find_by_id(params[:link_id]) if params[:link_id]
end

end
