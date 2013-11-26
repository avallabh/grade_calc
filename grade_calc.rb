require 'csv'

# an object that is responsible for reading in grade data from a CSV
class GradeReader
  def initialize
    @file = IO.read('grades.csv')
    @file = CSV.parse("#{@file}")
    grades = file
    students = file.delete_at(0)
    grades_array = []
    students_array = []

    students.each do |student|
      students_array << student
      index = 0
      for index in (0...5)
        grades[index]
        grades_array << grades[index]
        grades_array[index].map! { |s| s.to_i }
        index += 1
      end
    end
    for index in (0...5)
      puts "#{students_array[index]}'s grades are: #{grades_array[index]}"
    end
  end
  def file
    @file
  end
end

grades = GradeReader.new.file

# an object that encapsulates the concept of a given assignment grade
class AssignmentGrade
  # grades.csv file
  # [0][0] = johnny, [1][x] = grades
  # [0][1] = sally,  [2][x] = grades
  # [0][2] = jimmy,  [3][x] = grades
  # [0][3] = chris,  [4][x] = grades
  # [0][4] = brian,  [5][x] = grades
end

# an object that encapsulates the concept of a student's final grade
class FinalGrade
end

# an object that represents a participant in a class
class Student
end

# an object that encapsulates the concept of the class' aggregate performance
class GradeSummary
end
