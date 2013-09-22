Money.UploadView = Ember.View.extend
  # isReadyToSubmit: 
  showMessage: ''
  didInsertElement: ->
    self = this
    options = 
      success: -> 
        self.set 'showMessage','import done. We are redirecting you to index page in 3 secs' 
        Ember.run.later self.get('controller'), ()->
          @transitionToRoute '/'
        ,3000
      error: ->
        self.set 'showMessage','import fail'
      beforeSubmit: ->
        $('#uploadForm-btn').prop('disabled',true);
        self.set 'showMessage','processing...' 

      url: 'api/upload'
      type: 'post'
    $('#uploadForm').ajaxForm(options);
  
  change: (event)->
    if event.target.value != ""
      $('#uploadForm-btn').prop('disabled',false);
    else
      $('#uploadForm-btn').prop('disabled',true);

          