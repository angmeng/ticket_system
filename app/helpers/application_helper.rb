module ApplicationHelper
	def general_active(active, f)
	    if active.present?
        	f.select :active_equals, options_for_select(SelectionActive::OPTION, active), { :include_blank => true }, { :style => "width: 70px;" }
        else
            f.select :active_equals, options_for_select(SelectionActive::OPTION), { :include_blank => true }, { :style => "width: 70px;" }
        end
     end
end