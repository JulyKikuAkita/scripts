#!/usr/bin/ruby
require 'yaml' # Built in, no gem required

$fileLocation = ARGV[0]
$type = ARGV[1]
$path = ARGV[2]
$value = ARGV[3]

$propers = ""

if $type == 'yml'
  $keyPath = $path.split("/")
  $editSection = $keyPath.pop

  puts "================================"
  puts "Loading file: " + $fileLocation
  puts "================================"
  puts "The keyPath is:" + $keyPath.join("/")
  puts "================================"
  puts "The section to edit is: " + $editSection
  puts "================================"
  puts "The value to edit is: " + $value
  puts "================================"

  yaml = YAML::load_file($fileLocation) #Load

  $ORIG = yaml
  $J = yaml
  
  $keyPath.each do |section|  #loops into sub keyPath
    $J = yaml[section]
  end
  
  #puts $J # debug-print out all fields
  
  $J[$editSection] = $value

  File.open($fileLocation, 'w') {|f| YAML.dump($ORIG,f,indentation: 2)} #Store
else
  File.open($fileLocation, 'r') do |f1|
    while line = f1.gets
        if line.include? "#{$path}="
          line = "#{$path}=#{$value}\n"
        end
        $propers << line
    end
  end

  File.open($fileLocation, 'w') do |f2|
    f2.puts $propers
  end
end
