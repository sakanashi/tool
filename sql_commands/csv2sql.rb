# frozen_string_literal: true

require 'csv'

if ARGV[0].nil?
  print "Convert csv file to sql. \nusage: ruby csv2sql.rb {csv_file_path}\n"
  exit 1
end

table = CSV.table(ARGV[0])

output_sql = []
iterate_num = table.size
s = 0

table.each do |row|
  str = 'SELECT '
  i = 0
  table.headers.each do |column_key|
    str += "\'#{row[i]}\' AS #{column_key}, "
    i += 1
  end
  output_sql << str.chomp(", ")
  output_sql << 'UNION ALL' if s < iterate_num - 1
  s += 1
end

puts output_sql
