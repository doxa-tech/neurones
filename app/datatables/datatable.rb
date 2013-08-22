class Datatable
	include Admin::RightsHelper
  include Admin::DatatablesHelper
  delegate :params, :current_user, :l, :html_escape, :truncate, to: :@view
  

  def initialize(view, model, ownership = true)
    @view = view
    @model = model
    @ownership = ownership
  end

private

  def data
    elements.map do |element|
    	element.attributes.map do |attr_name, attr_value|
        url(element.id) +
    		if attr_value.is_a?(Date) || attr_value.is_a?(DateTime) || attr_value.is_a?(Time)
					(l attr_value, format: :short)
				else
          (html_escape(attr_value.to_s.truncate(80)))
				end
			end
    end
  end

  def search_request
    @elements = @elements.where(search_columns, text: "%#{params[:sSearch]}%", number: @number, date: @date, date_after: (@date + 1 unless @date.nil?) )
  end
end