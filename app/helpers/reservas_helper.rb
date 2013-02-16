module ReservasHelper

	def status_reserva(status)
		case status
			when 'pendente'
				data = "<div class='label label-warning'>#{status}</div>"
			when 'confirmado'
				data = "<div class='label label-info'>#{status}</div>"
			else
				data = "<div class='label label-important'>#{status}</div>"
		end
		data.html_safe
	end

end