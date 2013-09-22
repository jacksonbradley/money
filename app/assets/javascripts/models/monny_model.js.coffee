Money.Monny = Ember.Object.extend
  category_id: 0
  categoryName: (->
    return category[this.get('category_id')]
  ).property('category_id')
  monthName: (->
    return monthName[@get('month')]
  ).property('month')
  monthFullName: (->
    return monthFullName[@get('month')]
  ).property('month')

Money.MonnyRecord = Money.Monny.extend
  category_id: 0
  id: 0
  amount: 0
  description: null
  day: 0
  month: 0
  year: 0
  date: (->
    return this.get('year') + "-" + this.get('month') + "-" + this.get('day')
  ).property('month','year','day')

Money.MonnySummary = Money.Monny.extend
  total: 0

Money.MonnyMonthlyCost = Money.Monny.extend
  month: 0
  total: 0
  
Money.MonnyTrend = Money.Monny.extend
  month: null
  total: null
  init: ->
    @_super()
    @set 'month',[]
    @set 'total',[]

category = {}
monthName = 
  1: 'Jan'
  2: 'Feb'
  3: 'Mar'
  4: 'Apr'
  5: 'May'
  6: 'Jun'
  7: 'Jul'
  8: 'Aug'
  9: 'Sep'
  10: 'Oct'
  11: 'Nov'
  12: 'Dec'

monthFullName = 
  1: 'January'
  2: 'February'
  3: 'March'
  4: 'April'
  5: 'May'
  6: 'June'
  7: 'July'
  8: 'August'
  9: 'September'
  10: 'October'
  11: 'November'
  12: 'December'

# records = Ember.ArrayProxy.create({content:[]})
# summarys = Ember.ArrayProxy.create({content:[]})

class ModelMgr
  queryTrend: (year) ->
    if not year?
      return []
    trends = Ember.ArrayProxy.create({content:[]})
    new Ember.RSVP.Promise (resolve) ->
      $.ajax '/api/trend',
      type: 'GET'
      dataType: 'json'
      data: 'y='+year
      handle: (data)->
        tmpHashKeepCategory = {}
        for raw in data.monny
          if tmpHashKeepCategory[raw.category_id]
            tmpHashKeepCategory[raw.category_id].get('month').push raw.month
            tmpHashKeepCategory[raw.category_id].get('total').push raw.total
          else
            item = Money.MonnyTrend.create()
            item.set 'category_id', raw.category_id
            item.get('month').push raw.month
            item.get('total').push raw.total
            trends.addObject item
            tmpHashKeepCategory[item.category_id] = item

        trends.set 'isReady', true
        trends.set 'year', year
        # console.log trends.get('firstObject')
        resolve(trends)
      success: (data, textStatus, jqXHR) ->
        @handle data
    return trends

  listMonth: (year) ->
    if not year?
      return []
    months = Ember.ArrayProxy.create({content:[]})
    new Ember.RSVP.Promise (resolve) ->
      $.ajax '/api/list',
      type: 'GET'
      dataType: 'json'
      data: 'y='+year
      handle: (data)->
        for raw in data.monny
          item = Money.MonnyMonthlyCost.create()
          item.month = raw.month
          item.total = raw.total
          months.addObject item
        months.set 'isReady', true
        months.set 'year', year
        resolve(months)
      success: (data, textStatus, jqXHR) ->
        @handle data
    return months

  queryRecord: (year, month) ->
    if not year?
      return []
    queryString = 'y='+year
    # records.clear()
    records = Ember.ArrayProxy.create({content:[]})
    if month? 
      queryString += '&m='+month
    new Ember.RSVP.Promise (resolve) ->
      $.ajax '/api/query',
      type: 'GET'
      dataType: 'json'
      data: queryString
      handle: (data)->
        for raw in data.monny
          record = Money.MonnyRecord.create()
          record.id = raw.id
          record.description = raw.description
          record.day = raw.day
          record.amount = raw.amount
          record.category_id = raw.category_id
          record.month = raw.month
          record.year = raw.year
          records.addObject record

        records.set 'year', year
        records.set 'month', month if month?
        resolve(records)
      success: (data, textStatus, jqXHR) ->
        @handle data
    return records

  querySummary: (year,month) ->
    if not year?
      return []
    queryString = 'y='+year
    if month? 
      queryString += '&m='+month
    summarys = Ember.ArrayProxy.create
      isReady: false
      content:[]

    new Ember.RSVP.Promise (resolve) ->
      $.ajax '/api/summary',
      type: 'GET'
      dataType: 'json'
      data: queryString
      handle: (data)->
        for raw in data.monny
          record = Money.MonnySummary.create()
          record.id = raw.id
          record.category_id = raw.category_id
          record.total = raw.total
          summarys.addObject record
        summarys.set 'isReady', true
        summarys.set 'year', year
        if month?
          summarys.set 'month', month 
          summarys.set 'monthFullName', monthFullName[month]

        resolve(summarys)
      success: (data, textStatus, jqXHR) ->
        @handle data
    return summarys
    
Money.ModelMgr = new ModelMgr

$.ajax '/api/category',
  type: 'GET'
  dataType: 'json'
  handle: (data)->
    for raw in data.monny
      category[raw.cid] = raw.name
  success: (data, textStatus, jqXHR) ->
    @handle data

