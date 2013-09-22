# For more information see: http://emberjs.com/guides/routing/

Money.Router.map ()->
  @resource 'year', path: '/y/:year_id', () ->
    @resource 'month', path: '/m/:month_id'
  
  @resource 'summary', path: '/s/:year_id', ()->
    @resource 'summaryMonth', path: '/m/:month_id'

  @route 'trend', path: 't/:year_id'
  @route 'upload'
  

