@students = []

def interactive_menu
	loop do 
		print_menu
		process(gets.chomp)
	end
end

def print_menu
	puts "Welcome to the Makers Academy Student Directory"
	puts "-----------------------------------------------"
	puts "1. Input students"
	puts "2. Show the students"
	puts "3. Save the list to students.csv"
	puts "4. Load the list from students.csv"
	puts "9. Exit"
end

def process(selection)
	case selection
	when "1"
		input_students
	when "2"
		show_students
	when "3"
		save_students
	when "4"
		load_students
	when "9"
		exit
	else 
		puts "I don't understand that. Please try again."
	end
end

def show_students
	print_header
	print_students_list
	print_footer
end

def input_students
	puts "Please enter the name of the student."
	name = gets.chomp
	puts "Please enter the cohort for #{name}"
	cohort = gets.chomp	
	name = "Unknown." if name.empty? 
	cohort = "Cohort unknown." if cohort.empty?
	@students << {:name => name, :cohort => cohort}
	puts "You have added #{name} to the #{cohort} cohort."
	puts "Now we have #{@students.length} student" + "#{print_an_s}\n\n"
	@students
end

def save_students
	file = File.open("students.csv", "w")
	@students.each do |student|
		student_data = [student[:name], student[:cohort]]
		csv_line = student_data.join(",")
		file.puts csv_line
	end
	file.close
	puts "Students saved!"
end

def load_students
	file = File.open("students.csv" ,"r")
	file.readlines.each do |line|
		name, cohort = line.chomp.split(',')
		@students << {:name => name, :cohort => cohort.to_sym}
	end
	file.close
end

# Add an 's' if number of sudents is greater than 1
def print_an_s
	's' if @students.length != 1
end

def print_header
	puts "The students at Makers Academy:"
end

def print_students_list
	@students.each_with_index do |student|
		puts "#{@students.index(student) + 1}. #{student[:name]} (#{student[:cohort]} cohort)" 
	end
end

def print_cohort(students)
	cl = students.map {|student| student[:cohort]}
	cl.uniq.each do |cohort|
		puts "\n" + cohort.upcase
		students.each do |student|
			puts "* #{student[:name]}" if student[:cohort] == cohort	
		end
	end
end

def print_footer
	puts "In total, we have #{@students.length} great student" + "#{print_an_s}.\n\n"
end

interactive_menu
