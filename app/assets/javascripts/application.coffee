#= require vendor
#= require_tree ./modules
#= require_tree ./templates

$(document).on 'click', 'a[href]:not([data-bypass])', (e) ->
  # Get the absolute anchor href.
  href =
    prop: $(this).prop("href")
    attr: $(this).attr("href")
  # Get the absolute root.
  root = location.protocol + "//" + location.host
  # Ensure the root is part of the anchor href, meaning it's relative.
  if href.prop.slice(0, root.length) is root
    # Stop the default event to ensure the link will not cause a page
    # refresh.
    e.preventDefault()

    # Remove root from attr as it's already in Backbone.history.root
    # href.attr = href.attr.replace(/^\/mobile\//, '')
    #
    # Backbone.history.navigate is sufficient for all Routers and will
    # trigger the correct events. The Router's internal `navigate` method
    # calls this anyways.
    Backbone.history.navigate href.attr, true
