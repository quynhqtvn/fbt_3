class UserMailer < ApplicationMailer
  default from: Settings.mail_from
  def book_tour book_tour
    @book_tour = book_tour
    mail to: Settings.mail_to, subject: t("mail.subject")
  end
end
