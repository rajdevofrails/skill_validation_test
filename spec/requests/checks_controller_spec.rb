require 'rails_helper'

RSpec.describe "Checks", type: :request do
  let(:company) { create(:company) }
  let(:check) { create(:check, company: company) }

  describe "GET /index" do
    it "returns a successful response" do
      get company_checks_path(company)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns a successful response" do
      get company_check_path(company, check)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns a successful response" do
      get new_company_check_path(company)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    context "with valid attributes" do
      let(:valid_params) do 
        { 
          check: attributes_for(:check).merge(
            image: fixture_file_upload(Rails.root.join('spec/fixtures/files/bill.png'), 'image/png')
          ) 
        }
      end

      it "creates a new check" do
        expect {
          post company_checks_path(company), params: valid_params
        }.to change(Check, :count).by(1)
        
        expect(response).to redirect_to(company_check_path(company, Check.last))
        follow_redirect!
        expect(response.body).to include("Check uploaded successfully.")
      end
    end

    context "with invalid attributes" do
      let(:invalid_params) { { check: { number: nil } } }

      it "does not create a new check" do
        expect {
          post company_checks_path(company), params: invalid_params
        }.not_to change(Check, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
