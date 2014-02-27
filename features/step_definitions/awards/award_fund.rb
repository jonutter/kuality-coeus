Given /^(\d+) Approved Institutional Proposals? exists?$/ do |count|
  @ips = []
  count.to_i.times {
    steps %q{
      * Users exist with the following roles: OSPApprover, Proposal Creator
      * a User exists with the roles: OSP Administrator, Proposal Submission, Institutional Proposal Maintainer in the 000001 unit
      * the Proposal Creator submits a new Proposal into routing
      * the OSPApprover approves the Proposal without future approval requests
      * the principal investigator approves the Proposal
      * the Proposal Submission submits the Proposal to its sponsor
    }
    @ips << @institutional_proposal
  }
end

Given /^(\d+) Approved Institutional Proposals? with cost share, unrecovered F&A, and special review exists?$/ do |count|
  @ips = []
  count.to_i.times {
    steps %q{
      * Users exist with the following roles: OSPApprover, Proposal Creator
      * a User exists with the roles: OSP Administrator, Proposal Submission in the 000001 unit
      * the Proposal Creator creates a Proposal
      * the Proposal Creator user creates a Budget Version with cost sharing for the Proposal
      * adds unrecovered F&A to the first period of the Budget Version
      * finalizes the Budget Version
      * marks the Budget Version complete
      * adds a special review item to the Proposal
      * adds a principal investigator to the Proposal
      * sets valid credit splits for the Proposal
      * completes the required custom fields on the Proposal
      * the Proposal Creator submits the Proposal into routing
      * the OSPApprover approves the Proposal without future approval requests
      * the principal investigator approves the Proposal
      * the OSP Administrator submits the Proposal to its sponsor
    }
    @ips << @institutional_proposal
  }
end

Given /^the (.*) starts an Award with the( first)? Funding Proposal$/ do |role, x|
  steps "Given I log in with the #{role} user"
  visit(CentralAdmin).create_award
  on Award do |page|
    page.expand_all
    page.institutional_proposal_number.set @ips[0].proposal_number
    page.add_proposal
  end
end

# Note the keyword "create", here:
When /^the (.*) creates an Award with the( first)? Funding Proposal$/ do |role, x|
  steps "Given I log in with the #{role} user"
  @award = create AwardObject, funding_proposals: [{ip_number: @ips[0].proposal_number, merge_type: '::random::'}]
end

Then /^the Title, Activity Type, NSF Science Code, and Sponsor match the second Institutional Proposal$/ do
  on Award do |page|
    page.activity_type.selected_options[0].text.should==@ips[1].activity_type
    page.nsf_science_code.selected_options[0].text.should==@ips[1].nsf_science_code
    page.sponsor_id.value.should==@ips[1].sponsor_id
    page.award_title.value.should==@ips[1].project_title
  end
end

Then /^all of the Award.s details remain the same$/ do

  # Need to inspect the Award's nsf_science_code and
  # account_type variables so the compare will
  # work right if it's nil
  nsf_science_code = @award.nsf_science_code || 'select'
  account_type = @award.account_type || 'select'

  on Award do |page|
    page.activity_type.selected_options[0].text.should==@award.activity_type
    page.nsf_science_code.selected_options[0].text.should==nsf_science_code
    page.sponsor_id.value.should==@award.sponsor_id
    page.award_title.value.should==@award.award_title
    page.account_id.value.should==@award.account_id
    page.account_type.selected_options[0].text.should==account_type
    page.prime_sponsor.value.should==@award.prime_sponsor
    page.cfda_number.value.should==@award.cfda_number
  end
end

Then /^the Title, Activity Type, NSF Science Code, and Sponsor still match the( first)? Proposal$/ do |x|
  on Award do |page|
    page.activity_type.selected_options[0].text.should==@ips[0].activity_type
    page.nsf_science_code.selected_options[0].text.should==@ips[0].nsf_science_code
    page.sponsor_id.value.should==@ips[0].sponsor_id
    page.award_title.value.should==@ips[0].project_title
  end
end

Then /^the Title, Activity Type, and NSF Science Code match the second Funding Proposal$/ do
  on Award do |page|
    page.activity_type.selected_options[0].text.should==@ips[1].activity_type
    page.nsf_science_code.selected_options[0].text.should==@ips[1].nsf_science_code
    page.award_title.value.should==@ips[1].project_title
  end
