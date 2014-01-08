Money.SummaryMonthRoute = Ember.Route.extend

  model: (params)->
    console.log "model #{params.month_id} in SummaryMonthRoute"
    summary_year = @modelFor('summary')
    model = Money.ModelMgr.querySummary(summary_year.id, params.month_id)
    # model.set 'id',params.month_id
    return model

  setupController: (controller, model) ->
    console.log "setupController in SummaryMonthRoute"
    controller.set 'isReadyToDraw', false
    controller.set 'model', model
