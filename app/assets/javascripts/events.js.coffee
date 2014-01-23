$ ->

  $(document).on 'click', '.clear', (e) ->
    e.preventDefault()
    $('#read-count').html(0)
    stream.resetCount()
    graph.clear()
