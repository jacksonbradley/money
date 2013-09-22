Money.YearRoute = Ember.Route.extend
  renderTemplate: ->
    @render 'year'

  model: (params)->
    console.log "model #{params.year_id} in YearRoute"
    model = Money.ModelMgr.listMonth(params.year_id)
    model.then (resolve, reject)->
      resolve.set 'id', params.year_id
    # model.set 'id',params.year_id
    return model

  setupController: (controller, model) ->
    console.log "setupController in YearRoute"
    controller.set 'model', model
