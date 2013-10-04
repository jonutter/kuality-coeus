class CentralAdmin < BasePage

  page_url "#{$base_url}portal.do?selectedTab=portalCentralAdminBody"

  green_buttons create_award: 'Award', create_proposal_log: 'Proposal Log'

  # ============
  private
  # ============

  # Use this to define methods to click on the green
  # buttons on the page, all of which can be identified
  # by the title tag. The method takes a hash, where the key
  # will become the method name, and the value is the string
  # that matches the green button's link title tag.
  def green_buttons(links={})
    links.each_pair do |name, title|
      action(name) { |b| b.frm.link(title: title).click; b.loading }
    end
  end

end