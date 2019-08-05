class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @prod = Prod.find_by_id(params[:prod_id])
    @prod.comments.create(comment_params.merge(user: current_user))
    redirect_to prod_path(@prod)
  end

  private

  def comment_params
    params.require(:comment).permit(:message, :rating)
  end

end
