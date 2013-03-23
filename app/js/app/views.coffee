$ ->
  class AppName.TitleView extends Backbone.View
    template: JST['templates/title']
    collection: new AppName.Members
    initialize: ->
      collectionHold = []
      @collection.bind('add', @addOne)
      @collection.bind('reset', @addAll)
      @collection.bind( 'all', @render)
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
    addAll: ->
      AppName.Members.each(@addOne)
    render: ->
      $(@el).html(@template)
      @

  class AppName.MembersView extends Backbone.View
    template: JST['templates/members']
    collection: AppName.Members

  class AppName.MemberView extends Backbone.View
    template: JST['templates/member']
    render: ->
      $(@el).html(@template(@model.toJSON()))
      @
