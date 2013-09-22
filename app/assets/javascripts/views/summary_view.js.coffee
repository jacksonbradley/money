Money.SummaryView = Ember.View.extend
  elementReady: false
  dataReadyBinding: 'controller.isReadyToDraw'
  init: ->
    @_super()
    console.log 'SummaryView init'

  drawPieChart: ( ->
    # console.log "data "+@get('controller.isReadyToDraw')
    # console.log "element "+@get('elementReady')

    if @get('dataReady') and @get('elementReady')
      console.log "drawPieChart in SummaryView"
      year = @get 'controller.model.id'
      series = (@get 'controller').pieChartData()
      # $('#summary').highcharts (
      options =
        chart: 
          plotBackgroundColor: null
          plotBorderWidth: null
          plotShadow: false
          renderTo: 'summary'
        title: 
          text: year + ' Summary'
        # xAxis:
        #   categories: ['Apples', 'Bananas', 'Oranges']
        # yAxis: 
        #   title: 
        #     text: 'Fruit eaten'
        plotOptions:
          pie: 
            allowPointSelect: true
            cursor: 'pointer'
            dataLabels: 
              enabled: true
              color: '#000000'
              connectorColor: '#000000'
              format: '<b>{point.name}</b>: {point.percentage:.1f} %'
        series: [
          type: 'pie'
          name: 'NT'
          data: series
        ]
      # )
      chart = new Highcharts.Chart(options)
      # @get('controller').set('chart', chart)
  ).observes('dataReady', 'elementReady')

  didInsertElement: ->
    console.log "didInsertElement in SummaryView"
    @set 'elementReady', true

  willDestroyElement: ->
    console.log "willDestroyElement in SummaryView"
    # chart = @get('controller').get('chart')
    # if chart
    #   chart.destroy()