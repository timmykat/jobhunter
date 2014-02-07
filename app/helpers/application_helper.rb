module ApplicationHelper
  def select_options(entity)
    options = [["--Select a #{entity.to_s}--", nil]]
    entity.to_s.titlecase.constantize.all.each do |item|
      case entity
        when :recruiter, :opportunity
          display_text = item.company
        when :state
          display_text = item.state
        when :contact
          display_text = item.name
      end 
      options << [display_text, item.id]
    end
    options
  end
end
