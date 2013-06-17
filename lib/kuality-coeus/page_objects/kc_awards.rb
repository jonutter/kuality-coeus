class KCAwards < BasePage

  tab_buttons
  global_buttons

  class << self

    def award_header_elements
      buttons 'Award', 'Contacts', 'Commitments', 'Budget Versions',
              'Payment, Reports & Terms', 'Special Review', 'Custom Data',
              'Comments, Notes & Attachments', 'Award Actions', 'Medusa'
      action(:time_and_money) { |b| b.frm.button(name: 'methodToCall.timeAndMoney').click; b.loading }
      element(:headerinfo_table) { |b| b.frm.div(id: 'headerarea').table(class: 'headerinfo') }
      # The 'header' prefix on these method names is to prevent collision...
      value(:header_pi) { |b| b.headerinfo_table[0][1].text }
      value(:header_lead_unit) { |b| b.headerinfo_table[1][1].text }
      value(:header_sponsor_name) { |b| b.headerinfo_table[2][1].text }
      value(:header_document_id) { |b| b.headerinfo_table[0][3].text[/\d+/] }
      value(:header_status) { |b| b.headerinfo_table[0][3].text[/(?<=:).*/] }
      value(:header_award_id) { |b| b.headerinfo_table[1][3].text[/.*(?=:)/] }
      value(:header_account) { |b| b.headerinfo_table[][].text }
      value(:header_last_update) { |b| b.headerinfo_table[][].text }
    end

  end

end