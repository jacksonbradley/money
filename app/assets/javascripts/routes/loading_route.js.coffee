Money.LoadingRoute = Ember.Route.extend
  enter: ->
    console.log 'loading start'
    $('#loading-desc').removeClass('hide')

  exit: ->
    console.log 'loading end'
    $('#loading-desc').addClass('hide')
    