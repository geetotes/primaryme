$ ->
  class AppName.TitleView extends Backbone.View
    template: JST['templates/title']
    collection: new AppName.Members
    events:
      "keyup #search"      : "search",
      "click #app"            : "eventTest"
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
    search: =>
      console.log('search handler call')
      match = $('#search').val()
      #need to ignore a-z keys
      $('.member').each ->
        string = $(@).children('h4').first().text()
        #should switch the above to native javascript function, not jquery
        if $(@).hasClass('visible') and string.indexOf(match) == -1
          $(@).addClass('hidden')
          $(@).removeClass('visible')
        else
          #now need to split the string again to make a better match
          $(@).addClass('visible')
          $(@).removeClass('hidden')
          console.log('key' + match)
    render: =>
      @$el.html(@template)
      mapView = new AppName.MapView
      mapView.render()
      @

  class AppName.MembersView extends Backbone.View
    template: JST['templates/members']
    collection: AppName.Members

  class AppName.MemberView extends Backbone.View
    template: JST['templates/member']
    render: ->
      $(@el).html(@template(@model.toJSON()))
      @


  class AppName.MapView extends Backbone.View
    render: ->
      R = Raphael('map', 1000, 900)
      attr =
        "fill": "#d3d3d3",
        "stroke": "#fff",
        "stroke-opacity": "1",
        "stroke-linejoin": "round",
        "stroke-miterlimit": "4",
        "stroke-width": "0.75",
        "stroke-dasharray": "none"
      usRaphael = {}

      for state of usMap
        usRaphael[state] = R.path(usMap[state]).attr(attr)

