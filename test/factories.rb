Factory.sequence(:keyword)  { |n| "keyword_#{n}" }
Factory.sequence(:email)    { |n| "email_#{n}@email.com" }

Factory.define :message do |f|
  f.keyword     { Factory.next(:keyword) }
  f.sms_body    Faker::Lorem.words(5)
  f.email_body  Faker::Lorem.words(5)
end

Factory.define :client do |f|
  f.phone       { rand(9999999999).to_s.rjust(10, '0') }
end

Factory.define :enquiry do |f|
  f.association :message
  f.association :client
end
