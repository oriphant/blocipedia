class CollaborationsController < ApplicationController

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaboration = @wiki.collaborations.build(collaboration_params)

    if @collaboration.save
      flash[:notice] = "#{@collaboration.user.name} was added as a collaborator to thie Wiki."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "There was an error removing this collaborator from this Wiki."
      render :show
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaboration = Collaboration.find(params[:id])

    if @collaboration.destroy
      flash[:notice] = "\"#{@collaboration.user_id}\" was removed as a collaborator from thie Wiki."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "There was an error removing this collaborator from this Wiki."
      render :show
    end
  end

  private
  def collaboration_params
    params.require(:collaboration).permit(:wiki_id, :user_id)
  end


end