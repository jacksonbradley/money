# present money record
class MoneyRecord < ActiveRecord::Base
  belongs_to :user
  # default_scope { order("year DESC, month ASC, day ASC") }
  scope :expense, -> { where.not(category_id: 0) }

  def as_json(options = {})
    super(only: [:id, :amount, :category_id, :description,
                 :day, :month, :year, :total])
  end

  def self.list_month(params)
    if params[:y].present?
      r = where('year = ?', params[:y])
      r.expense.group(:month, :year).select(
        :month, :year, 'sum(amount) as total').order('month ASC')
    else
      expense.group(:year).select(:year)
    end
  end

  def self.query_record(params)
    if params[:y].present?
      r = where('year = ?', params[:y])
      r = r.where('month = ?', params[:m]) if params[:m].present?
      r = r.where('category_id = ?', params[:c]) if params[:c].present?
      r.expense
    else
      none
    end
  end

  def self.query_trend(params)
    if params[:y].present?# and params[:c].present?
      r = where('year = ?', params[:y])
      # r = where("category_id = ?", params[:c])
      r.expense.group(:category_id, :month).select(
        :category_id, :month, 'sum(amount) as total')
    else
      none
    end
  end

  def self.query_summary(params)
    if params[:y].present?
      r = where('year = ?', params[:y])
      r = r.where('month = ?', params[:m]) if params[:m].present?
      r.expense.group(:category_id).select(
        :category_id, 'sum(amount) as total')
    else
      none
    end
  end

end
