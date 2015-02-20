class ProjectsController < ApplicationController
	before_action :authenticate_user!, only: [:index]
  def index
  	@projects = current_user.projects
  	@onprojects = true
  end

  def show

  	@project= Project.find(params[:id])
  	@cards = @project.cards
  end

  def create
  	@project=Project.create(title: "Sweet new project", user: current_user)
  	@project.cards.create(title: "First card", body: "Ooooh! This is the shit!")
  	respond_to do |format|
  		format.html {redirect_to @project, notice:"New project added"}
  		format.js {redirect_to @project, notice: "New project added"}
  	end
  end 

  def update
    @project = Project.find(params[:id])
    respond_to do |format|
        if @project.update_attributes(params.require(:project).permit(:title, :body))
            format.html { redirect_to(@project, :notice => 'Project was successfully updated.') }
            format.json { respond_with_bip(@project) }
        else
            format.html { render :action => "edit" }
            format.json { respond_with_bip(@project) }
        end
    end
  end
 def destroy
  @project = Project.find(params[:id])
  @project.destroy
  format.html {redirect_to projects_path, notice:"Project deleted"}
      format.js { head :no_content }
    end
end
