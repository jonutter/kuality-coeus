class KCAwards < BasePage

  tab_buttons
  global_buttons
  error_messages

  buttons 'Award', 'Contacts', 'Commitments', 'Budget Versions',
          'Payment, Reports & Terms', 'Special Review', 'Custom Data',
          'Comments, Notes & Attachments', 'Award Actions', 'Medusa'
  value(:doc_title) { |b| b.frm.div(id: 'headerarea').h1.text }
  action(:time_and_money) { |b| b.t_m_button.click; b.loading }
  element(:t_m_button) { |b| b.frm.button(name: 'methodToCall.timeAndMoney') }
  element(:headerinfo_table) { |b| b.frm.div(id: 'headerarea').table(class: 'headerinfo') }
  # The 'header' prefix on these method names is to prevent collision...
  value(:header_pi) { |b| b.headerinfo_table[0][1].text }
  value(:header_lead_unit) { |b| b.headerinfo_table[1][1].text }
  value(:header_sponsor_name) { |b| b.headerinfo_table[2][1].text }
  value(:header_document_id) { |b| b.headerinfo_table[0][3].text[/\d+/] }
  value(:header_status) { |b| b.headerinfo_table[0][3].text[/(?<=:).*/] }
  value(:header_award_id) { |b| b.headerinfo_table[1][3].text[/.*(?=:)/] }
  value(:header_account) { |b| b.headerinfo_table[1][3].text[/(?<=:).*/] }
  value(:header_last_update) { |b| b.headerinfo_table[2][3].text }

  class << self

    def report_types *types
      types.each_with_index do |type, index|
        # This line is here because the field values inexplicably skip the number 2.
        i = index > 1 ? index+1 : index
        name=damballa(type)
        tag=type.gsub(/([\s\/])/,'')
        element("#{name}_report_type".to_sym) { |b| b.reports_div.select(name: "awardReportsBean.newAwardReportTerms[#{i}].reportCode") }
        element("#{name}_frequency".to_sym) { |b| b.reports_div.select(name: "awardReportsBean.newAwardReportTerms[#{i}].frequencyCode") }
        element("#{name}_frequency_base".to_sym) { |b| b.reports_div.select(name: "awardReportsBean.newAwardReportTerms[#{i}].frequencyBaseCode") }
        action("add_#{name}_report".to_sym) { |b| b.reports_div.button(name: /anchorReportClasses:#{tag}$/).click; b.loading }
      end
    end

    def terms *terms
      terms.each_with_index do |term, index|
        name=damballa(term)
        tag=term.gsub(/([\s\/])/,'')
        element("#{name}_code".to_sym) { |b| b.frm.text_field(name: "sponsorTermFormHelper.newSponsorTerms[#{index}].sponsorTermCode") }
        action("add_#{name}_term") { |b| b.frm.button(name: /addAwardSponsorTerm.+anchorAwardTerms:#{tag}Terms/).click; b.loading }
      end
    end
    
  end

end