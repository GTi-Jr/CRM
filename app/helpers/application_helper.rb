module ApplicationHelper
	def toastr(message, type)
		render inline: javascript_tag("toastr.#{type}('#{message}')")
	end
end
