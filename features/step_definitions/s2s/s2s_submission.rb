Then /^the S2S tab's submission details will say the Proposal is submitted$/ do








sleep 60








  # Note that there's no navigation here currently because
  # this step def comes after the submission step, which
  # should automatically switch the user to the S2S page.
  on S2S do |page|
    page.expand_all
    page.submission_details_table.should be_present
    page.submission_status.should=='Submitted to S2S'
  end
end

Then /^within a couple minutes the submission status will be updated$/ do
  on S2S do |page|
    x = 0
    while page.s2s_submission_status=='Submitted to S2S'
      sleep 5
      page.refresh_submission_details
      x += 1
      break if x == 24
    end
    # We don't care what it is. Only that it's updated...
    page.s2s_submission_status.should_not == 'Submitted to S2S'
  end
end

When(/^I attach the PHS Fellowship Form to the Proposal$/) do
  on S2S do |page|
    %w{PHS_Fellowship_Supplemental_1_2-V1.2
     }.each { |form| page.include_form(form).set }
  end
end

When(/^I attach the PHS Training and Fellowship Forms to the Proposal$/) do
  on S2S do |page|
    %w{PHS_Fellowship_Supplemental_1_2-V1.2
     }.each { |form| page.include_form(form).set }
  end
end

Then /^the PHS Training and Fellowship Questionnaires should appear in the Proposal$/ do
  on(S2S).questions
  on Questions do |page|
    ['PHS398 Training Budget V1-0',
     'PHS Fellowship Form V1-2'].each { |title| page.form_tab(title).should be_present }
  end
end

When /^I? ?complete its questionnaire$/ do
  @proposal.complete_phs_fellowship_questionnaire
end

Then /^the questionnaire's title should indicate that the questionnaire has been completed$/ do
  on(S2S).questions
  on Questions do |page|
    ['PHS Fellowship Form V1-2'].each { |form_tab| page.form_status(form_tab).should=='Complete'}
  end
end

When /^I? ?add and mark complete all the required attachments$/ do
  attachments = {
      'RR-TEST-NIH-FORMS2' =>
          %w{Equipment Bibliography BudgetJustification ProjectSummary Narrative Facilities
          PHS_ResearchPlan_SpecificAims PHS_ResearchPlan_ResearchStrategy PHS_Cover_Letter},
      'RR-FORMFAMILY-009-2010' =>
          %w{BudgetJustification ProjectSummary Narrative},
      'CAL-TEST-DOD2' =>
          %w{BudgetJustification ProjectSummary Narrative},
      'CAL-FDP-JAD' =>
          %w{BudgetJustification},
      'CSS-120809-SF424RR-V12' =>
          %w{BudgetJustification ProjectSummary Narrative Budget_Justification_10YR
          Budget_Justification_10YR_Fed_NonFed},
      'RR-FORMFAMILY-004-2010' =>
          %w{}
  }
  attachments[@proposal.opportunity_id].shuffle.each { |type| @proposal.add_proposal_attachment type: type, file_name: 'test.pdf', status: 'Complete' }
  @proposal.key_personnel.each { |person| @proposal.add_personnel_attachment person: person.full_name, type: 'Biosketch', file_name: 'test.pdf' }
end

When /adds? a Co-Investigator$/ do
  @proposal.add_key_person role: 'Co-Investigator'
  on(KeyPersonnel).save
end