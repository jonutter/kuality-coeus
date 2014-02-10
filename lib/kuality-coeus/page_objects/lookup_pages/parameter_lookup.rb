class ParameterLookup < Lookups

  url_info 'Parameter', 'rice.coreservice.impl.parameter.ParameterBo'

  element(:parameter_name) { |b| b.frm.text_field(id: 'name') }

end