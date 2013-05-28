require "rails_erd/diagram"

class YumlDiagram < RailsERD::Diagram
  setup { @edges = [] }

  each_relationship do |relationship|
    return if relationship.indirect?

    arrow = case
    when relationship.one_to_one?   then "1-1>"
    when relationship.one_to_many?  then "1-*>"
    when relationship.many_to_many? then "*-*>"
    end

    @edges << "[#{relationship.source}] #{arrow} [#{relationship.destination}]"
  end

  save { @edges * "\n" }
end