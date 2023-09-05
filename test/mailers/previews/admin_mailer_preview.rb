# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview

  def approve_email
    @bus = Bus.find(8)
    AdminMailer.with(bus: @bus).approve_email
  end
end
