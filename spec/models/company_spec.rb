require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:invoices).dependent(:destroy) }
    it { is_expected.to have_many(:checks).dependent(:destroy) }
  end
end
