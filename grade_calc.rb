require 'csv'
require 'pry'

# GradeReader - an object that is responsible for reading in grade data from a CSV
class GradeReader

  def initialize
    @file = IO.read('grades.csv')
    @file = CSV.parse("#{@file}")
  end
  # lists students + grades
  def import
    @students = []
    CSV.foreach('grades.csv') do |row|
      name = row.shift
      @student = { name: name, grades: row }
      @students << @student
    end
    @students.each_index do |student|
      puts "#{@students[student][:name]}'s grades: #{@students[student][:grades].map! { |x| x.to_i }}"
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
      name = row.shift
      @student = { name: name, grades: row }
      @students << @student
    end
    @students.each_index do |student|
      @students[student][:grades].map! {|x| x.to_i}
      student_average = @students[student][:grades].inject{ |sum, x| sum + x}.to_f / @students.size
      @average_grades << student_average
      puts "#{@students[student][:name]}'s average grade: #{student_average}"
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
      name = row.shift
      @student = { name: name, grades: row }
      @students << @student
      @student_names << @student[:name]
    end
    @students.each_index do |student|
      @students[student][:grades].map! {|x| x.to_i}
      student_average = @students[student][:grades].inject{ |sum, x| sum + x}.to_f / @students.size
      @average_grades << student_average
    end

    stu_avg = @student_names.zip(@average_grades)
    # outputs student name, average, and letter grade to report_card.txt
    stu_avg.each do |name, avg|
      if avg >= 90
        puts "#{name}'s final letter grade: A"
        File.open("report_card.txt", "a") do |f|
          f.write("#{name}'s average: #{avg} / final grade: A\n")
        end
      elsif avg >= 80 && avg < 90
        puts "#{name}'s final letter grade: B"
        File.open("report_card.txt", "a") do |f|
          f.write("#{name}'s average: #{avg} / final grade: B\n")
        end
      elsif avg >= 70 && avg < 80
        puts "#{name}'s final letter grade: C"
        File.open("report_card.txt", "a") do |f|
          f.write("#{name}'s average: #{avg} / final grade: C\n")
        end
      elsif avg >= 60 && avg < 70
        puts "#{name}'s final letter grade: D"
        File.open("report_card.txt", "a") do |f|
          f.write("#{name}'s average: #{avg} / final grade: D\n")
        end
      else
        File.open("report_card.txt", "a") do |f|
          f.write("#{name}'s average: #{avg} / final grade: F\n")
        end
        puts "#{name}'s final letter grade: F"
      end
    end
  end
end

part4 = FinalGrade.new.grade_output

