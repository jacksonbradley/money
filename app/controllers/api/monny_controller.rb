# @author weichien
class Api::MonnyController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json
  # def default_serializer_options
  #   {root: false}
  # end

  def upload
    Rails.logger.debug { (current_user.to_yaml) }
    Rails.logger.debug { (params.inspect) }
    content_type = params[:file].content_type
    return false if content_type != 'text/csv'
    # TODO: need to check data more carefully.
    insert_to_db
  end

  def query
    respond_with current_user.money_records.query_record(params), root: 'records'
  end

  def category
    respond_with Category.all, root: 'categorys'
  end

  def summary
    respond_with current_user.money_records.query_summary(params), root: 'summarys'
  end

  def list
    if params[:y].present?
      respond_with current_user.money_records.list_month(params), root: 'months'
    else
      respond_with current_user.money_records.list_year(), root: 'years'
    end
  end

  def trend
    respond_with current_user.money_records.query_trend(params), root: 'trends'
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
