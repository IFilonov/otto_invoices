class Api::BatchFilesController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  def create
    process_batch_file(Hash.from_xml(file_params[:invoice_file].read).deep_symbolize_keys)
    render json: @batch_file, status: :created
  end

  private

  def file_params
    params.permit(:invoice_file)
  end

  def process_batch_file(file)
    ActiveRecord::Base.transaction do
      @batch_file = BatchFile.create!(guid: file[:Root][:FileAttribute][:GUID],
                                      batch_id: file[:Root][:FileData][:Batch][:BatchID])
      invoices = file[:Root][:FileData][:Invoice]
      invoices = [invoices] if invoices.instance_of?(Hash)
      invoices.each do |invoice|
        operation = invoice[:InvoiceOperation]
        inv = @batch_file.invoices.create!(CompanyCode: operation[:CompanyCode],
                                           InvoiceOperationNumber: operation[:InvoiceOperationNumber],
                                           InvoiceOperationDate: operation[:InvoiceOperationDate])
        invoice_data = invoice[:InvoiceData]
        invoice_data = [invoice_data] if invoice_data.instance_of?(Hash)
        invoice_data.each do |data|
          inv.invoice_operations.create!(ParcelCode: data[:ParcelCode],
                                         ItemQty: data[:ItemQty],
                                         ParcelPrice: data[:ParcelPrice])
        end
      end
    end
  end

  def record_invalid(error)
    render json: { error: error.message }, status: :unprocessable_entity
  end
end
