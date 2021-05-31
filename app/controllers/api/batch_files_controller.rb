class Api::BatchFilesController < ApplicationController
  # связывание исключений при записи в БД с функцией формирвоания ответа
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  # связывание исключений при обработке файла некорректного формата (не xml) или структуры
  # NoMethodError добавлен, т.к. исключение вызывается если передан xml другой структуры,
  # при доступе в хэш по несуществующим ключам. Т.к. нет предварительной проверки структуры xml
  rescue_from REXML::ParseException, NoMethodError, with: :bad_request

  # обработка запроса на загрузку файла
  def create
    if params[:invoice_file].is_a? ActionDispatch::Http::UploadedFile
      # поступивший файл преобразуем из xml в hash, добавляем метод, чтобы все строковые ключи стали символьными
      process_batch_file(Hash.from_xml(File.read(params[:invoice_file].path)).deep_symbolize_keys)
    end
    render json: @batch_file, status: :created
  end

  private

  def file_params
    params.permit(:invoice_file)
  end

  def process_batch_file(file)
    ActiveRecord::Base.transaction do
      # достаем из файла guid и batch_id и создаем batch_file
      @batch_file = BatchFile.create!(guid: file[:Root][:FileAttribute][:GUID],
                                      batch_id: file[:Root][:FileData][:Batch][:BatchID])
      # вложенный хэш с инвойсами выносим в отдельный хэш либо массив
      invoices = file[:Root][:FileData][:Invoice]
      # если элемент Invoice один, то он прочитается как хэш, а не массив,
      # преобразуем его в массив (с одним элементом)
      invoices = [invoices] if invoices.instance_of?(Hash)
      # по каждому инвойсу собираем его атрибуты
      invoices.each do |invoice|
        operation = invoice[:InvoiceOperation]
        # создаем инвойс с атрибутами и ссылкой на batch_file
        inv = @batch_file.invoices.create!(CompanyCode: operation[:CompanyCode],
                                           InvoiceOperationNumber: operation[:InvoiceOperationNumber],
                                           InvoiceOperationDate: operation[:InvoiceOperationDate])
        # аналогично инвойсу выносим хэш с данными в отдельную переменную
        invoice_data = invoice[:InvoiceData]
        # если элемент с данными один, то он прочитаешь как хэш, а не массив,
        # преображуем его в массив (с одним элементом)
        invoice_data = [invoice_data] if invoice_data.instance_of?(Hash)
        # по каждому элементу с данными создаем запись со ссылкой на инвойс
        invoice_data.each do |data|
          inv.invoice_operations.create!(ParcelCode: data[:ParcelCode],
                                         ItemQty: data[:ItemQty],
                                         ParcelPrice: data[:ParcelPrice])
        end
      end
    end
  end

  # функция формирвоания ответа если запись в БД не прошла валидации и вызвала исключения
  def record_invalid(error)
    render json: { error: error.message }, status: :unprocessable_entity
  end

  # функция формирвоания ответа если файл некорректен по формату или по структуре
  def bad_request(_error)
    render json: { error: 'Неверный формат файла' }, status: :bad_request
  end
end
