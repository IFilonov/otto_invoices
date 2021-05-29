class Api::FilesController < ApplicationController
  def create
    guid = Hash.from_xml(file_params[:invoice_file].read)['Root']['FileAttribute']['GUID']
    check_guid(guid)
    sleep 10
    render json: nil
  end

  private

  def file_params
    params.permit(:invoice_file)
  end

  def check_guid

  end
end