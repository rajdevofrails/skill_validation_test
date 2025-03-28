require 'rails_helper'

RSpec.describe InvoicesController, type: :request do
  let!(:company) { create(:company) }
  let!(:invoice) { create(:invoice, company: company) }

  describe "GET /index" do
    it "returns a successful response" do
      get company_invoices_path(company)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "returns a successful response" do
      get company_invoice_path(company, invoice)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "returns a successful response" do
      get new_company_invoice_path(company)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid attributes" do
      let(:valid_attributes) { attributes_for(:invoice).merge(company_id: company.id) }

      it "creates a new invoice" do
        expect {
          post company_invoices_path(company), params: { invoice: valid_attributes }
        }.to change(Invoice, :count).by(1)
      end

      it "redirects to the invoice page" do
        post company_invoices_path(company), params: { invoice: valid_attributes }
        expect(response).to redirect_to(company_invoice_path(company, Invoice.last))
      end
    end

    context "with invalid attributes" do
      it "does not create an invoice" do
        expect {
          post company_invoices_path(company), params: { invoice: { image: nil, category: "", status: "" } }
        }.not_to change(Invoice, :count)
      end

      it "renders the new template with unprocessable entity status" do
        post company_invoices_path(company), params: { invoice: { image: nil, category: "", status: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
