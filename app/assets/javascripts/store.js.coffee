# http://emberjs.com/guides/models/defining-a-store/

money_records_pattern = ///
  list.*
///

MyAdapter = DS.RESTAdapter.extend
  namespace: 'api'
  buildURL: (type,id)->
    url = @._super(type, id)
    return url

Money.Store = DS.Store.extend
  revision: 11
  adapter: MyAdapter

