# @author weichien
class Api::MonnyController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def upload
    Rails.logger.debug { (current_user.to_yaml) }
    Rails.logger.debug { (params.inspect) }
    content_type = params[:file].content_type
    return false if content_type != 'text/csv'
    # TODO: need to check data more carefully.
    insert_to_db
  end

  def query
    Rails.logger.debug { (params.inspect) }
    respond_with current_user.money_records.query_record(params)
  end

  def category
    respond_with Category.all
  end

  def summary
    respond_with current_user.money_records.query_summary(params)
  end

  def list
    respond_with current_user.money_records.list_month(params)
  end

  def trend
    respond_with current_user.money_records.query_trend(params)
  end

  private

  def insert_to_db
    current_user.money_records.destroy_all
    file = params[:file].tempfile
    File.open(file, 'r').each_line do |line|
      data = line.split(',')
      next if data.length != 6
      record = current_user.money_records.build(get_hash(data))
      record.save
    end
  end

  def get_hash(data)
    {
      amount: data[0],
      category_id: data[1],
      description: data[2].sub(/^\"/, '').chomp("\"").strip,
      day: data[3],
      month: data[4],
      year: data[5]
    }
  end
end
