# Install hook code here
puts "Copying files..."

dest_file = File.join(RAILS_ROOT, "public", "images")
src_file = File.join(File.dirname(__FILE__), "assets", "images", "social_icons")
FileUtils.cp_r(src_file, dest_file)

dest_file = File.join(RAILS_ROOT, "public", "stylesheets")
src_file = File.join(File.dirname(__FILE__), "assets", "stylesheets", "social_icons.css")
FileUtils.cp_r(src_file, dest_file)

puts "Files copied."
