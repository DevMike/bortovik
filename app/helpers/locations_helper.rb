module LocationsHelper
  def selected_item(resource, association_name)
    resource.send(association_name).id
  end

  def selected_collection(resource, association_name)
    return collection_for Country.all if association_name == :country

    case association_name
      when :region
        collection_for resource.country.regions
      when :settlement
        collection_for resource.region.settlements
    end
  end
end