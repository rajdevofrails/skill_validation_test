require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:company) }
    it { is_expected.to have_many(:check_invoices) }
    it { is_expected.to have_many(:checks).through(:check_invoices) }
  end
end
