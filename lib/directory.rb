require 'CSV'

@students = []

def interactive_menu
	loop do 
		print_menu
		process(STDIN.gets.chomp)
	end
end

def print_menu
	puts "Welcome to the Makers Academy Student Directory"
	puts "-----------------------------------------------"
	puts "1. Input students"
	puts "2. Show the students"
	puts "3. Save the list to a file"
	puts "4. Load the list from a file"
	puts "9. Exit"
end

def process(selection)
	case selection
	when "1"; input_students;
	when "2"; show_students;
	when "3"; get_file_save; 
	when "4"; get_file_load;
	when "9"; exit;
	else; puts "I don't understand that. Please try again.";
	end
end

def show_students
	print_header
	print_students_list
	print_footer
end

def input_students
	puts "Please enter the name of the student."; name = STDIN.gets.chomp;
	puts "Please enter the cohort for #{name}"; cohort = STDIN.gets.chomp;
	process_students(name, cohort)
end

def process_students (name = "Unknown", cohort = "Unknown")
	shovel_students(name, cohort)
	puts "You have added #{name} to the #{cohort} cohort."
	puts "Now we have #{@students.length} student" + "#{print_an_s}\n\n"
	@students
end

def get_file_save
	puts "Enter the name of the file you wish to save to or press return to save to students.csv"
	save_students(STDIN.gets.chomp)
end

def get_file_load
	puts "Enter the name of the file you wish to import or press return to import from students.csv"
	load_students(STDIN.gets.chomp)
end

def save_students(file = "students.csv")
	CSV.open(file, "w") do |csv|
		@students.each do |student|
			csv << [student[:name], student[:cohort]]
		end
	end
	puts "Students saved!"
end

def load_students(filename = "students.csv")
	CSV.open(file ,"r") do |csv|
		csv.readlines.each do |student|
			@students << {:name => student[0], :cohort => student[1]}
		end
	end
end

def shovel_students(name, cohort)
	@students << {:name => name, :cohort => cohort.to_sym}
end

def try_load_students
	filename = ARGV.first
	return if filename.nil?
	if File.exists?(filename)
		load_students(filename)
		puts "Loaded #{@students.length} from #{filename}"
	else
		puts "Sorry, #{filename} does not exist"
		exit
	end
end

def print_an_s
	's' if @students.length != 1
end

def print_header
	puts "The students at Makers Academy:"
	puts "-------------------------------"
end

def print_students_list
	@students.each_with_index do |student|
		puts "#{@students.index(student) + 1}. #{student[:name]} (#{student[:cohort]} cohort)" 
	end
end

#def print_cohort(students)
#	cl = students.map {|student| student[:cohort]}
#	cl.uniq.each do |cohort|
#		puts "\n" + cohort.upcase
#		students.each do |student|
#			puts "* #{student[:name]}" if student[:cohort] == cohort	
#		end
#	end
#end

def print_footer
	puts "In total, we have #{@students.length} great student" + "#{print_an_s}.\n\n"
end

try_load_students
interactive_menu
