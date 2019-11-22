namespace :notification_schedule do
  desc "TODO"
  task notify_hr: :environment do
    User.notify_all_hr
  end
end
