Money.SummaryMonthView = Ember.View.extend
  templateName: 'summaryMonth'
  dataReadyBinding: 'controller.isReadyToDraw'

  init: ->
    @_super()
    console.log 'SummaryMonthView init'

  drawPieChart: ( ->
    if @get('dataReady')
      console.log "drawPieChart in SummaryMonthView"
      monthFullName = @get 'controller.model.monthFullName'
      series = (@get 'controller').pieChartData()
      # chartId = "#"+@get('controller.chartId')
      # if @get('controller.chartCounter') >= 2
      # $('#summaryMonth').removeAttr('data-highcharts-chart')

      # $('#summaryMonth > div').remove()
        # return
        # if $('#summaryMonth')
        # $('#summaryMonth').destroy()
      $('#summaryMonth').highcharts (
      # options = 
        chart: 
          plotBackgroundColor: null
          plotBorderWidth: null
          plotShadow: false
          # renderTo: 'summaryMonth'
        title: 
          text: monthFullName + ' Summary'
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
      # chart = new Highcharts.Chart(options)
      )

  ).observes('dataReady')

  didInsertElement: ->
    console.log "didInsertElement in SummaryMonthView"

  # willClearRender: ->
  #   console.log "willDestroyElement in SummaryMonthView"
  #   $('#summaryMonth').destroy()
