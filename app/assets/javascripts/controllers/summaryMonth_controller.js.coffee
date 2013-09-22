Money.SummaryMonthController = Ember.ObjectController.extend
  # chartCounter: 0
  # chartId: (->
  #   return "summaryMonth" + @get('chartCounter')
  # ).property('chartCounter')
  init: ->
    @_super()
    console.log "SummaryMonthController init"

  isReadyToDrawBinding: 'model.isReady'
  # totalCost: (->
  #   totalCost = 0
  #   @get('model.content').forEach (item) ->
  #     totalCost += item.total
  #   return totalCost
  # ).property('model.content')

  pieChartData: ->
    # @incrementProperty 'chartCounter'
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
 
