class Check < ApplicationRecord
  belongs_to :company
  has_many :check_invoices
  has_many :invoices, through: :check_invoices
  has_one_attached :image
  validates :number, presence: true, uniqueness: true
  validates :status, presence: true
end