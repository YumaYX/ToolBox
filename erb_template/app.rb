#!/usr/bin/env ruby
require 'erb'

template_file = 'template.erb'

erb = ERB.new(File.read(template_file))
@value = 'value'

content = erb.result(binding)

File.write('output.txt', content)
