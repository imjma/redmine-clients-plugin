class ClientIssuesHook < Redmine::Hook::ViewListener

  def view_issues_form_details_bottom(context = {}) 
    controller = context[:controller]
    controller.send(:render_to_string, :partial => "select_clients")
  end

  def controller_issues_new_before_save(context = {})
    issue = context[:issue]
    params = context[:params]
    issue.client_id= params[:issue][:client_id]
  end

  def controller_issues_edit_before_save(context = {})
    issue = context[:issue]
    params = context[:params]
    issue.client_id= params[:issue][:client_id] unless issue.client_id == params[:issue][:client_id]
  end

  def controller_issues_edit_after_save(context = {})
    journal = context[:journal]
    for detail in journal.details
      if detail.prop_key == 'client_id'
        if detail.old_value
          client = Client.find(detail.old_value)
          detail.old_value = client.first_name + ", " + client.last_name
        end
        if detail.value
          client = Client.find(detail.value)
          detail.value = client.first_name + ", " + client.last_name
        end
        detail.save!
      end
    end
  end

  def view_issues_show_details_bottom(context = {})
    issue = context[:issue]
    controller = context[:controller]
    controller.send(:render_to_string, :partial => "show_clients", :locals => {:issue => issue})
  end
end
