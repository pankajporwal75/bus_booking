class AdminMailer < ApplicationMailer
  helper :Application
  default from: "admin@busreservation.com"

  def approve_email(bus)
    @bus = bus
    mail(to: @bus.bus_owner.email, subject: "Bus Approved!!")
  end

  def disapprove_email(bus)
    @bus = bus
    mail(to: @bus.bus_owner.email, subject: "Bus Disapproved!!")
  end

end
