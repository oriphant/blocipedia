class CollaborationsController < ApplicationController

  def create
    @wiki=Wiki.current_wiki.id
    @user=User.find(params[:id])
    collaboration = @wiki.colaborations.build(user_id: @user)
  end

end