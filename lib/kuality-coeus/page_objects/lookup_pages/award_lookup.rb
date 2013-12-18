class AwardLookup < Lookups

  object_class_name "#{$base_url}portal.do?channelTitle=Award&channelUrl=#{$base_url[/.+com/]}:/kc-dev/kr/lookup.do?methodToCall=start&businessObjectClassName=org.kuali.kra.award.home.Award"

  element(:award_id) { |b| b.frm.text_field(name: 'awardNumber') }

end