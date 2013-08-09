class BasePage < PageFactory

  action(:use_new_tab) { |b| b.windows.last.use }
  action(:return_to_portal) { |b| b.portal_window.use }
  action(:close_children) { |b| b.windows[1..-1].each{ |w| w.close} }
  action(:close_parents) { |b| b.windows[0..-2].each{ |w| w.close} }
  action(:loading) { |b| b.frm.image(alt: 'working...').wait_while_present }
  element(:logout_button) { |b| b.button(title: 'Click to logout.') }
  action(:logout) { |b| b.logout_button.click }

  element(:portal_window) { |b| b.windows(title: 'Kuali Portal Index')[0] }

  action(:form_tab) { |name, b| b.frm.h2(text: /#{name}/) }
  action(:form_status) { |name, b| b.form_tab(name).text[/(?<=\()\w+/] }

  class << self

    def glbl(*titles)
      titles.each do |title|
        action(damballa(title)) { |b| b.frm.button(class: 'globalbuttons', title: title).click; b.loading }
      end
    end

    def document_header_elements
      value(:doc_title) { |b| b.frm.div(id: 'headerarea').h1.text }
      element(:headerinfo_table) { |b| b.frm.div(id: 'headerarea').table(class: 'headerinfo') }
      value(:document_id) { |p| p.headerinfo_table[0][1].text }
      alias_method :doc_nbr, :document_id
      value(:document_status) { |p| p.headerinfo_table[0][3].text }
      value(:initiator) { |p| p.headerinfo_table[1][1].text }
      alias_method :disposition, :initiator
      value(:last_updated) {|p| p.headerinfo_table[1][3].text }
      alias_method :created, :last_updated
      value(:committee_id) { |p| p.headerinfo_table[2][1].text }
      alias_method :sponsor_name, :committee_id
      alias_method :budget_name, :committee_id
      value(:committee_name) { |p| p.headerinfo_table[2][3].text }
      alias_method :pi, :committee_name
    end

    # Included here because this is such a common field in KC
    def description_field
      element(:description) { |b| b.frm.text_field(name: 'document.documentHeader.documentDescription') }
    end

    def global_buttons
      glbl 'save', 'Reject', 'blanket approve', 'close', 'cancel', 'reload',
           'Delete Proposal', 'approve', 'disapprove',
           'Generate All Periods', 'Calculate All Periods', 'Default Periods',
           'Calculate Current Period', 'submit', 'Send Notification'
      # Explicitly defining the "recall" button to keep the method name at "recall" instead of "recall_current_document"...
      element(:recall_button) { |b| b.frm.button(class: 'globalbuttons', title: 'Recall current document') }
      action(:recall) { |b| b.recall_button.click; b.loading }
      action(:edit) { |b| b.frm.button(name: 'methodToCall.editOrVersion').click; b.loading }
      action(:delete_selected) { |b| b.frm.button(class: 'globalbuttons', name: 'methodToCall.deletePerson').click; b.loading }
      element(:send_button) { |b| b.frm.button(class: 'globalbuttons', name: 'methodToCall.sendNotification', title: 'send') }
      action(:send_fyi) { |b| b.send_button.click; b.loading }
    end

    def tab_buttons
      action(:expand_all) { |b| b.frm.button(name: 'methodToCall.showAllTabs').click; b.loading }
    end

    def tiny_buttons
      action(:search) { |b| b.frm.button(title: 'search', value: 'search').click; b.loading }
      action(:clear) { |b| b.frm.button(name: 'methodToCall.clearValues').click; b.loading }
      action(:cancel_button) { |b| b.frm.link(title: 'cancel').click; b.loading }
      action(:yes) { |b| b.frm.button(name: 'methodToCall.rejectYes').click; b.loading }
      action(:no) {|b| b.frm.button(name: 'methodToCall.rejectNo').click; b.loading }
      action(:add) { |b| b.frm.button(name: 'methodToCall.addNotificationRecipient.anchor').click; b.loading }
    end

    def search_results_table
      element(:results_table) { |b| b.frm.table(id: 'row') }

      action(:edit_item) { |match, p| p.results_table.row(text: /#{match}/m).link(text: 'edit').click; b.use_new_tab; b.close_parents }
      alias_method :edit_person, :edit_item

      action(:item_row) { |match, b| b.results_table.row(text: /#{match}/m) }
      action(:open_item) { |match, b| b.item_row(match).link(text: /#{match}/).click; b.use_new_tab; b.close_parents }
      action(:delete_item) { |match, p| p.item_row(match).link(text: 'delete').click; p.use_new_tab; p.close_parents }

      action(:return_value) { |match, p| p.item_row(match).link(text: 'return value').click }
      action(:return_random) { |b| b.return_value_links[rand(b.return_value_links.length)].click }
      element(:return_value_links) { |b| b.results_table.links(text: 'return value') }
    end

    def budget_header_elements
      action(:return_to_proposal) { |b| b.frm.button(name: 'methodToCall.returnToProposal').click; b.loading }
      buttons 'Budget Version', 'Parameters', 'Rates', 'Summary', 'Personnel', 'Non-Personnel',
              'Distribution & Income', 'Budget Actions'
      # Need the _tab suffix because of method collisions
      action(:modular_budget_tab) { |b| b.frm.button(value: 'Modular Budget').click }
    end

    def budget_versions_elements
      element(:name) { |b| b.frm.text_field(name: 'newBudgetVersionName') }
      action(:add) { |b| b.frm.button(name: 'methodToCall.addBudgetVersion').click }
      action(:version) { |budget, p| p.budgetline(budget).td(class: 'tab-subhead', index: 2).text }
      action(:direct_cost) { |budget, p| p.budgetline(budget).td(class: 'tab-subhead', index: 3).text }
      action(:f_and_a) { |budget, p| p.budgetline(budget).td(class: 'tab-subhead', index: 4).text }
      action(:total) { |budget, p| p.budgetline(budget).td(class: 'tab-subhead', index: 5).text }
      # Called "budget status" to avoid method collision...
      action(:budget_status) { |budget, p| p.budgetline(budget).select(title: 'Budget Status') }
      action(:open) { |budget, p| p.budgetline(budget).button(alt: 'open budget').click }
      action(:copy) { |budget, p| p.budgetline(budget).button(alt: 'copy budget').click }
      action(:f_and_a_rate_type) { |budget, p| p.budget_table(budget)[0][3].text }
      action(:cost_sharing) { |budget, p| p.budget_table(budget)[1][1].text }
      action(:budget_last_updated) { |budget, p| p.budget_table(budget)[1][3].text }
      action(:unrecovered_f_and_a) { |budget, p| p.budget_table(budget)[2][1].text }
      action(:last_updated_by) { |budget, p| p.budget_table(budget)[2][3].text }
      action(:comments) { |budget, p| p.budget_table(budget)[3][1].text }

      private
      element(:b_v_table) { |b| b.frm.table(id: 'budget-versions-table') }
      action(:budgetline) { |budget, p| p.b_v_table.td(class: 'tab-subhead', text: budget).parent }
      action(:budget_table) { |budget, p| p.b_v_table.tbodys[p.target_index(budget)].table }
      action(:target_index) do |budget, p|
        i=p.b_v_table.tbodys.find_index { |tbody| tbody.td(class: 'tab-subhead', index: 1).text==budget }
        i+1
      end
    end

    def special_review
      element(:add_type) { |b| b.frm.select(id: 'specialReviewHelper.newSpecialReview.specialReviewTypeCode') }
      element(:add_approval_status) { |b| b.frm.select(id: 'specialReviewHelper.newSpecialReview.approvalTypeCode') }
      element(:add_protocol_number) { |b| b.frm.text_field(id: 'specialReviewHelper.newSpecialReview.protocolNumber') }
      element(:add_application_date) { |b| b.frm.text_field(id: 'specialReviewHelper.newSpecialReview.applicationDate') }
      element(:add_approval_date) { |b| b.frm.text_field(id: 'specialReviewHelper.newSpecialReview.approvalDate') }
      element(:add_expiration_date) { |b| b.frm.text_field(id: 'specialReviewHelper.newSpecialReview.expirationDate') }
      element(:add_exemption_number) { |b| b.frm.select(id: 'specialReviewHelper.newSpecialReview.exemptionTypeCodes') }

      action(:add) { |b| b.frm.button(name: 'methodToCall.addSpecialReview.anchorSpecialReview').click }

      element(:save_button) { |b| b.frm.button(name: 'methodToCall.save') }
    end

    def custom_data
      element(:graduate_student_count) { |b| b.target_row('Graduate Student Count').text_field }
      element(:billing_element) { |b| b.target_row('Billing Element').text_field }
      element(:save_button) { |b| b.frm.button(name: 'methodToCall.save') }
      element(:asdf_tab) { |b| b.frm.div(id: 'tab-asdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdf-div') }
      action(:target_row) { |text, b| b.frm.trs(class: 'datatable').find { |row| row.text.include? text } }
    end

    def route_log
      element(:route_log_iframe) { |b| b.frm.frame(name: 'routeLogIFrame') }
      element(:actions_taken_table) { |b| b.route_log_iframe.div(id: 'tab-ActionsTaken-div').table }
      value(:actions_taken) { |b| (b.actions_taken_table.rows.collect{ |row| row[1].text }.compact.uniq).reject{ |action| action==''} }
      element(:pnd_act_req_table) { |b| b.route_log_iframe.div(id: 'tab-PendingActionRequests-div').table }
      value(:action_requests) { |b| (b.pnd_act_req_table.rows.collect{ |row| row[1].text}).reject{ |action| action==''} }
      action(:show_future_action_requests) { |b| b.route_log_iframe.h2(text: 'Future Action Requests').parent.parent.image(title: 'show').click }
      element(:future_actions_table) { |b| b.route_log_iframe.div(id: 'tab-FutureActionRequests-div').table }
      action(:requested_action_for) { |name, b| b.future_actions_table.tr(text: /#{name}/).td(index: 2).text }
    end

    # Gathers all errors on the page and puts them in an array called "errors"
    def error_messages
      element(:errors) do |b|
        errs = []
        b.left_errmsg_tabs.each do |div|
          if div.div.div.exist?
            errs << div.div.divs.collect{ |div| div.text }
          elsif div.li.exist?
            errs << div.lis.collect{ |li| li.text }
          end
        end
        b.left_errmsg.each do |div|
          if div.div.div.exist?
            errs << div.div.divs.collect{ |div| div.text }
          elsif div.li.exist?
            errs << div.lis.collect{ |li| li.text }
          end
        end
        errs.flatten
      end
      element(:left_errmsg_tabs) { |b| b.frm.divs(class: 'left-errmsg-tab') }
      element(:left_errmsg) { |b| b.frm.divs(class: 'left-errmsg') }
      element(:error_messages_div) { |b| b.frm.div(class: 'error') }
    end

    def validation_elements
      element(:validation_button) { |b| b.frm.button(name: 'methodToCall.activate') }
      action(:show_data_validation) { |b| b.frm.button(id: 'tab-DataValidation-imageToggle').click; b.validation_button.wait_until_present }
      action(:turn_on_validation) { |b| b.validation_button.click; b.special_review_button.wait_until_present }
      element(:validation_errors_and_warnings) { |b| errs = []; b.validation_err_war_fields.each { |field| errs << field.html[/(?<=>).*(?=<)/] }; errs }
      element(:validation_err_war_fields) { |b| b.frm.tds(width: '94%') }
    end

    def links(*links_text)
      links_text.each { |link| elementate(:link, link) }
    end

    def buttons(*buttons_text)
     buttons_text.each { |button| elementate(:button, button) }
    end

    private

    # A helper method that converts the passed string into snake case. See the StringFactory
    # module for more info.
    #
    def damballa(text)
      StringFactory::damballa(text)
    end

    def elementate(type, text)
      identifiers={:link=>:text, :button=>:value}
      el_name=damballa("#{text}_#{type}")
      act_name=damballa(text)
      element(el_name) { |b| b.frm.send(type, identifiers[type]=>text) }
      action(act_name) { |b| b.frm.send(type, identifiers[type]=>text).click }
    end

  end # self

end # BasePage