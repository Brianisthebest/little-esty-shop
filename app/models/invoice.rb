class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, -> { distinct }, through: :invoice_items
  has_many :merchants, -> { distinct }, through: :items

  validates :status, presence: true

  enum status: ["In Progress", "Completed", "Cancelled"]

  def self.find_incomplete_invoices
    joins(:invoice_items).where('invoice_items.status != ?', '2').group(:id).order(:id)
  end

  def customer_name
    customer.first_name + " " + customer.last_name
  end
end
