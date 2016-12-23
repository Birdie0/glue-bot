require 'yourub'

options = { developer_key: 'AIzaSyDjvtLdM0q8JYUA-H5JSKDtQfwpUWfL5r4',
             application_name: 'yourub',
             application_version: 2.0,
             log_level: 3 }

client = Yourub::Client.new(options)

client.search(query: "aliens") do |v|
  puts v['id']
end