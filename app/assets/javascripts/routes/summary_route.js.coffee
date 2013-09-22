Money.SummaryRoute = Ember.Route.extend
  # renderTemplate: ->
  #   @render 'summary'

  model: (params)->
    console.log "model #{params.year_id} in SummaryRoute"
    model = Money.ModelMgr.querySummary(params.year_id)
    model.set 'id',params.year_id
    return model

  setupController: (controller, model) ->
    console.log "setupController in SummaryRoute"
    controller.set 'model', model
    months = Money.ModelMgr.listMonth(model.id)
    controller.set 'months', months
