When /I? ?copy the Award to a new parent Award$/ do
  @award_2 = @award.copy
end

When /^I? ?copy the Award as a child of itself$/ do
  @award_2 = @award.copy 'child_of', @award.id
end

When /^I? ?copy the Award and its descend.nts? to a new parent Award$/ do
  # TODO: Come up with a more robust naming scheme, here...
  @new_parent_award = @award.copy 'new', nil, :set
end

When /^I? ?copy the Award and its descend.nts? as a child of itself$/ do
  # TODO: Come up with a more robust naming scheme, here...
  @new_child_award = @award.copy 'child_of', @award.id, :set
end
