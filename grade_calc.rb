require 'csv'
require 'pry'

# GradeReader - an object that is responsible for reading in grade data from a CSV

class GradeReader

  def initialize
    @file = IO.read('grades.csv')
    @file = CSV.parse("#{@file}")
    students = []
    CSV.foreach('grades.csv') do |row|
      # ["jonny_smith", "100", "50", "40"]
      name = row.shift
      student = { name: name, grades: row }
      students << student
    end
    students.each_index do |student|
      puts "#{students[student][:name]}'s grades: #{students[student][:grades].map! { |x| x.to_i }}"
    end
  end

  def file
    @file
  end
end

test = GradeReader.new.file
