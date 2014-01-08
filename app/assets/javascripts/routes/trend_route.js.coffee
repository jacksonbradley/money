Money.TrendRoute = Ember.Route.extend
  model: (params)->
    console.log "model in TrendRoute"
    model = Money.ModelMgr.listMonth(params.year_id)
    return model

  setupController: (controller, model) ->
    console.log "setupController in TrendRoute #{model.id}"
    modelForTrend = Money.ModelMgr.queryTrend(model.id)
    modelForTrend.then (resolve, reject) ->
      controller.set 'categoryDataReady', true
    controller.set 'model', model
    controller.set 'modelForTrend', modelForTrend