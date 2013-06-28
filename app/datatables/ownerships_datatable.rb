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

  def search_request
    @user_ids = User.where('name like ?', "%#{params[:sSearch]}%" ).pluck(:id)
    @ownership_type_ids = OwnershipType.where('name like ?', "%#{params[:sSearch]}%" ).pluck(:id)
    @element_ids = Element.where('name like ?', "%#{params[:sSearch]}%" ).pluck(:id)
    @elements = @elements.where(search_columns + ' or user_id IN (:user_ids) or ownership_type_id IN (:ownership_type_ids) or element_id IN (:element_ids)' , text: "%#{params[:sSearch]}%", number: @number, date: @date, date_after: (@date + 1 unless @date.nil?), user_ids: @user_ids, ownership_type_ids: @ownership_type_ids, element_ids: @element_ids)
  end
end