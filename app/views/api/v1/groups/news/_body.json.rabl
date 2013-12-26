attributes *G::New.column_names

node(:edit_url) { |new| edit_admin_group_g_new_url(Group.find(params[:group_id]),new) }
