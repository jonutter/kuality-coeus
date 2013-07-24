Then /^Submission details will be immediately available on the S2S tab$/ do
   on S2S do |page|
     page.expand_all
     page.submission_details_table.should be_present
     page.submission_status.should=='Submitted to S2S'
   end
end

When /^within a couple of minutes the submission status will be updated$/ do
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