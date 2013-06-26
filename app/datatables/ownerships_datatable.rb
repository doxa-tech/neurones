class OwnershipsDatatable
	include Admin::RightsHelper
  include Admin::DatatablesHelper
  delegate :params, :current_user, :l, :t, :truncate, to: :@view
  

  def initialize(view)
    @view = view
    @model = Ownership
  end

private

  def data
    elements.map do |element|
      [
        element.id,
        element.element.name,
        element.user.name,
        element.ownership_type.name,
        (l element.created_at, format: :short),
        (l element.updated_at, format: :short),
        t(element.right_read),
        t(element.right_create),
        t(element.right_update),
        t(element.right_delete),
        element.id_element
      ]
    end
  end
end