module LocationsHelper
  def selected_item(resource, association_name)
    resource.send(association_name).id if resource.settlement
  end

  def selected_collection(resource, association_name)
    return [] if resource.settlement.blank?

    case association_name
      when :region
        collection_for resource.country.regions
      when :settlement
        collection_for resource.region.settlements
    end
  end
end