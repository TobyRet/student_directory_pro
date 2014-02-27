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
	puts "3. Save the list to students.csv"
	puts "4. Load the list from students.csv"
	puts "9. Exit"
end

def process(selection)
	case selection
	when "1"; input_students;
	when "2"; show_students;
	when "3"; save_students;
	when "4"; load_students;
	when "9"; exit;
	else; puts "I don't understand that. Please try again.";
	end
end

def show_students
	print_header
	print_students_list
	print_footer
end

# could this be split into two methods? input then output
def input_students
	puts "Please enter the name of the student."
	name = STDIN.gets.chomp
	puts "Please enter the cohort for #{name}"
	cohort = STDIN.gets.chomp	
	name = "Unknown." if name.empty? 
	cohort = "Unknown." if cohort.empty?
	shovel_students(name, cohort)
	puts "You have added #{name} to the #{cohort} cohort."
	puts "Now we have #{@students.length} student" + "#{print_an_s}\n\n"
	@students
end

def save_students
	CSV.open("students.csv", "w") do |csv|
		@students.each do |student|
			csv << [student[:name], student[:cohort]]
		end
	end
	puts "Students saved!"
end

def load_students(filename = "students.csv")
	CSV.open(filename ,"r") do |csv|
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
