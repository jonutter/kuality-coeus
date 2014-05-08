# coding: UTF-8
And /^a cost share item is added to the Award$/ do
  @award.add_cost_share
end

And /^a cost share item is added to the Award with a typo in the project period$/ do
  @award.add_cost_share project_period: random_alphanums(3, 'x')
end

When /^(a cost share item|an F&A rate) is added to the Award with a Percentage having 3 significant digits$/ do |type|
  items = {
      'a cost share item' => [:add_cost_share, :percentage],
      'an F&A rate'       => [:add_fna_rate, :rate]
  }
  @award.send(items[type][0], items[type][1]=>"#{"%02d"%rand(99)}.#{"%03d"%rand(999)}")
end

When /^a cost share item is added to the Award without a required field$/ do
  rfs = {
      type: 'Cost Share Type',
      project_period: 'Project Period',
      commitment_amount: 'Cost Share Commitment Amount'
  }
  field = rfs.keys.sample
  required_field = rfs[field]
  value = field==:type ? 'select' : ''
  @award.add_cost_share field => value
  @required_field_error = "#{required_field} is a required field."
end

And /^duplicate cost share items are added to the Award$/ do
  @award.add_cost_share
  cs = @award.cost_sharing[0]
  @award.add_cost_share percentage: cs.percentage,
                        type: cs.type,
                        project_period: cs.project_period,
                        source: cs.source,
                        commitment_amount: cs.commitment_amount
end

And /adds an F&A rate to the Award$/ do
  @award.add_fna_rate
end

And /adds an F&A rate to the Award but misses a required field$/ do
  rf = ['Rate',
        'Type',
        'Fiscal Year',
        'Start Date'
  ].sample
  field = damballa(rf)
  value = field==:type ? 'select' : ''
  @award.add_fna_rate field => value
  @required_field_error = "#{rf} is a mandatory field"
end

And /adds an F&A rate with an invalid fiscal year$/ do
  @award.add_fna_rate fiscal_year: random_string(3)
end

Given /adds several F&A rates to the Award$/ do
  (rand(4)+3).times{@award.add_fna_rate}
end

And /deletes a couple of the Award's F&A rates$/ do
  on Commitments do |page|
    2.times{page.fna_delete_buttons[rand(page.fna_delete_buttons.size)].click}
  end
end