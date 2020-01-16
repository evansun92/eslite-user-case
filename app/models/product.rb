class Product < ApplicationRecord
  has_many_attached :pics, dependent: :destroy
  belongs_to :user

  validates_presence_of :name

  enum status: { on_shelves: 0, stock: 1, off_shelves: -1 }
end
