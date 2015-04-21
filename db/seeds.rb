# Generated with RailsBricks
# Initial seed file to use with Devise User Model

# Temporary admin account
u = User.new(
    email: "admin@example.com",
    password: "asdf",
    password_confirmation: "asdf",
    admin: true
)
u.skip_confirmation!
u.save!

# Test user accounts
(1..50).each do |i|
  u = User.new(
      email: "user#{i}@example.com",
      password: "1234",
      password_confirmation: "1234"
  )
  u.skip_confirmation!
  u.save!

  puts "#{i} test users created..." if (i % 5 == 0)
end

e1 = Event.create!(name: "hack_london", cover_photo_url: "http://www.gambarphoto.com/wp-content/uploads/2014/12/best-nature-photos-for-facebook-cover-7.jpg",
              address: "Strand Campus, King's College London, WC2R 2LS, London",
              start_time: DateTime.current.advance(months: -3), 
              end_time: DateTime.current.advance(months: -3, days: 1),
              description: "Hack London is the largest U.K. hackathon. We hope you enjoy your time here.")

e2 = Event.create!(name: "Oxford Inspires", cover_photo_url: "http://www.f-covers.com/cover/colorful-hearts-facebook-cover-timeline-banner-for-fb.jpg",
              address: "Said Business School, Oxford, UK",
              start_time: DateTime.current.advance(months: -2), 
              end_time: DateTime.current.advance(months: -2, days: 1),
              description: "Oxford Inspires hopes to inspire you. Let us know how we can help.")

e3 = Event.create!(name: "St. Hugh's Ball, 2015", cover_photo_url: "https://sthughsball.com/notifsta_background.jpeg",
              address: "St. Hugh's College, Oxford, UK",
              start_time: DateTime.current.advance(months: 1), 
              end_time: DateTime.current.advance(months: 1, days: 1),
              description: "St. Hugh's is delighted to invite you to our Ball.")

events = [e1, e2, e3]

for event in events
  notifications = event.channels.create!(name: "Notifications")

  notifications.notifications.create!(type: "Message", notification_guts: "First notification!")

  survey = notifications.notifications.create!(type: "Survey", notification_guts: "What food?")

  survey.options.create!(option_guts: "Burgers")
  survey.options.create!(option_guts: "Pizza")
  survey.options.create!(option_guts: "Cauliflowers")
  survey.options.create!(option_guts: "Carrots")
  survey.options.create!(option_guts: "Swiss cheese")
end

# subscribe users, and respond to survey
# first user is admin
for u in User.all
 u.subscriptions.create!(event_id: 1, admin: true)
 u.subscriptions.create!(event_id: 2, admin: true)
 u.subscriptions.create!(event_id: 3, admin: true)
 Response.create!(user_id: u.id, option_id: (u.id % 5) + 1)
end
