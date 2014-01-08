Money.SummaryRoute = Ember.Route.extend
  # renderTemplate: ->
  #   @render 'summary'

  model: (params)->
    console.log "model #{params.year_id} in SummaryRoute"
    model = Money.ModelMgr.querySummary(params.year_id)
    # model.set 'id', params.year_id
    return model

  setupController: (controller, model) ->
    console.log "setupController in SummaryRoute, #{model.query.y}"
    # model = Money.ModelMgr.querySummary(model.id)
    controller.set 'model', model

    months = Money.ModelMgr.listMonth(model.query.y)
    # months.then (resolve, reject)->
      # controller.set 'months', resolve
        
      #resolve.set 'id', model.id
    controller.set 'months', months
