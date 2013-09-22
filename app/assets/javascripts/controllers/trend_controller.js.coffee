Money.TrendController = Ember.ObjectController.extend
  dataReadyBinding: 'model.isReady'
  categoryDataReadyBinding: 'modelForTrend.isReady'

  lineChartData: ->
    series = []
    @get('model.content').forEach (item) ->
      data = [
        item.total
      ]
      series.push data
    return series

  lineChartCategory: ->
    categories = []
    @get('model.content').forEach (item) ->
      data = [
        item.get 'monthName'
      ]
      categories.push data
    return categories

  categoryLineChartCategory: ->
    categories = []
    @get('modelForTrend.content').forEach (item) ->
      data = 
        name: item.get 'categoryName'
        data: item.get 'total'
      
      categories.push data
    return categories

  # modelReadyChanged: ( ->
  #   if @get('model.isReady')
  #     @set 'isReadyToDraw', true
  # ).observes('model.isReady')