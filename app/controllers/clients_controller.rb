class ClientsController < ApplicationController
  unloadable

  before_filter :find_project, :authorize

  def index
    # @clients = Client.find(:all, :conditions => [" project_id = ?", @project.id], :order => 'created_at')
    @clients = @project.clients.find(:all)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def new
    @client = Client.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    @client = @project.clients.build(params[:client])
    if request.post?
      if @client.save
        flash[:notice] = l(:notice_successful_create)
        redirect_to :action => :index, :id=> @project and return
      end
    end
    flash[:notice] = l(:notice_unsuccessful_create)
    render :action => :index, :id=> @project
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end
end
