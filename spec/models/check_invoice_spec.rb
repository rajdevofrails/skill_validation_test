require 'rails_helper'

RSpec.describe CheckInvoice, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:check) }
    it { is_expected.to belong_to(:invoice) }
  end
end
