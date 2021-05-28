class FilesController < ApplicationController
  def create
    puts Hash.from_xml(file_params[:invoice_file].read)["Root"]["FileAttribute"]["GUID"]
    render json: nil
  end

  private
  def file_params
    params.permit(:invoice_file)
  end
end
