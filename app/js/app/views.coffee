$ ->
  class AppName.TitleView extends Backbone.View
    template: JST['templates/title']
    collection: new AppName.Members
    events:
      "keypress #search": "search",
      "click #app": "eventTest"
    initialize: =>
      collectionHold = []
      @collection.bind('add', @addOne)
      @collection.bind('reset', @addAll)
      #@collection.bind( 'all', @render)
      $.ajax
        collection: @collection
        dataType: 'json'
        url: '/housemembers'
        success: (data, textStatus, jqXHR) ->
          collection = @collection
          for member in data.results[0].members
            model =
                state : member.state
                first_name : member.first_name
                middle_name : member.middle_name
                last_name : member.last_name
                next_election : member.next_election
                party : member.party
            collection.add model
            console.log('model added')
      #@collection.fetch()
    addOne: (model) ->
      view = new AppName.MemberView( {model: model} )
      $("#members").append(view.render().el)
    addAll: =>
      AppName.Members.each(@addOne)
      console.log('models added')
    eventTest: =>
      console.log('this is a test')
    search: ->
      string = $('#search').val()
      $('.member').each ->
        if $(@).css('display') != 'none' and this.id.contains(string) == false
          $(@).hide()
    render: =>
      $('#app').html(@template)
      @delegateEvents()
      @

  class AppName.MembersView extends Backbone.View
    template: JST['templates/members']
    collection: AppName.Members

  class AppName.MemberView extends Backbone.View
    template: JST['templates/member']
    render: ->
      $(@el).html(@template(@model.toJSON()))
      @
