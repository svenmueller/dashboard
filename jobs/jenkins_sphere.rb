require 'net/http'
require 'json'

url = 'http://hub.ci.cloud.commercetools.de/'
seconds_since_last_build_failed = 0
seconds_last_build_record = 0
is_any_build_failing = false

views = {
  sphere_base: { name: 'sphere', prio: 1 },
  sphere_deployment: { name: 'sphere_deployment', prio: 1 },
}


# Collect failing jobs
SCHEDULER.every '6s', :first_in => 0 do
  
  uri      = URI.parse(url)
  http     = Net::HTTP.new(uri.host, uri.port)
  api_url  = url + '/api/json?tree=jobs[name,color]'
  response = http.request(Net::HTTP::Get.new(api_url))
  jobs     = JSON.parse(response.body)['jobs']

  # Filter, what we want to see
  jobs_failed = jobs.select { |job|
    (!job['color'].include? 'blue') && (job['name'].include? 'sphere')
  }
  jobs_failed.map! { |job|
    { name: trim_job_name(job['name']), state: job['color'] }
  }

  jobs_building = jobs.select { |job|
    (job['color'].include? 'anime')
  }
  jobs_building.map! { |job|
    { name: trim_job_name(job['name']), state: job['color'] }
  }

  send_event('jenkins_jobs_sphere_failed', { jobs: jobs_failed })
end


# Collect job group status
SCHEDULER.every '6s', :first_in => 0 do

  views.each do |key, view|
    critical_count = 0
    warning_count  = 0

    uri      = URI.parse(url)
    http     = Net::HTTP.new(uri.host, uri.port)
    api_url  = url + '/view/' + view[:name] + '/api/json?tree=jobs[name,color]'
    response = http.request(Net::HTTP::Get.new(api_url))
    jobs     = JSON.parse(response.body)['jobs']

    jobs.each do |job|
      if job['color'].include? 'red'
        critical_count += 1
      elsif job['color'].include? 'yellow'
        warning_count += 1
      end
    end
    
    status = critical_count > 0 ? "danger" : (warning_count > 0 ? "warning" : "ok")

    is_any_build_failing = "ok" == status && !is_any_build_failing ? false : true;

    send_event('jenkins_status_view_' + key.to_s, { criticals: critical_count, warnings: warning_count, status: status, prio: view[:prio]})
  end
end


# Check since when the last buid failed and keep a record
SCHEDULER.every '1s', :first_in => 0 do |job|
  if is_any_build_failing
    seconds_last_build_record = seconds_since_last_build_failed > seconds_last_build_record ? seconds_since_last_build_failed : seconds_last_build_record
    seconds_since_last_build_failed = 0
  else
    seconds_since_last_build_failed += 1
  end

  send_event('jenkins_last_sphere_build_failed_since', { current: seconds_since_last_build_failed , last: seconds_last_build_record})
end
