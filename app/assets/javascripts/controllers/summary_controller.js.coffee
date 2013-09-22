Money.SummaryController = Ember.ObjectController.extend
  isReadyToDrawBinding: 'model.isReady'
  # chart: null
  # totalCost: (->
  #   totalCost = 0
  #   @get('model.content').forEach (item) ->
  #     totalCost += item.total
  #   return totalCost
  # ).property('model.content')

  pieChartData: ->
    # totalCost = @get 'totalCost'
    series = []
    @get('model.content').forEach (item) ->
      data = [
        item.get 'categoryName'
        item.total
      ]
      series.push data
    return series

  # modelReadyChanged: ( ->
  #   if @get('model.isReady')
  #     @set 'isReadyToDraw', true
  # ).observes('model.isReady')
 
  actions:
    toMonth: (month) ->
      year = @get 'model.id'
      model = Money.ModelMgr.querySummary(year, month)
      model.set 'id', month
      @transitionToRoute 'summaryMonth', model