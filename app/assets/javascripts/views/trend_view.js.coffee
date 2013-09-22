Money.TrendView = Ember.View.extend
  elementReady: false
  dataReadyBinding: 'controller.dataReady'
  categoryDataReadyBinding: 'controller.categoryDataReady'

  drawLineChart: ( ->
    # console.log @get('dataReady')
    # console.log @get('elementReady')
    # console.log @get('categoryDataReady')
    # console.log "----"
    if @get('dataReady') && @get('elementReady') and @get('categoryDataReady')
      console.log "drawLineChart in TrendView"
      year = @get 'controller.model.year'
      series = (@get 'controller').lineChartData()
      categories = (@get 'controller').lineChartCategory()
      $('#yearTrend').highcharts (
        title: 
          text: 'Monthly Cost'
        xAxis:
          categories: categories
        yAxis: 
          title: 
            text: 'NT Dollar'
            plotLines : [
              value: 0
              width: 1
              color: '#808080'
            ]
        tooltip: 
          valueSuffix: ' NT'

        series: [
          name: year
          data: series
        ]
      )

      series = (@get 'controller').categoryLineChartCategory()
      $('#categoryTrend').highcharts (
        title: 
          text: 'Categories Cost'
        xAxis:
          categories: categories
        yAxis: 
          title: 
            text: 'NT Dollar'
            plotLines : [
              value: 0
              width: 1
              color: '#808080'
            ]
        tooltip: 
          valueSuffix: ' NT'
        legend: 
          layout: 'vertical'
          align: 'right'
          verticalAlign: 'middle'
          borderWidth: 0
        series: series
      )

  ).observes('dataReady', 'elementReady', 'categoryDataReady')

  didInsertElement: ->
    console.log "didInsertElement in TrendView"
    @set 'elementReady', true