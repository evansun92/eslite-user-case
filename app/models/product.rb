class Product < ApplicationRecord
  belongs_to :user
  has_many_attached :pics, dependent: :destroy

  validates_presence_of :name, :price

  enum status: { on_shelves: 0, stock: 1, off_shelves: -1 }
end
