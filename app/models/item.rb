class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, -> { distinct }, through: :invoice_items
  has_many :transactions, -> { distinct }, through: :invoices
  has_many :customers, -> { distinct }, through: :invoices

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true
end
