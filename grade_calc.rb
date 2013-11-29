require 'csv'

# GradeReader - an object that is responsible for reading in grade data from a CSV
class GradeReader

  def initialize
    @file = IO.read('grades.csv')
    @file = CSV.parse("#{@file}")
  end

  def grade_output
    @students = []
    CSV.foreach('grades.csv') do |row|
      name = row.shift
      @student = { name: name, grades: row }
      @students << @student
    end
    @students.each_index do |student|
      @students[student][:grades].map! {|x| x.to_i}
      student_average = @students[student][:grades].inject{ |sum, x| sum + x}.to_f / @students.size
      puts "#{@students[student][:name]}'s average grade: #{student_average}"
    end
  end
  def file
    @file
  end
end

part2 = GradeReader.new.grade_output
