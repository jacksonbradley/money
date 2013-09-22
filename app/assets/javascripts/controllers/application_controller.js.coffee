Money.ApplicationController = Ember.ObjectController.extend
  selectedYear: 0
  listYear: (->
    return Money.ModelMgr.listYear()
  ).property()

  init: ->
    @_super()
    @set 'selectedYear', new Date().getFullYear()

  actions:
    toRoot: ->
      @transitionToRoute '/'

    toUpload: ->
      @transitionToRoute 'upload'

    toList: (year)->
      if year?
        @set 'selectedYear', year

      year = @get 'selectedYear'
      model = Money.ModelMgr.listMonth(@get 'selectedYear')
      model.then (resolve, reject)->
        resolve.set 'id', year
      # model.set 'id', @get 'currentYear'
      @transitionToRoute 'year', model

    toSummary: ->
      model = Money.ModelMgr.querySummary(@get 'selectedYear')
      model.set 'id', @get 'selectedYear'
      @transitionToRoute 'summary', model 

    toTrend: ->
      model = Money.ModelMgr.listMonth(@get 'selectedYear')
      year = @get 'selectedYear'
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