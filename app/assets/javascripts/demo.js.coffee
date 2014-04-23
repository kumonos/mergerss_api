cursor = '/api/1/articles.json'

load = ->
  $.ajax(cursor)
  .done (data) ->
    if data.status == 'OK'
      cursor = data.cursor if data.cursor != null
      template = Handlebars.compile($('#activity-template').html())
      $('#activities').append(template(data))
  .fail (jqxhr) ->
    if jqxhr.status == 404
      $('#activities').append($('#no-more-articles-template').html())

@show_member = (member_id) ->
  $.ajax('/api/1/members/' + member_id + '.json')
  .done (data) ->
    if data.status == 'OK'
      template = Handlebars.compile($('#member-template').html())
      $('#member').html(template(data));
      $('#member-modal').modal('show')

$ ->
  $('#load').click -> load()
  load()
