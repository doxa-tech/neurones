attributes *G::Event.column_names

node(:edit_url) { |event| edit_admin_group_g_event_url(Group.find(params[:group_id]),event) }