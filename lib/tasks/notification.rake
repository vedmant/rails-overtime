namespace :notification do
  desc 'Send SMS notification for employees asking them to log if the had overtime or not'

  task sms: :environment do
    # 1. Schedule to run at Sunday 5pm
    # 2. Iterate over all employees
    # 3. Skip admin users
    # 4. Send a message that has instructions and a link to log time
    User.all().each do |user|
      SmsTool.send_sms(user.number, 'Message')
    end
  end
end
