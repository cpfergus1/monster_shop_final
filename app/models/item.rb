class Item < ApplicationRecord
  belongs_to :merchant
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :reviews, dependent: :destroy
  has_many :discounts, through: :merchant

  validates_presence_of :name,
                        :description,
                        :image,
                        :price,
                        :inventory

  def self.active_items
    where(active: true)
  end

  def self.by_popularity(limit = nil, order = "DESC")
    left_joins(:order_items)
    .select('items.id, items.name, COALESCE(sum(order_items.quantity), 0) AS total_sold')
    .group(:id)
    .order("total_sold #{order}")
    .limit(limit)
  end

  def sorted_reviews(limit = nil, order = :asc)
    reviews.order(rating: order).limit(limit)
  end

  def average_rating
    reviews.average(:rating)
  end

  def find_discount(quantity)
    discounts.where('items_required <= ?', quantity).order(discount: :DESC).first
  end

  def price_with_discount(quantity)
    discount_object = find_discount(quantity)
    if discount_object.nil?
      price
    else
      price * (1 - discount_object.discount/100)
    end
  end

  def no_discount?(quantity)
    find_discount(quantity).nil?
  end

  def discount_name(quantity)
    find_discount(quantity).name
  end

end
