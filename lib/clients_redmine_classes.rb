module ClientsProjectPatch
 
  def self.included(base) 
    Project.extend(ClassMethods)
    Project.send(:include, InstanceMethods)
    Project.class_eval do
      unloadable
      has_many :clients, :dependent => :destroy
    end
 
  end
  
  module ClassMethods
  end
  
  module InstanceMethods
  end
end

module ClientsIssuePatch
 
  def self.included(base) 
    Issue.extend(ClassMethods)
    Issue.send(:include, InstanceMethods)
    Issue.class_eval do
      unloadable
      belongs_to :clients, :class_name => 'Client', :foreign_key => 'client_id'
    end
 
  end
  
  module ClassMethods
  end
  
  module InstanceMethods
  end
end

