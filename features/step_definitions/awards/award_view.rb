Then /^The Award PI's Lead Unit is (.*)$/ do |unit|
  @award.key_personnel.principal_investigator.lead_unit.should==unit
end

Then /^the Award's Lead Unit is changed to (.*)$/ do |unit|
  @award.view 'Award'
  on(Award).lead_unit_ro.should=~/^#{unit}/
end

Then /^a warning appears saying tracking details won't be added until there's a PI$/ do
  on(PaymentReportsTerms).errors.should include 'Report tracking details won\'t be added until a principal investigator is set.'
end

Then /^the new Award should not have any subawards or T&M document$/ do
  on Award do |test|
    # If there are no Subawards, the table should only have 3 rows...
    test.approved_subaward_table.rows.size.should==3
    test.time_and_money
    # If there is no T&M, then an error should be thrown...
    test.errors.should include 'Project Start Date is required when creating a Time And Money Document.'
  end
end

Then /^the new Award's transaction type is 'New'$/ do
  on(Award).transaction_type.selected?('New').should be_true
end

Then /^the child Award's project end date should be the same as the parent, and read-only$/ do
  on(Award).project_end_date_ro.should==@award.project_end_date
end

Then /^the anticipated and obligated amounts are read-only and (.*)$/ do |amount|
  on Award do |page|
    page.anticipated_amount_ro.should==amount
    page.obligated_amount_ro.should==amount
  end
end

Then /^the anticipated and obligated amounts are zero$/ do
  on Award do |page|
    page.anticipated_amount.value.should=='0.00'
    page.obligated_amount.value.should=='0.00'
  end
end

And /^the Award's PI should match the PI of the (.*) Funding Proposal$/ do |number|
  index = { 'first'=> 0, 'second' => 1 }
  person = @ips[index[number]].project_personnel.principal_investigator.full_name
  @award.view :contacts
  on AwardContacts do |page|
    page.expand_all
    page.key_personnel.should include person
    page.project_role(person).selected_options[0].text.should=='Principal Investigator'
  end
end

And /^the first Funding Proposal's PI is not listed in the Award's Contacts$/ do
  on(AwardContacts).key_personnel.should_not include @ips[0].project_personnel.principal_investigator.full_name
end

And /^the second Funding Proposal's PI should be a (.*) on the Award$/ do |role|
  person = @ips[1].project_personnel.principal_investigator.full_name
  on AwardContacts do |page|
    page.key_personnel.should include person
    page.project_role(person).selected_options[0].text.should==role
  end
end

And /^the second Funding Proposal's PI should not be listed on the Award$/ do
  on(AwardContacts).key_personnel.should_not include @ips[1].project_personnel.principal_investigator.full_name
end

And /^the Award's cost share data are from the (.*) Funding Proposal$/ do |cardinal|
  index = { 'first' => 0, 'second' => 1 }
  n_i = index[cardinal]==0 ? 1 : 0
  @award.view :commitments
  cs_list = @ips[index[cardinal]].cost_sharing
  not_cs = @ips[n_i].cost_sharing
  on Commitments do |page|
    page.expand_all
    cs_list.each { |cost_share|
      page.cost_sharing_commitment_amount(cost_share.index).value.groom.should==cost_share.amount.to_f
      page.cost_sharing_source(cost_share.index).value.should==cost_share.source_account
    }
    not_cs.each { |not_cost_share|
      page.sources.should_not include not_cost_share.source_account
    }
  end
end

And /^the Award's cost share data are from both Proposals$/ do
  @award.view :commitments
  cs_list = []
  index = 0
  # TODO: This can be cleaned up...
  @ips.collect{ |ip| ip.cost_sharing }.flatten.each do |c_s|
    c_s.index=index
    cs_list << c_s
    index += 1
  end
  on Commitments do |page|
    page.expand_all
    cs_list.each { |cost_share|
      page.cost_sharing_commitment_amount(cost_share.index).value.groom.should==cost_share.amount.to_f
      page.cost_sharing_source(cost_share.index).value.should==cost_share.source_account
    }
  end
end

And /^the Award's special review items are from both Proposals$/ do
  @award.view :special_review
  on AwardsSpecialReview do |page|
    @ips.collect{ |ip| ip.special_review }.flatten.each_with_index do |s_r, index|
      page.type_code(index).selected_options[0].text.should==s_r.type
      page.approval_status(index).selected_options[0].text.should==s_r.approval_status
    end
  end
end

And /^the Award's special review items are from the first Proposal$/ do
  @award.view :special_review
  on AwardsSpecialReview do |page|
    @ips[0].special_review.each_with_index do |s_r, index|
      page.type_code(index).selected_options[0].text.should==s_r.type
      page.approval_status(index).selected_options[0].text.should==s_r.approval_status
    end
    @ips[1].special_review.each do |s_r|
      page.types.should_not include s_r.type
    end
  end
end

Then /^all Award fields remain editable$/ do
  on Award do |page|
    page.expand_all
    page.transaction_type.should be_present
    page.award_status.should be_present
    page.activity_type.should be_present
    page.award_type.should be_present
    page.award_title.should be_present
    page.sponsor_id.should be_present
    page.project_end_date.should be_present
  end
end

And /^the Award\'s F&A data are from both Proposals$/ do
  @award.view :commitments
  ufna = IPUnrecoveredFACollection.new(@browser)
  @ips.each do |ip|
    ip.unrecovered_fa.each { |u| ufna << u }
  end
  ufna.reindex
  on Commitments do |page|
    page.expand_all
    ufna.each do |unrecfna|
      i = unrecfna.index
      page.fna_rate(i).value.should==unrecfna.applicable_rate
      page.fna_type(i).selected_options[0].text.should==unrecfna.rate_type
      page.fna_fiscal_year(i).value.should==unrecfna.fiscal_year
      page.fna_campus(i).selected_options[0].text.should==Transforms::ON_OFF[unrecfna.on_campus_contract]
      page.fna_source(i).value.should==unrecfna.source_account
      page.fna_amount(i).value.groom.to_s.should==unrecfna.amount
    end
    page.unrecovered_fna_total.groom.should==ufna.total
  end
end

And /^the Award\'s F&A data are from the first Proposal$/ do
  @award.view :commitments
  on Commitments do |page|
    page.expand_all
    @ips[0].unrecovered_fa.each do |unrecfna|
      i = unrecfna.index
      page.fna_rate(i).value.should==unrecfna.applicable_rate
      page.fna_type(i).selected_options[0].text.should==unrecfna.rate_type
      page.fna_fiscal_year(i).value.should==unrecfna.fiscal_year
      page.fna_campus(i).selected_options[0].text.should==Transforms::ON_OFF[unrecfna.on_campus_contract]
      page.fna_source(i).value.should==unrecfna.source_account
      page.fna_amount(i).value.groom.to_s.should==unrecfna.amount
    end
    @ips[1].unrecovered_fa.each do |fna|
      page.fna_sources.should_not include fna.source_account
    end
    page.unrecovered_fna_total.groom.should==@ips[0].unrecovered_fa.total
  end
end

And /^the Award Modifier can see that the Funding Proposal has been removed from the Award$/ do
  steps '* I log in with the Award Modifier user'
  @award.view :award
  on Award do |page|
    page.expand_all
    #TODO: Improve what's being validated, here...
    page.current_funding_proposals_table.rows.size.should==4
  end
end

And(/^the Award's version number is '(\d+)'$/) do |version|
  @award.view :award
  on Award do |page|
    page.expand_all
    page.version.should==version
  end
end