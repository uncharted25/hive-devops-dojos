#!/usr/bin/env ruby
require 'json'

report = JSON.parse(ARGF.read)
failed = []

report.each do |feature|
  feature['elements'].each do |scenario|
    next unless %w(scenario background).include? scenario['type']

    if scenario.key? 'before'
      scenario['before'].each do |step|
        if %w(failed undefined).include? step['result']['status']
          f = {
            feature: feature['name'],
            scenario: scenario['name'],
            step: 'Before hook',
            failure: step['result']['error_message']
          }

          f[:step] += ": #{step['match']['location']}" if step.key? 'match'

          failed << f
          break
        end
      end
    end

    scenario['steps'].each do |step|
      next unless step.key? 'result'
      if 'failed' == step['result']['status']
        failed << {
          feature: feature['name'],
          scenario: scenario['name'],
          step: step['keyword'] + step['name'],
          failure: step['result']['error_message']
        }
        break
      end
    end
  end
end

failed.each do |failure|
  puts "BUILD-#{ENV["BUILD_ID"]} ; #{failure[:feature]} ; #{failure[:scenario]} ; #{failure[:step]} ; #{failure[:failure]}"
end
