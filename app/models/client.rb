class Client < ActiveRecord::Base
  belongs_to :project, :class_name => "Project", :foreign_key => "project_id"
  has_many :issues

  validates_presence_of :first_name, :email
end
