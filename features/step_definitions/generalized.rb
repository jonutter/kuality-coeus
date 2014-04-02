And /saves the document$/ do
  $current_page.save
end

And /reloads the document$/ do
  $current_page.reload
  on(Confirmation).yes
end