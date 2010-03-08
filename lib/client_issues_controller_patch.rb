require_dependency 'issues_controller'

module ClientIssuesControllerPatch
  module ClassMethods
  end

  def self.included(base)
    base.send(:include, ClassMethods)
    base.extend(ClassMethods)
    base.class_eval do
      unloadable
      helper :clients
    end
  end
end
