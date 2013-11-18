SCHEDULER.every '30s' do
  require 'bundler/setup'
  require "net/https"
  require "uri"



  environments = {
    grid_prod: { url: 'http://grid.commercetools.de/cgi-bin/icinga/', username: 'icingaguest', password: '', color_critical: 'red', color_warning: 'yellow', color_ok: 'green' },
    grid_stag: { url: 'http://monitoring.grid.cloud.commercetools.de/cgi-bin/icinga/', username: 'icingaguest', password: '', color_critical: 'orange', color_warning: 'yellow', color_ok: 'green' },
    sphere_prod: { url: 'http://monitoring.sphere.prod.commercetools.de/cgi-bin/icinga/', username: 'icingaguest', password: '', color_critical: 'red', color_warning: 'yellow', color_ok: 'green' },
    sphere_stag: { url: 'http://monitoring.sphere.cloud.commercetools.de/cgi-bin/icinga/', username: 'icingaguest', password: '', color_critical: 'orange', color_warning: 'yellow', color_ok: 'green' },
    misc_prod: { url: 'http://monitoring.misc.prod.commercetools.de/cgi-bin/icinga/', username: 'icingaguest', password: '', color_critical: 'red', color_warning: 'yellow', color_ok: 'green' },
    ci: { url: 'http://monitoring.ci.cloud.commercetools.de/cgi-bin/icinga/', username: 'icingaguest', password: '', color_critical: 'orange', color_warning: 'yellow', color_ok: 'green' },
    muc: { url: 'http://monitoring.muc.cloud.commercetools.de/cgi-bin/icinga/', username: 'icingaguest', password: '', color_critical: 'orange', color_warning: 'yellow', color_ok: 'green' }
  }

  environments.each do |key, env|

    critical_count = 0
    warning_count = 0

    begin
      uri = URI.parse(env[:url] + "status.cgi?servicestatustypes=20&serviceprops=42&host=all&nostatusheader&jsonoutput")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = false
      request = Net::HTTP::Get.new(uri.request_uri)
      request.basic_auth(env[:username], env[:password])
      response = http.request(request)   
    rescue => exception
      status = "unknown"
      puts "Connection problem: env: '#{key}', url: #{uri.host} message: (#{exception.message})"
    end

    if response != nil && response.code == "200"
      services = JSON.parse(response.body)["status"]["service_status"]

      services.each do |service|
        if service["status"].eql? "CRITICAL"
          critical_count += 1
        elsif service["status"].eql? "WARNING"
          warning_count += 1
        end
      end
      status = critical_count > 0 ? env[:color_critical] : (warning_count > 0 ? env[:color_warning] : env[:color_ok])
    end
   
    send_event('icinga-' + key.to_s, { criticals: critical_count, warnings: warning_count, status: status})
  end
end
