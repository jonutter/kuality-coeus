Given /^at least (\d+) Approved Institutional Proposals exist$/ do |count|
  $ips = [] if $ips.nil?
  (count.to_i - $ips.size).times {
    steps %{
      * a User exists with the role: 'Proposal Creator'
      * a User exists with the roles: OSP Administrator, Institutional Proposal Maintainer in the 000001 unit
      * the Proposal Creator initiates a Proposal
      * adds a principal investigator
      * sets valid credit splits for the Proposal
      * creates a Budget Version with cost sharing for the Proposal
      * finalizes the Budget Version
      * marks the Budget Version complete
      * completes the required custom fields on the Proposal
      * submits the Proposal
      * the OSP Administrator approves the Proposal without future approval requests
      * the principal investigator approves the Proposal
      * the OSP Administrator submits the Proposal to its sponsor
    }
    $ips << @institutional_proposal
  }
end

When /^I? ?initiate an Award for the institutional_proposal$/ do
  @award = create AwardObject, funding_proposal: @institutional_proposal.proposal_number
end

Given /^the Award Modifier starts an Award with the first institutional proposal number$/ do
  steps 'Given I log in with the Award Modifier user'
  visit(CentralAdmin).create_award
  on Award do |page|
    page.expand_all
    page.institutional_proposal_number.set $ips[0].proposal_number
    page.add_proposal
  end
end

Then /^the Title, Activity Type, NSF Science Code, and Sponsor match the second Institutional Proposal$/ do
  on Award do |page|
    page.activity_type.selected_options[0].text.should==$ips[1].activity_type
    page.nsf_science_code.selected_options[0].text.should==$ips[1].nsf_science_code
    page.sponsor_id.value.should==$ips[1].sponsor_id
    page.award_title.value.should==$ips[1].project_title
  end
end

Then /^the Title, Activity Type, NSF Science Code, and Sponsor remain the same$/ do
  on Award do |page|
    page.activity_type.selected_options[0].text.should==@award.activity_type
    page.nsf_science_code.selected_options[0].text.should==@award.nsf_science_code
    page.sponsor_id.value.should==@award.sponsor_id
    page.award_title.value.should==@award.award_title
  end
end

Then /^the Title, Activity Type, NSF Science Code, and Sponsor still match the Proposal$/ do
  on Award do |page|
    page.activity_type.selected_options[0].text.should==$ips[0].activity_type
    page.nsf_science_code.selected_options[0].text.should==$ips[0].nsf_science_code
    page.sponsor_id.value.should==$ips[0].sponsor_id
    page.award_title.value.should==$ips[0].project_title
  end
end

When /^the second institutional proposal number is added to the Award$/ do
  on Award do |page|
    page.institutional_proposal_number.set $ips[1].proposal_number
    page.add_proposal
  end
end

When /^the Funding Proposal is removed from the Award$/ do
  on Award do |page|
    page.delete_funding_proposal($ips[0].key_personnel.principal_investigator.full_name)
  end






  sleep 260





end

And /^one of the Funding Proposals is added to the Award$/ do
  @ip = $ips[rand($ips.length)]
  @award.add_funding_proposal @ip.proposal_number, '::random::'
end