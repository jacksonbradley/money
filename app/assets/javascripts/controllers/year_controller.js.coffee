Money.YearController = Ember.ObjectController.extend
  isNoRecord: (->
    if @get('model.content.length') > 0
      return false
    else  
      return true
  ).property('model.content.length')
 
  # months: (->
  #   months = []
  #   @get('model.content').forEach (item) ->
  #     if $.inArray(item, months) == -1
  #       months.push item
  #   return months
  # ).property('model.content.length')

  actions:
    toMonth: (month) ->
      year = @get 'model.id'
      modelForMonth = Money.ModelMgr.queryRecord(year, month)
      modelForMonth.set 'id', month
      @transitionToRoute 'month', modelForMonth