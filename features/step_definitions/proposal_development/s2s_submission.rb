Then /^Submission details will be immediately available on the S2S tab$/ do
   on S2S do |page|
     page.expand_all
     page.submission_details_table.should exist
   end
end

When /^within a couple of minutes the submission status will be updated$/ do

end