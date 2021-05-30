require 'rails_helper'

RSpec.describe Api::BatchFilesController, type: :controller do
  describe 'POST #create' do
    context 'with valid file' do

      it 'saves a new file in the database' do
        file = fixture_file_upload('sales_data.xml')
        expect do
          post :create,
               params: { invoice_file: file }
        end.to change(BatchFile, :count).by(1)
      end
    end
  end
end
