class Invoice < ApplicationRecord
  belongs_to :company
  has_many :check_invoices
  has_many :checks, through: :check_invoices
  has_one_attached :image
  validates :image, presence: true
  validates :category, presence: true
  validates :status, presence: true
end