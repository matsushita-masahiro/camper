# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#users
  20.times do |i|
    User.create(
      email: "#{i}@gmail.com",
      password: 'foobar',
      name: "user#{i}",
      image: open("#{Rails.root}/db/data/dog.jpg"),
      intro: "test user#{i}"
      )
  end

#posts
  20.times do |i|
    Post.create(
      user_id: "#{Random.rand(1..20)}",
      body:'test post',
      files: [open("#{Rails.root}/db/data/camp.jpg")]
      )
  end

#events
  from = Date.parse("2019/01/01")
  to = Date.parse("2019/12/31")
  
  20.times do |i|
    Event.create(
      title: "event#{i}",
      body: "test event #{i}",
      files: [open("#{Rails.root}/db/data/camp.jpg")],
      recruit_num: Random.rand(1..10),
      place: "japan#{i}",
      event_date: Random.rand(from..to),
      deadline: Random.rand(from..to),
      user_id: Random.rand(1..20)
      )
  end

