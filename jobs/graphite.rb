require "./lib/graphite"


SCHEDULER.every '30s', :first_in => 0 do
    # Create an instance of our helper class
    q = Graphite.new "http://username:password@datamine.misc.prod.commercetools.de:81/"

    url = "sumSeries(servers.de.commercetools.prod.grid.app*.commercetools.access.requests.total.5xx)"

    # get the current value
    current = q.value url, "-1min"
    # get points for the last half hour
    points = q.points url, "today"

    # send to dashboard, so the number the meter and the graph widget can understand it
    send_event 'status_5xx', { current: current, value: current, points: points }
end

SCHEDULER.every '30s', :first_in => 0 do
    # Create an instance of our helper class
    q = Graphite.new "http://username:password@datamine.misc.prod.commercetools.de:81/"

    url = "sumSeries(servers.de.commercetools.prod.grid.app*.commercetools.access.requests.total.2xx)"

    # get the current value
    current = q.value url, "-1min"
    # get points for the last half hour
    points = q.points url, "today"

    # send to dashboard, so the number the meter and the graph widget can understand it
    send_event 'status_2xx', { current: current, value: current, points: points }
end
