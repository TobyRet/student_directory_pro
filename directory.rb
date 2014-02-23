# Add an 's' if number of sudents is greater than 1
def print_an_s(list)
	's' if list.length != 1
end

def input_students
	students = []

	# Retreive user input
	puts "Welcome to the Makers Academy Student Directory"
	puts "-----------------------------------------------"
	puts "Please enter the name of the student."
	name = gets.chomp
	puts "Please enter the cohort for #{name}"
	cohort = gets.chomp

	# Set default values if user input is nil
	name = "Name unknown." if name.empty?
	cohort = "Cohort unknown." if name.empty?

	# Loop adds student information to students array
	while !name.empty? && !cohort.empty? do 
		students << {:name => name, :cohort => cohort}
		puts "You have added #{name} to the #{cohort} cohort."
		puts "Now we have #{students.length} student" + "#{print_an_s(students)}"

		# add more students
		puts "----------------------------------------------"
		puts "Would you like to add another student? Type 'yes' or 'no'."
		response = gets.chomp
		puts "----------------------------------------------"
		if response == 'yes'.downcase
			puts "Please enter the name of the student."
			name = gets.chomp
			puts "Please enter the cohort for #{name}"
			cohort = gets.chomp
		else response == 'no'.downcase
			break
		end
	end
	students
end

def print_header
	puts "The students at Makers Academy:"
end

#def print(students)	
#	students.each_with_index do |student|
#		puts "#{students.index(student) + 1}. #{student[:name]} (#{student[:cohort]} cohort)" 
#	end
#end

# list students by cohort
def print_cohort(students)
	cl = students.map {|student| student[:cohort]}

	cl.uniq.each do |cohort|
		puts "\n" + cohort.upcase
		students.each do |student|
			puts "* #{student[:name]}" if student[:cohort] == cohort	
		end
	end
end

#def print_footer(names)
#	puts "In total, we have #{names.length} great student."
#end

students = input_students
print_header
#print(students)
print_cohort(students)
#print_footer(students)