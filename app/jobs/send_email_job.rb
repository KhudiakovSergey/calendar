class SendEmailJob < ActionMailer::DeliveryJob
  queue_as :default

  def perform(mailer, mail_method, delivery_method, *args)
    Sidekiq::Logging.logger.info 'Mail delivery started'
    mailer.constantize.public_send(mail_method, *args).send(delivery_method)
    Sidekiq::Logging.logger.info 'Mail delivery completed'
  end
end
