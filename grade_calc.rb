require 'csv'
require 'ruby-standard-deviation'

class GradeReader
  def initialize(filename)
    @file = IO.read(filename)
    @file = CSV.parse("#{@file}")
    @students = []
    CSV.foreach('grades.csv') do |row|
      first_name = row.shift
      last_name = row.shift
      @student = { firstname: first_name, lastname: last_name, grades: row }
      @students << @student
    end
  end
  def import_student
    @students.each_index do |student|
      puts "#{@students[student][:firstname]} #{@students[student][:lastname]}'s grades: #{@students[student][:grades].map! { |x| x.to_i }}"
    end
  end
  def file
    @file
  end
end

class Student
  # outputs student name + average
  def grade_output
    @students = []
    @average_grades = []
    CSV.foreach('grades.csv') do |row|
      first_name = row.shift
      last_name = row.shift
      @student = { firstname: first_name, lastname: last_name, grades: row }
      @students << @student
    end
    @students.each_index do |student|
      @students[student][:grades].map! {|x| x.to_i}
      student_average = @students[student][:grades].inject{ |sum, x| sum + x}.to_f / @students.size
      @average_grades << student_average
      puts "#{@students[student][:firstname]} #{@students[student][:lastname]}'s average grade: #{student_average}"
    end
  end
end

class FinalGrade
  # outputs student name + final letter grade
  def grade_output
    @students = []
    @average_grades = []
    @student_names = []
    CSV.foreach('grades.csv') do |row|
      first_name = row.shift
      last_name = row.shift
      @student = { firstname: first_name, lastname: last_name, grades: row }
      @students << @student
      @student_names << @student[:firstname] + " " + @student[:lastname]
    end
    @students.each_index do |student|
      @students[student][:grades].map! {|x| x.to_i}
      student_average = @students[student][:grades].inject{ |sum, x| sum + x}.to_f / @students.size
      @average_grades << student_average
    end
    @student_names = @student_names.sort
    stu_avg = @student_names.zip(@average_grades)

    stu_avg.each do |name, avg|
      if avg >= 90
        puts "#{name}'s final letter grade: A"
        File.open("report_card.txt", "a") do |f|
          f.write("#{name}'s average: #{avg} \n#{name}'s final grade: A\n")
        end
      elsif avg >= 80 && avg < 90
        puts "#{name}'s final letter grade: B"
        File.open("report_card.txt", "a") do |f|
          f.write("#{name}'s average: #{avg} \n#{name}'s final grade: B\n")
        end
      elsif avg >= 70 && avg < 80
        puts "#{name}'s final letter grade: C"
        File.open("report_card.txt", "a") do |f|
          f.write("#{name}'s average: #{avg} \n#{name}'s final grade: C\n")
        end
      elsif avg >= 60 && avg < 70
        puts "#{name}'s final letter grade: D"
        File.open("report_card.txt", "a") do |f|
          f.write("#{name}'s average: #{avg} \n#{name}'s final grade: D\n")
        end
      else
        File.open("report_card.txt", "a") do |f|
          f.write("#{name}'s average: #{avg} \n#{name}'s final grade: F\n")
          puts "#{name}'s final letter grade: F"
        end
      end
    end
  end
end

# calculates average, min, max, stdev of the class
class GradeSummary
  reader = FinalGrade.new.grade_output
  summary = Hash[*reader.flatten]
  average = []

  summary.each do |name, avg|
    average << avg
  end
  puts "Average score: #{average.inject{ |sum, x| sum + x}.to_f / average.length}"
  puts "Minimum score: #{average.min}"
  puts "Maximum score: #{average.max}"
  puts "Standard deviation: #{average.stdev}"
end
