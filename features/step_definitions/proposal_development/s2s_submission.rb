Then /^Submission details will be immediately available on the S2S tab$/ do
   on S2S do |page|
     page.expand_all
     page.submission_details_table.should be_present
     page.submission_status.should=='Submitted to S2S'
   end
end

Then /^within a couple of minutes the submission status will be updated$/ do
  on S2S do |page|
    x = 0
    while page.submission_status=='Submitted to S2S'
      sleep 5
      page.refresh_submission_details
      x += 1
      break if x == 24
    end
    page.submission_status.should_not == 'Submitted to S2S'
  end
end

When(/^I attach the PHS training and fellowship forms to the proposal$/) do
  on S2S do |page|
    %w{PHS_Fellowship_Supplemental_1_2-V1.2
     PHS398_TrainingBudget-V1.0}.each { |form| page.include_form(form).set }
  end
end

Then(/^the PHS training and fellowship questionnaires should be appear in the proposal$/) do
  on(S2S).questions
  on(Questions) do |page|
    page.expand_all
    page.phs_398_training_Budget_questionnaire_title.should be_present
  end
  on(PHSFellowshipQuestions).phs_fellowship_questionnaire_title.should be_present
end