end

And /^the Sponsor ID is from the first Funding Proposal$/ do
  on(Award).sponsor_id.value.should==@ips[0].sponsor_id
end

# This is a specialty step that occurs prior to the saving of the Award,
# so it cannot use the @award data object methods. The Award doesn't exist, yet.
When /adds the second Funding Proposal to the unsaved Award, merge type '(.*)'$/ do |merge_type|
  on Award do |page|
    page.institutional_proposal_number.set @ips[1].proposal_number
    page.proposal_merge_type.select merge_type
    page.add_proposal
  end
end

When /^the Funding Proposal is added to the Award$/ do
  @award.add_funding_proposal @institutional_proposal.proposal_number, '::random::'
end

When /^the Funding Proposal is added to the Award as its initial funding$/ do
  @award.add_funding_proposal @institutional_proposal.proposal_number, 'Initial Funding'
end

When /^the (.*) Funding Proposal is added to the Award with no change$/ do |count|
  index = { 'second' => 1 }
  ip = @ips.nil? ? @institutional_proposal : @ips[index[count]]
  @award.add_funding_proposal ip.proposal_number, 'No Change'
end

When /^the (.*) Funding Proposal is merged to the Award$/ do |count|
  index = { 'second' => 1 }
  ip = @ips.nil? ? @institutional_proposal : @ips[index[count]]
  @award.add_funding_proposal ip.proposal_number, 'Merge'
end

When /^the (.*) Funding Proposal is added to the Award, as a replacement$/ do |count|
  index = { 'second' => 1 }
  ip = @ips.nil? ? @institutional_proposal : @ips[index[count]]
  @award.add_funding_proposal ip.proposal_number, 'Replace'
end

When /^the(.*) Funding Proposal is removed from the Award$/ do |count|
  # Note the space prefix in the key string.
  # IT IS ABSOLUTELY NECESSARY!
  index = { '' => 0, ' first' => 0, ' second' => 1 }
  on Award do |page|
    page.delete_funding_proposal(@ips[index[count]].key_personnel.principal_investigator.full_name)
  end
end

Then /^the Award Modifier cannot remove the Proposal from the Award$/ do
  on Award do |page|
    page.delete_funding_proposal_button(@institutional_proposal.key_personnel.principal_investigator.full_name).should_not exist
  end
end

Then /^the status of the Funding Proposal should change to (.*)$/  do |status|
  visit(Researcher).search_institutional_proposals
  on InstitutionalProposalLookup do |look|
    look.institutional_proposal_number.set @institutional_proposal.proposal_number
    look.search
  end
  on(InstitutionalProposalLookup).ip_status(@institutional_proposal.proposal_number)==status
end

# Don't parameterize this unless and until it's necessary...
Given /^the Award Modifier adds a new Institutional Proposal to a new Award$/ do
  steps %q{
    * Users exist with the following roles: Proposal Creator, OSPApprover
    * a User exists with the roles: OSP Administrator, Proposal Submission, Institutional Proposal Maintainer in the 000001 unit
    * the Proposal Creator submits a new Proposal into routing
    * the OSPApprover approves the Proposal without future approval requests
    * the principal investigator approves the Proposal
    * the OSP Administrator submits the Proposal to its sponsor
    * I log in with the Award Modifier user
    * the Award Modifier user links the Funding Proposal to a new Award
        }
end

Then /^the Award inherits the Cost Sharing data from the Funding Proposal$/ do
  @award.view :commitments
  # TODO: Have to fix this because it's brittle that we're only pulling from the first budget period.
  cs_list = @budget_version.budget_periods[0].cost_sharing_distribution_list
  on Commitments do |page|
    page.expand_all
    page.cost_sharing_comments.value.should=="Added Cost Shares from Proposal Number #{@institutional_proposal.proposal_number}"
    cs_list.each { |cost_share|
      page.cost_sharing_commitment_amount(cost_share.index).value.groom.should==cost_share.amount.to_f
      page.cost_sharing_source(cost_share.index).value.should==cost_share.source_account
    }
  end
end