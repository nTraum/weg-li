# Preview all emails at http://localhost:3000/rails/mailers/
class NoticeMailerPreview < ActionMailer::Preview
  def charge
    notice = Notice.shared.first!

    NoticeMailer.charge(notice)
  end

  def charge_via_pdf
    notice = Notice.shared.first!

    NoticeMailer.charge(notice, to: 'uschi@muschi.de', send_via_pdf: true)
  end

  def charge_dresden
    notice = Notice.shared.first!

    NoticeMailer.charge(notice, config: :dresden)
  end

  def forward
    notice = Notice.shared.first!

    token = '12345t5r65t4regafsvcbsgasfdffdf'
    NoticeMailer.forward(notice, token)
  end
end
