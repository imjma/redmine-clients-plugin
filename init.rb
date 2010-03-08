require 'redmine'
require 'dispatcher'
require 'client_issues_hook'

Dispatcher.to_prepare do 
  require_dependency 'project'
  require_dependency 'issue'

  begin
    require_dependency 'application_controller'
  rescue MissingSourceFile
    require_dependency 'application'
  end

  require 'patch_redmine_classes'
  require 'client_issues_controller_patch'
  
  Project.send(:include, ClientsProjectPatch)
  Issue.send(:include, ClientsIssuePatch)
  IssuesController.send(:include, ClientIssuesControllerPatch)
end

Redmine::Plugin.register :redmine_clients do
  name 'Redmine Clients plugin'
  author 'Jie Ma'
  description 'This is a client plugin for Redmine'
  version '0.0.2'

  permission :view_clients, :clients => :index
  permission :edit_clients, :clients=> [:new, :create]
  menu :project_menu, :clients, { :controller => 'clients', :action => 'index' }, :caption => :clients_title, :last => true
end
