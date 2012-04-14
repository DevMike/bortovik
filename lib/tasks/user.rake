# Example
#namespace :user do
#  desc "Send reminder to inactive users"
#  task :reminder => :environment do
#    Company.not_deleted.clients.inactive_from(7.days.ago).find_each do |company|
#      begin
#        company.users.active.subscribed_to_weekly_reminder.each do |user|
#          UserMailer.reminder(user, company).deliver
#        end
#      rescue => e
#        Rails.logger.error "Unable to deliver reminder to Company##{company.id}. Reason: #{e.message}"
#      end
#    end
#  end
#end
