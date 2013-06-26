class Datatable
	include Admin::RightsHelper
  include Admin::DatatablesHelper
  delegate :params, :current_user, :l, :truncate, to: :@view
  

  def initialize(view, model)
    @view = view
    @model = model
  end

private

  def data
    elements.map do |element|
    	element.attributes.map do |attr_name, attr_value|
    		if attr_value.is_a?(Date) || attr_value.is_a?(DateTime) || attr_value.is_a?(Time)
					l attr_value, format: :short
				else
					truncate(attr_value.to_s, lenght: 40)
				end
			end
    end
  end
end