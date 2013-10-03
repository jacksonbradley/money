class Api::MonnyController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json
  # def default_serializer_options
  #   {root: false}
  # end

  def upload
    Rails.logger.debug {(current_user.to_yaml)}
    Rails.logger.debug {(params.inspect)}
    content_type = params[:file].content_type
    return false if content_type != "text/csv"
    #TODO need to check data more carefully.
    current_user.money_records.destroy_all
    file = params[:file].tempfile
    File.open(file, 'r').each_line do |line|
      data = line.split(',')
      next if data.length != 6

      record = current_user.money_records.build({
        :amount => data[0],
        :category_id => data[1],
        :description => data[2].sub(/^\"/, '').chomp("\"").strip, #remove " and whitespace in the begging and end.
        :day => data[3],
        :month => data[4],
        :year => data[5],
      })

      record.save
    end
  end

  def query
    Rails.logger.debug {(params.inspect)}
    respond_with current_user.money_records.queryRecord(params)
  end

  def category
    respond_with Category.all #, root:false
  end

  def summary
    respond_with current_user.money_records.querySummary(params)
  end

  def list
    respond_with current_user.money_records.listMonth(params)
  end

  def trend
    respond_with current_user.money_records.queryTrend(params)
  end
end
