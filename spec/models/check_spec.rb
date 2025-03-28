require 'rails_helper'

RSpec.describe Check, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:company) }
    it { is_expected.to have_many(:check_invoices) }
    it { is_expected.to have_many(:invoices).through(:check_invoices) }
    it { is_expected.to have_one_attached(:image) }
  end
end
