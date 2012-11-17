class UniquenessRegardingParentValidator < ActiveModel::Validator
  def validate(record)
    conditions = { options[:parent_id_name] => record[options[:parent_id_name]] }
    options[:validated].each do |attr|
      conditions[attr] = record[attr]
    end

    if record.class.where(conditions).any?
      options[:validated].each do |attr|
        record.errors.add(attr, :taken)
      end
    end
  end
end