Money.MonthController = Ember.ObjectController.extend
  totalCost: (->
    totalCost = 0
    @get('model.content').forEach (item) ->
      totalCost += item.amount
    return totalCost
  ).property('model.content.length')

  actions:
    toSummaryMonth: (model) ->
      modelForSummary = Money.ModelMgr.querySummary(model.year, model.month)
      modelForSummary.set 'id', model.month
      @transitionToRoute 'summaryMonth', modelForSummary