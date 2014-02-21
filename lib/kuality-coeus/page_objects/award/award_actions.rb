class AwardActions < KCAwards

  route_log
  validation_elements

  # Hierarchy Actions
  action(:expand_tree) { |b| b.frm.link(title: 'Expand the entire tree below').click }
  action(:show_award_details_panel) { |number, b| b.frm.link(class: 'awardHierarchy', text: /#{number}/).click }

  action(:award_div) { |award, b| b.frm.div(id: "details#{award}") }
  action(:copy_descendents) { |award, b| b.award_div(award).checkbox(id: /copyDescendants/) }
  action(:copy_as_new) { |award, b| b.award_div(award).radio(name: /copyAwardRadio/, value: 'a') }
  action(:copy_as_child_of) { |award, b| b.award_div(award).radio(name: /copyAwardRadio/, value: 'd') }
  action(:child_of_target_award) { |award, b| b.award_div(award).select(name: /copyAwardPanelTargetAward/) }
  action(:copy_award) { |award, b| b.award_div(award).button(title: 'Copy').click; b.loading }
  action(:based_on_new) { |award, b| b.award_div(award).radio(value: 'a', name: /createNewChildRadio/) }
  action(:based_on_parent) { |award, b| b.award_div(award).radio(value: 'b', name: /createNewChildRadio/) }
  action(:based_on_award) { |award, b| b.award_div(award).radio(value: 'c', name: /createNewChildRadio/) }
  action(:based_on_target_award) { |award, b| b.award_div(award).select(name: /newChildPanelTargetAward/) }
  action(:create_new_child) { |award, b| b.award_div(award).button(title: 'Create').click; b.loading }

  # This creates an array that contains the ids of the descendants of the specified Award...
  action(:descendants) { |award, b|
    array = []
    b.frm.li(id: "li#{award}").lis.each { |li| array << li.id[/\d+-\d+/] }
    array
  }

end