# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
3.times do |n|
RoomType.create(name: "#{n + 1} bed")
end

3.times do |n|
Room.create(name: "Room #{n + 1}", price: 500 + n * 5, image: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png", room_type_id: n+ 1)
end

3.times do |n|
Room.create(name: "Room #{n + 4}", price: 500 + n * 5, image: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png", room_type_id: n+ 1)
end

3.times do |n|
Room.create(name: "Room #{n + 7}", price: 500 + n * 5, image: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png", room_type_id: n+ 1)
end



