# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Item.destroy_all
User.destroy_all
Merchant.destroy_all

#merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)

#bike_shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 100)
dark_helmet = bike_shop.items.create(name: "Dark Helmet", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 100)
light_helmet = bike_shop.items.create(name: "Light Helmet", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 100)
blue_helmet = bike_shop.items.create(name: "Blue Helmet", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 100)

#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 100)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active:false, inventory: 100)
squeaky_toy = dog_shop.items.create(name: "Squeaky Toy", description: "They'll love it!", price: 25, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active:false, inventory: 100)
chew_toy = dog_shop.items.create(name: "Chew Toy", description: "They'll love it!", price: 11, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active:false, inventory: 100)
rope = dog_shop.items.create(name: "Rope", description: "They'll love it!", price: 13, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active:false, inventory: 25)

#mike's items
paper = mike.items.create!(name: "Lined Paper",
  description: "Great for writing on!",
  price: 20,
  image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png",
  inventory: 25)

pencil = mike.items.create!(name: "Pencil",
  description: "Great for writing with!",
  price: 30,
  image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png",
  inventory: 2000)

#users
user1 = bike_shop.users.create!({password: "Bobpass",
                     name: "Bobname",
                     address: "Bobaddress",
                     city: "Bobcity",
                     state: "Bobstate",
                     zip: "Bobzip",
                     email: "Bob@email",
                     password_confirmation: "Bobpass",
                     role: 1})
user2 = dog_shop.users.create!({password: "Eugenepass",
                     name: "Eugenename",
                     address: "Eugeneaddress",
                     city: "Eugenecity",
                     state: "Eugenestate",
                     zip: "Eugenezip",
                     email: "Eugene@email",
                     password_confirmation: "Eugenepass",
                     role: 1})
user3 = User.create!({password: "Connorpass",
                     name: "Connorname",
                     address: "Connoraddress",
                     city: "Connorcity",
                     state: "Connorstate",
                     zip: "Connorzip",
                     email: "Connor@email",
                     password_confirmation: "Connorpass",
                     role: 2})
user4 = User.create!({password: "Willpass",
                     name: "Willname",
                     address: "Willaddress",
                     city: "Willcity",
                     state: "Willstate",
                     zip: "Willzip",
                     email: "Will@email",
                     password_confirmation: "Willpass",
                     role: 0})
user5 = User.create!({password: "Jessepass",
                     name: "Jessename",
                     address: "Jesseaddress",
                     city: "Jessecity",
                     state: "Jessestate",
                     zip: "Jessezip",
                     email: "Jesse@email",
                     password_confirmation: "Jessepass",
                     role: 0})
user6 = User.create!({password: "Timpass",
                     name: "Timname",
                     address: "Timaddress",
                     city: "Timcity",
                     state: "Timstate",
                     zip: "Timzip",
                     email: "Tim@email",
                     password_confirmation: "Timpass",
                     role: 0})
