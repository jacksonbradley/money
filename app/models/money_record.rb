class MoneyRecord < ActiveRecord::Base
  belongs_to :user
  scope :outcome, -> { where.not(category_id: 0) }

  def as_json(options={})
    super(only: [:id, :amount, :category_id, :description, :day, :month, :year, :total])
  end

  def self.listMonth(params)
    if params[:y].present?
      result = where("year = ?", params[:y])
      result.outcome.group(:month).select(:month, :year, "sum(amount) as total")
    else
      none
    end
  end

  def self.queryRecord(params)
    if params[:y].present?
      result = where("year = ?", params[:y])
      if params[:m].present?
        result = result.where("month = ?", params[:m])
      end
      if params[:c].present?
        result = result.where("category_id = ?", params[:c])
      end
      result.outcome
    else
      none
    end
  end

  def self.queryTrend(params)
    if params[:y].present?# and params[:c].present?
      result = where("year = ?", params[:y])
      # result = where("category_id = ?", params[:c])
      result.outcome.group(:category_id, :month).select(:category_id, :month, "sum(amount) as total")
    else
      none
    end
  end

  def self.querySummary(params)
    if params[:y].present?
      result = where("year = ?", params[:y])
      if params[:m].present?
        result = result.where("month = ?", params[:m])
      end
      result.outcome.group(:category_id).select(:category_id, "sum(amount) as total")
    else
      none
    end
  end

end
