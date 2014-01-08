Money.TrendController = Ember.ObjectController.extend
  dataReadyBinding: 'model.isLoaded'
  categoryDataReady: false
  # categoryDataChanged: (->
  #   self = @
  #   if @get('modelForTrend')
  #     model.then (resolve, reject) ->
  #       self.set 'categoryDataReady', true
  # ).observes('modelForTrend.isLoaded')

  lineChartData: ->
    series = []
    @get('model.content').forEach (item) ->
      data = [
        item.get 'total'
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

  categoryLineChartData: ->
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