namespace :notification_schedule do
  desc "TODO"
  task notify_hr: :environment do
    User.all_hr_group_by_location.map do |location, users| 
      award_status = Cycle.pending_status_by_location(location)
      users.each do |user|
        NotificationMailer.notify_hr(user, award_status).deliver_later
      end
    end
  end
end
