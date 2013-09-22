Money.MonthRoute = Ember.Route.extend
  renderTemplate: ->
    @render 'month'

  model: (params)->
    year = @modelFor('year')
    model = Money.ModelMgr.queryRecord(year.id, params.month_id)
    model.set 'id',params.month_id
    return model

  setupController: (controller, model) ->
    console.log "setupController in MonthRoute"
    controller.set 'model', model
