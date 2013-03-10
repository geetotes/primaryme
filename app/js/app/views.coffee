$ ->
  class AppName.TitleView extends Backbone.View
    template: JST['templates/title']
    initialize: ->
      apiKey = 'api-key=e9dbe20ea8d501875e5ebdd0351caf4f:3:56645684'
      houseUrl = 'http://api.nytimes.com/svc/politics/v3/us/legislative/congress/113/house/members.jsonp?' + apiKey
      $.ajax
        dataType: 'json'
        url: '/housemembers'
        success: (data, textStatus, jqXHR) ->
          console.log('success!')
    
    render: ->
      $(@el).html(@template)
      @

  class AppName.MembersView extends Backbone.View
    template: JST['templates/members']
    collection: AppName.Members
