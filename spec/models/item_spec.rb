require 'rails_helper'

RSpec.describe Item do
  describe 'Relationships' do
    it {should belong_to :merchant}
    it {should have_many :order_items}
    it {should have_many(:orders).through(:order_items)}
    it {should have_many(:discounts).through(:merchant)}
    it {should have_many :reviews}
  end

  describe 'Validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :image}
    it {should validate_presence_of :price}
    it {should validate_presence_of :inventory}
  end

  describe 'Instance Methods' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @discount1 = @megan.discounts.create!(name: 'Big Bulk Sale', items_required: 5, discount: 5)
      @discount2 = @megan.discounts.create!(name: 'Super Bulk Sale', items_required: 10, discount: 7)
      @discount3 = @megan.discounts.create!(name: 'Mega Bulk Sale', items_required: 20, discount: 10)
      @discount3 = @megan.discounts.create!(name: 'Giant Bulk Sale', items_required: 20, discount: 15)
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @review_1 = @ogre.reviews.create(title: 'Great!', description: 'This Ogre is Great!', rating: 5)
      @review_2 = @ogre.reviews.create(title: 'Meh.', description: 'This Ogre is Mediocre', rating: 3)
      @review_3 = @ogre.reviews.create(title: 'EW', description: 'This Ogre is Ew', rating: 1)
      @review_4 = @ogre.reviews.create(title: 'So So', description: 'This Ogre is So so', rating: 2)
      @review_5 = @ogre.reviews.create(title: 'Okay', description: 'This Ogre is Okay', rating: 4)
    end

    it '.sorted_reviews()' do
      expect(@ogre.sorted_reviews(3, :desc)).to eq([@review_1, @review_5, @review_2])
      expect(@ogre.sorted_reviews(3, :asc)).to eq([@review_3, @review_4, @review_2])
      expect(@ogre.sorted_reviews).to eq([@review_3, @review_4, @review_2, @review_5, @review_1])
    end

    it '.average_rating' do
      expect(@ogre.average_rating.round(2)).to eq(3.00)
    end

    it '.add_discount' do
      expect(@ogre.find_discount(9).discount).to eq(5)
      expect(@ogre.find_discount(10).discount).to eq(7)
      expect(@ogre.find_discount(20).discount).to eq(15)
      expect(@ogre.find_discount(2)).to eq(nil)
      expect(@hippo.find_discount(2)).to eq(nil)
    end

    it '.price_with_discount' do
      expect(@ogre.price_with_discount(9)).to eq(19)
      expect(@ogre.price_with_discount(20)).to eq(17.0)
      expect(@giant.price_with_discount(20)).to eq(42.5)
      expect(@hippo.price_with_discount(25)).to eq(50)
    end

    it '.no_discount?' do
      expect(@giant.no_discount?(20)).to eq(false)
      expect(@hippo.no_discount?(25)).to eq(true)
    end
    it '.discount_name?' do
      expect(@giant.discount_name(20)).to eq('Giant Bulk Sale')
    end
  end

  describe 'Class Methods' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @nessie = @brian.items.create!(name: 'Nessie', description: "I'm a Loch Monster!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: false, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Loch Monster!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: false, inventory: 3 )
      @gator = @brian.items.create!(name: 'Gator', description: "I'm a Loch Monster!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: false, inventory: 3 )
      @review_1 = @ogre.reviews.create(title: 'Great!', description: 'This Ogre is Great!', rating: 5)
      @review_2 = @ogre.reviews.create(title: 'Meh.', description: 'This Ogre is Mediocre', rating: 3)
      @review_3 = @ogre.reviews.create(title: 'EW', description: 'This Ogre is Ew', rating: 1)
      @review_4 = @ogre.reviews.create(title: 'So So', description: 'This Ogre is So so', rating: 2)
      @review_5 = @ogre.reviews.create(title: 'Okay', description: 'This Ogre is Okay', rating: 4)
      @user = User.create!(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword')
      @order_1 = @user.orders.create!
      @order_2 = @user.orders.create!
      @order_3 = @user.orders.create!
      @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)
      @order_1.order_items.create!(item: @hippo, price: @hippo.price, quantity: 3)
      @order_2.order_items.create!(item: @hippo, price: @hippo.price, quantity: 5)
      @order_3.order_items.create!(item: @nessie, price: @nessie.price, quantity: 7)
      @order_3.order_items.create!(item: @gator, price: @gator.price, quantity: 1)
    end

    it '.active_items' do
      expect(Item.active_items).to eq([@ogre, @giant])
    end

    it '.by_popularity()' do
      expect(Item.by_popularity).to eq([@hippo, @nessie, @ogre, @gator, @giant])
      expect(Item.by_popularity(3, "ASC")).to eq([@giant, @gator, @ogre])
      expect(Item.by_popularity(3, "DESC")).to eq([@hippo, @nessie, @ogre])
    end
  end
end
