Money.SummaryController = Ember.ObjectController.extend
  isReadyToDrawBinding: 'model.isLoaded'
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
        item.get 'total'
      ]
      series.push data
    return series

  # modelReadyChanged: ( ->
  #   if @get('model.isReady')
  #     @set 'isReadyToDraw', true
  # ).observes('model.isReady')
 
  actions:
    toMonth: (month) ->
      year = @get 'model.year'
      model = Money.ModelMgr.querySummary(year, month)
      @transitionToRoute 'summaryMonth', model