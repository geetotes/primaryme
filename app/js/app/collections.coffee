$ ->
  class AppName.Member extends Backbone.Model
    defaults:
      state: "AZ"
      first_name: "John"
      middle_name: "C"
      last_name: "McCain"
      next_election: "2003"
      party: "R"
$ ->
  class AppName.Members extends Backbone.Collection
    model: AppName.Member
