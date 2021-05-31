require 'rails_helper'
include ActionDispatch::TestProcess::FixtureFile

RSpec.describe Api::BatchFilesController, type: :controller do
  describe 'POST #create' do
    context 'with valid file' do
      it 'saves in the database' do
        file = fixture_file_upload('sales_data.xml')
        post :create, params: { invoice_file: file }
        expect(response).to have_http_status :created
        expect(BatchFile.count).to eq 1
        expect(Invoice.count).to eq 2
        expect(InvoiceOperation.count).to eq 3
      end
    end
  end

  context 'with invalid data in file' do
    it 'does not save in the database' do
      file = fixture_file_upload('sales_data_invalid.xml')
      post :create, params: { invoice_file: file }
      expect(response).to have_http_status :unprocessable_entity
      expect(BatchFile.count).to eq 0
      expect(Invoice.count).to eq 0
      expect(InvoiceOperation.count).to eq 0
    end
  end

  context 'with other format file' do
    it 'does not save in the database' do
      file = fixture_file_upload('other_format.csv')
      post :create, params: { invoice_file: file }
      expect(response).to have_http_status :bad_request
      expect(BatchFile.count).to eq 0
    end
  end

  context 'with other xml structure file' do
    it 'does not save in the database' do
      file = fixture_file_upload('other_xml_structure.xml')
      post :create, params: { invoice_file: file }
      expect(response).to have_http_status :bad_request
      expect(BatchFile.count).to eq 0
    end
  end
end
