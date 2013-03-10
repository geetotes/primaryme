$ ->
  class AppName.TitleView extends Backbone.View
    template: JST['templates/title']
    initialize: ->
      $.ajax
        dataType: 'json'
        url: '/housemembers'
        success: (data, textStatus, jqXHR) ->
          for member in data.results[0].members
            console.log(member.state)
    
    render: ->
      $(@el).html(@template)
      @

  class AppName.MembersView extends Backbone.View
    template: JST['templates/members']
    collection: AppName.Members
