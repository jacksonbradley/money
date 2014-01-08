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
    tmpHashKeepCategory = {}
    @get('modelForTrend.content').forEach (item) ->
      if tmpHashKeepCategory[item.get 'category_id']
        tmpHashKeepCategory[item.get 'category_id']['month'].push item.get 'month'
        tmpHashKeepCategory[item.get 'category_id']['total'].push item.get 'total'
      else
        tmpHashKeepCategory[item.get 'category_id'] = {}
        tmpHashKeepCategory[item.get 'category_id']['categoryName'] = item.get 'categoryName'
        tmpHashKeepCategory[item.get 'category_id']['month'] = []
        tmpHashKeepCategory[item.get 'category_id']['total'] = []
        tmpHashKeepCategory[item.get 'category_id']['month'].push item.get 'month'
        tmpHashKeepCategory[item.get 'category_id']['total'].push item.get 'total'
    for key, value of tmpHashKeepCategory
      data = 
        name: value['categoryName']
        data: value['total']
      categories.push data
    return categories

  # modelReadyChanged: ( ->
  #   if @get('model.isReady')
  #     @set 'isReadyToDraw', true
  # ).observes('model.isReady')