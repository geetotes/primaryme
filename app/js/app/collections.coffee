$ ->
  class AppName.Members extends Backbone.Collection
    model: AppName.Member
    fetch: ->
      collection = @
      collectionHold = []
      $.ajax
        dataType: 'json'
        url: '/housemembers'
        success: (data, textStatus, jqXHR) ->
          for member in data.results[0].members
            model =  
                state : member.state
                first_name : member.first_name
                middle_name : member.middle_name
                last_name : member.last_name
                next_election : member.next_election
                party : member.party
            collectionHold.push model
          collection.reset collectionHold
