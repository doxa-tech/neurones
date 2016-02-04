class OwnershipTable < BaseTable

  def model
    Ownership
  end

	def attributes
		[
      :id, { element: :name }, { user: :name }, { ownership_type: :name },
      :right_read, :right_create, :right_update, :right_delete, :created_at, :updated_at
    ]
	end

end
