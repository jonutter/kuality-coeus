class SubawardDocument < BasePage

  document_header_elements
  tab_buttons
  global_buttons
  error_messages

  # Subaward tabs
  buttons 'Subaward', 'Financial', 'Custom Data', 'Subaward Actions', 'Medusa'

end