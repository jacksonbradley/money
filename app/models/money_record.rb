# present money record
# class MoneyRecord < ActiveRecord::Base
class MoneyRecord
  include Mongoid::Document
  field :category_id, type: Integer
  field :description, type: String
  field :day, type: Integer
  field :month, type: Integer
  field :year, type: Integer
  field :amount, type: Integer
  field :total, type: Integer

  belongs_to :user
  # default_scope { order("year DESC, month ASC, day ASC") }
  # scope :expense, -> { where.not(category_id: 0) }
  scope :expense, -> { where(:category_id.gt => 0) }

  # def as_json(options = {})
  #   super(only: [:id, :amount, :category_id, :description,
  #                :day, :month, :year, :total])
  # end
  def self.group_by_year
    map = %Q(
      function(){
        emit(this.year, { year:this.year });
      }
    )
    reduce = %Q(
      function(key, values) {
        var result = { year: 0 };
        values.forEach(function(value) {
          result.year = value.year;
        });
        return result;
      }
    )
    
    result = []
    expense.map_reduce(map, reduce).out(inline: true).each do |document|
      result.push self.build_money_record_by_year(document)
    end
    result
  end

  def self.group_by_month(params)
    map = %Q(
      function(){
        emit(this.month, { year:this.year, month:this.month, amount:this.amount});
      }
    )
    reduce = %Q(
      function(key, values) {
        var result = { month: 0, total: 0 };
        values.forEach(function(value) {
          result.month = value.month;
          result.year = value.year;
          if (value.amount)
            result.total += value.amount;
          else
            result.total += value.total;
        });
        return result;
      }
    )
    
    result = []
    where(year: params[:y]).expense.map_reduce(map, reduce).out(inline: true).each do |document|
      result.push self.build_money_record_by_month(document)
    end
    result
  end

  def self.group_by_category(params)
    map = %Q(
      function(){
        emit(this.category_id, { category_id:this.category_id, amount:this.amount });
      }
    )
    reduce = %Q(
      function(key, values) {
        var result = { category_id: 0, total: 0 };
        values.forEach(function(value) {
          result.category_id = value.category_id;
          if (value.amount)
            result.total += value.amount;
          else
            result.total += value.total;
        });
        return result;
      }
    )
    final = %Q(
      function(key, value) {
        if (value.amount)
          value.total = value.amount
        return value;
      }
    )
    
    result = []
    r = where(year: params[:y])
    r = r.where(month: params[:m]) if params[:m].present?
    r.expense.map_reduce(map, reduce).out(inline: true).finalize(final).each do |document|
      result.push self.build_money_record_by_category(document)
    end
    result
  end

  def self.group_by_category_and_month(params)
    map = %Q(
      function(){
        emit(this.category_id+","+this.month, { category_id:this.category_id, amount:this.amount, month:this.month });
      }
    )
    reduce = %Q(
      function(key, values) {
        var result = { category_id: 0, total: 0, month: 0};
        values.forEach(function(value) {
          result.category_id = value.category_id;
          result.month = value.month;
          if (value.amount)
            result.total += value.amount;
          else
            result.total += value.total;
        });
        return result;
      }
    )
    final = %Q(
      function(key, value) {
        if (value.amount)
          value.total = value.amount
        return value;
      }
    )
    
    result = []
    r = where(year: params[:y])
    r.expense.map_reduce(map, reduce).out(inline: true).finalize(final).each do |document|
      result.push self.build_money_record_by_category_and_month(document)
      # Rails.logger.debug { document }
    end
    result
  end

  def self.build_money_record_by_year(document)
    value = document.fetch 'value'
    # monny = MoneyRecord.new
    monny = Year.new
    monny.year = value.fetch 'year'
    return monny
  end

  def self.build_money_record_by_category(document)
    value = document.fetch 'value'
    # monny = MoneyRecord.new
    monny = Summary.new
    monny.category_id = value.fetch 'category_id'
    monny.total = value.fetch 'total'
    return monny
  end

  def self.build_money_record_by_category_and_month(document)
    value = document.fetch 'value'
    monny = MoneyRecord.new
    monny.category_id = value.fetch 'category_id'
    monny.total = value.fetch 'total'
    monny.month = value.fetch 'month'
    return monny
  end

  def self.build_money_record_by_month(document)
    value = document.fetch 'value'
    monny = Month.new 
    # monny = MoneyRecord.new
    monny.total = value.fetch 'total'
    monny.month = value.fetch 'month'
    monny.year = value.fetch 'year'
    return monny
  end

  def self.list_month(params)
    self.group_by_month(params)
  end

  def self.list_year()
    self.group_by_year
  end

  def self.query_record(params)
    if params[:y].present?
      # r = where('year = ?', params[:y])
      r = where(year: params[:y])
      # # r = r.where('month = ?', params[:m]) if params[:m].present?
      r = r.where(month: params[:m]) if params[:m].present?
      # # r = r.where('category_id = ?', params[:c]) if params[:c].present?
      r = r.where(category_id: params[:c]) if params[:c].present?
      r.expense.asc(:_id)
    else
      none
    end
  end

  def self.query_trend(params)
    if params[:y].present?# and params[:c].present?
      # r = where('year = ?', params[:y])
      # r = where("category_id = ?", params[:c])
      # r.expense.group(:category_id, :month).select(
        # :category_id, :month, 'sum(amount) as total')
      self.group_by_category_and_month(params)
    else
      none
    end
  end

  def self.query_summary(params)
    if params[:y].present?
      # r = where('year = ?', params[:y])
      # r = r.where('month = ?', params[:m]) if params[:m].present?
      # r.expense.group(:category_id).select(
        # :category_id, 'sum(amount) as total')
      self.group_by_category(params)
    else
      none
    end
  end

end
