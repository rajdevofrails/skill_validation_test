class ChecksController < ApplicationController
  before_action :set_company
  before_action :set_check, only: [:show]

  def index
    @checks = @company.checks
  end

  def show; end

  def new
    @check = @company.checks.build
  end

  def create
    @check = @company.checks.build(check_params)
  
    # Process Base64 image only if provided
    attach_base64_image if base64_image_provided?
  
    if @check.save
      redirect_to company_check_path(@company, @check), notice: "Check uploaded successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_check
    @check = @company.checks.find(params[:id])
  end

  def check_params
    params.require(:check).permit(:number, :status, invoice_ids: []).except(:image) 
  end

  def base64_image_provided?
    params[:check][:image].is_a?(String) && params[:check][:image].start_with?("data:image")
  end

  def attach_base64_image
    base64_string = params[:check][:image].split(',')[1] # Extract Base64 data
    decoded_image = Base64.decode64(base64_string) # Decode Base64
  
    filename = "webcam_image_#{Time.now.to_i}.png"
    blob = ActiveStorage::Blob.create_and_upload!(
      io: StringIO.new(decoded_image),
      filename: filename,
      content_type: "image/png"
    )
  
    @check.image.attach(blob) # Attach image properly
  end
end
