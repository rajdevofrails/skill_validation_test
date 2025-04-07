require 'rails_helper'

RSpec.describe CompaniesController, type: :request do
  let!(:company) { create(:company) } # Assuming you have FactoryBot set up

  describe "GET /index" do
    it "returns a successful response" do
      get companies_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include(company.name)
    end
  end

  describe "GET /show" do
    it "returns a successful response" do
      get company_path(company)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "renders the new template" do
      get new_company_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("New Company")
    end
  end

  describe "POST /create" do
    context "with valid attributes" do
      let(:valid_params) { { company: { name: "New Company" } } }

      it "creates a new company" do
        expect {
          post companies_path, params: valid_params
        }.to change(Company, :count).by(1)

        expect(response).to redirect_to(company_path(Company.last))
        follow_redirect!
        expect(response.body).to include("Company created successfully.")
      end
    end
  end
end
