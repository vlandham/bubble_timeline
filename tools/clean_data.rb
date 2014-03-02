#!/usr/bin/env ruby

require 'csv'

# input_filename = ARGV[0]
input_filename = "data/events.csv"

puts input_filename

output_filename = File.join(File.dirname(input_filename), File.basename(input_filename, File.extname(input_filename)) + ".clean.csv")

LOCS = {"iBeacon Far Field" => "Party in the Back",
             "Color Palette" => "Back Right",
             "Seek and Find" => "Left Side",
             "iBeacon" => "Back Left",
             "Front Door" => "Front Door",
             "Shop My Store" => "Near the Front",
             "Smart Shelf" => "Another Spot",
             "Self Service Wall" => "Mid Right Spot",
             "Dressing Room" => "Near the Party",
             "Digital Mannequin" => "Front Left"
}

data = []
header = ["location", "timestamp"]
CSV.foreach(input_filename, :headers => true) do |csv|
  if csv['rfid_tag_id'][0..3] == "ABBA"
    # if !header
    #   header = csv.headers
    # end

    out = [LOCS[csv['location']], csv['timestamp']]
    data << out
  end
end

File.open(output_filename,'w') do |file|
  file.puts header.join(",")
end

CSV.open(output_filename, "wb") do |csv|
  csv << header
  data.each do |d|
    csv << d
  end
end

