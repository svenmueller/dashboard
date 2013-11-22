require "./lib/graphite"

credentials_file = File.dirname(File.expand_path(__FILE__)) + '/../credentials.yml'
credentials = YAML::load(File.open(credentials_file))

url = "http://#{credentials['graphite']['username']}:#{credentials['graphite']['password']}@datamine.misc.prod.commercetools.de:81/"


SCHEDULER.every '30s', :first_in => 0 do

    # Create an instance of our helper class
    q = Graphite.new url

    name = "sumSeries(servers.de.commercetools.prod.grid.app*.commercetools.access.requests.total.5xx)"

    # get the current value
    current = q.value name, "-1min"
    # get points for the last half hour
    points = q.points name, "-1h"

    # send to dashboard, so the number the meter and the graph widget can understand it
    send_event 'status_5xx', { current: current, value: current, points: points, graphcolor: "#fff"}
end

SCHEDULER.every '30s', :first_in => 0 do
    # Create an instance of our helper class
    q = Graphite.new url

    name = "sumSeries(servers.de.commercetools.prod.grid.app*.commercetools.access.requests.total.2xx)"

    # get the current value
    current = q.value name, "-1min"
    # get points for the last half hour
    points = q.points name, "-1h"

    # send to dashboard, so the number the meter and the graph widget can understand it
    send_event 'status_2xx', { current: current, value: current, points: points, graphcolor: "#fff" }
end

SCHEDULER.every '30s', :first_in => 0 do
    # Create an instance of our helper class
    q = Graphite.new url

    name = "sumSeries(servers.de.commercetools.cloud.grid.app*.commercetools.gridevents.events)"

    # get the current value
    current = q.value name, "-1min"
    # get points for the last half hour
    points = q.points name, "-1h"

    # send to dashboard, so the number the meter and the graph widget can understand it
    send_event 'events', { current: current, value: current, points: points, graphcolor: "#fff" }
end

SCHEDULER.every '30s', :first_in => 0 do
    # Create an instance of our helper class
    q = Graphite.new url

    name = "sumSeries(servers.de.commercetools.cloud.grid.app*.commercetools.gridevents.exceptions)"

    # get the current value
    current = q.value name, "-1min"
    # get points for the last half hour
    points = q.points name, "-1h"

    # send to dashboard, so the number the meter and the graph widget can understand it
    send_event 'errors', { current: current, value: current, points: points, graphcolor: "#fff"}
end
