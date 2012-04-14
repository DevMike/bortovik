# Example
#namespace :db do
#  desc "Check database integrity"
#  task :check_integrity, [:delete] => :environment do |t, args|
#    args.with_defaults(:delete => false)
#
#    checks = {
#      Review => [:user, :rated_company],
#      Customer => [:invited_by, :company],
#      Invoice => [:subscription, :company],
#      Rating => [:review, :rate_criteria],
#      Subscription => [:company],
#      Company => [:subscriptions, :users],
#    }
#    failures = {}
#    checks.each_pair do |klass, associations|
#      associations.each do |association|
#        results = check(klass, association)
#        failures.deep_merge! results
#        if results.any? && args.delete
#          klass.delete_all(["id IN (?)", results.values.first.values.flatten])
#        end
#      end
#
#    end
#    users_without_companies = User.joins("LEFT JOIN companies ON users.company_id = companies.id")
#                                  .where("companies.id IS NULL")
#                                  .to_a.reject(&:consumer?)
#    if users_without_companies.any?
#      failures["User"] = {:company => [users_without_companies.map(&:id)]}
#    end
#
#
#    if failures.any?
#      SupportMailer.integrity_broken(failures).deliver
#    end
#  end
#
#  def check(klass, association_name)
#    association = klass.reflect_on_association(association_name)
#    if klass.soft_destroyable?
#      scope = klass.not_deleted
#    else
#      scope = klass
#    end
#
#    failures = case association.macro
#    when :has_many
#      failures = scope.joins("LEFT JOIN #{association.table_name} ON #{klass.table_name}.#{association.association_primary_key} = #{association.table_name}.#{association.foreign_key}")
#                      .select("#{klass.table_name}.id, COUNT(#{association.table_name}.id) as total_count")
#                      .having("COUNT(#{association.table_name}.id) = 0")
#                      .group("#{klass.table_name}.id")
#    when :belongs_to
#      failures = scope.joins("LEFT JOIN #{association.table_name} ON #{klass.table_name}.#{association.foreign_key} = #{association.table_name}.#{association.association_primary_key}")
#                    .where("#{association.table_name}.#{association.association_primary_key}  IS NULL")
#                    .select("#{klass.table_name}.id")
#    else
#      {}
#    end
#
#    if failures.any?
#      {klass.name => {association_name => failures.map(&:id)}}
#    else
#      {}
#    end
#  end
#end