Money.ApplicationController = Ember.ObjectController.extend
  currentYear: (->
    return new Date().getFullYear()
  ).property()
  

  actions:
    toRoot: ->
      @transitionToRoute '/'

    toUpload: ->
      @transitionToRoute 'upload'

    toList: ->
      model = Money.ModelMgr.listMonth(@get 'currentYear')
      year = @get 'currentYear'
      model.then (resolve, reject)->
        resolve.set 'id', year
      # model.set 'id', @get 'currentYear'
      @transitionToRoute 'year', model

    toSummary: ->
      model = Money.ModelMgr.querySummary(@get 'currentYear')
      model.set 'id', @get 'currentYear'
      @transitionToRoute 'summary', model 

    toTrend: ->
      model = Money.ModelMgr.listMonth(@get 'currentYear')
      model.then (resolve, reject)->
        resolve.set 'id', year
        resolve.set 'year', year
      # model.set 'id', @get 'currentYear'
      # model.set 'year', @get 'currentYear'
      @transitionToRoute 'trend', model

    logout: ->
      $.ajax '/users/sign_out',
        type: 'DELETE'
        success: (result) ->
          console.log "sign out success"
          window.location.href = "/users/sign_in"