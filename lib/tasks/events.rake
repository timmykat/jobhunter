namespace :events do
  desc "Migrate opportunity events to new event structure"
  task migrate: :environment do
    Opportunity.all.each do |opportunity|
      puts opportunity.company
      if opportunity.phone_interview_scheduled?
        puts "Phone: #{opportunity.phone_interview.to_formatted_s(:short)}"
        
        # Create new event
        event = Event.new
        event.event_type = 'Phone interview'
        event.event_time = opportunity.phone_interview
        event.opportunity_id = opportunity.id
        if !event.save
          puts "Phone interview event not properly created"
        end
      end
      if opportunity.on_site_interview_scheduled?
        puts "On-site: #{opportunity.on_site_interview.to_formatted_s(:short)}"
        # Create new event
        event = Event.new
        event.event_type = 'On-site interview'
        event.event_time = opportunity.phone_interview
        event.opportunity_id = opportunity.id
        if !event.save
          puts "On-site interview event not properly created"
        end
      end
      puts "\n------\n"
    end
  end

end
