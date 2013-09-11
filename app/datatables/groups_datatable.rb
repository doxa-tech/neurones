class GroupsDatatable
	include Admin::RightsHelper
  include Admin::DatatablesHelper
  delegate :params, :current_user, :l, :t, :truncate, to: :@view

  def initialize(view)
    @view = view
    @model = Group
  end

	private

  def data
    elements.map do |element|
      [
      	url(element.url) + element.id.to_s,
      	element.name,     
        element.latitude,
        element.longitude,
        element.description,
        element.website,
        element.street,
        element.city,
        element.npa,       
        element.canton.name,
        (l element.created_at, format: :short),
        (l element.updated_at, format: :short),
        element.url,
        element.website_activated,
        element.style_id
      ]
    end
  end

  def search_request
  	@canton_ids = Canton.where('name like ?', "%#{params[:sSearch]}%" ).pluck(:id)
  	#@sytle_ids
    @elements = @elements.where(search_columns + ' or canton_id IN (:canton_ids)' , text: "%#{params[:sSearch]}%", number: @number, date: @date, date_after: (@date + 1 unless @date.nil?), cantons_ids: @canton_ids)
  end
end