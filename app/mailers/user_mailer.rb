class UserMailer < ApplicationMailer
  default from: Settings.mail_from
  def book_tour book_tour
    @book_tour = book_tour
    mail to: Settings.mail_to, subject: t("mail.subject")
  end

  def revenue_everyday venue
    @venue = venue
    mail to: Settings.mail_to, subject: "revenue in this day"
  end
end
