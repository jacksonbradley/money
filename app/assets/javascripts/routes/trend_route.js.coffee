Money.TrendRoute = Ember.Route.extend
  model: (params)->
    console.log "model in TrendRoute"
    # year = new Date().getFullYear()
    model = Money.ModelMgr.listMonth(params.year_id)
    model.year = params.year_id
    # summary_year = @modelFor('summary')
    # model = Money.ModelMgr.querySummary(summary_year.id, params.month_id)
    # model.set 'id',params.month_id
    return model

  setupController: (controller, model) ->
    console.log "setupController in TrendRoute"
    modelForTrend = Money.ModelMgr.queryTrend(model.year)
    controller.set 'model', model
    controller.set 'modelForTrend', modelForTrend