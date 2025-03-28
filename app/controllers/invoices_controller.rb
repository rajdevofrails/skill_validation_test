class InvoicesController < ApplicationController
  before_action :set_company
  before_action :set_invoice, only: [:show]

  def index
    @invoices = @company.invoices
  end

  def show
    @invoice = Company.find(params[:company_id]).invoices.find(params[:id])
  end

  def new
    @invoice = Invoice.new(company: @company)
  end

  def create
    @invoice = @company.invoices.new(invoice_params) # Ensures @company is set
  
    if @invoice.save
      redirect_to company_invoice_path(@company, @invoice), notice: "Invoice uploaded successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_company
    @company = Company.find_by(id: params[:company_id])
    return if @company.present?

    redirect_to companies_path, alert: "Company not found."
  end

  def set_invoice
    @invoice = @company.invoices.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:image, :category, :status, check_ids: [])
  end
end
