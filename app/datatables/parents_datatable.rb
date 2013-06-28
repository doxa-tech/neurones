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

  def search_request
    @user_ids = User.where('name like ?', "%#{params[:sSearch]}%" ).pluck(:id)
    @elements = @elements.where(search_columns + ' or user_id IN (:user_ids) or parent_id IN (:user_ids)', text: "%#{params[:sSearch]}%", number: @number, date: @date, date_after: (@date + 1 unless @date.nil?), user_ids: @user_ids)
  end
end