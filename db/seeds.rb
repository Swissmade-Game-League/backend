# Create genders ---------------------------------------------------------------
puts "Genders creation..."
gender = Gender.find_or_initialize_by("name"=>"male")
gender.save
puts "  "+gender.name.to_s+" ✅"

gender = Gender.find_or_initialize_by("name"=>"female")
gender.save
puts "  "+gender.name.to_s+" ✅"

gender = Gender.find_or_initialize_by("name"=>"other")
gender.save
puts "  "+gender.name.to_s+" ✅"
# ------------------------------------------------------------------------------
