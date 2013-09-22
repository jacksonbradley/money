Money.IndexRoute = Ember.Route.extend
  init: ->
    console.log "index route init"
  redirect: ->
    console.log "index redirect to year"
    @controllerFor('application').send 'toList'
    # currentTime = new Date()
    # year = currentTime.getFullYear()
    # model = Money.ModelMgr.listMonth(year)
    # # model.then (resolve, reject)->
    #   # resolve.set 'id', year
    # model.set 'id', year
    # @transitionTo 'year', model