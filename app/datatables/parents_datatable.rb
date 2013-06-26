class ParentsDatatable
	include Admin::RightsHelper
  include Admin::DatatablesHelper
  delegate :params, :current_user, :l, :truncate, to: :@view
  

  def initialize(view)
    @view = view
    @model = Parent
  end

private

  def data
    elements.map do |element|
      [
        element.id,
        element.user.name,
        element.parent.name,
        (l element.created_at, format: :short),
        (l element.updated_at, format: :short)
      ]
    end
  end
end