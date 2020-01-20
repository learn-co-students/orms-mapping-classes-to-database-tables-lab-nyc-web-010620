class Student
    attr_accessor :name, :grade
  
  def initialize(name, grade, id=nil)
    @name = name 
    @grade = grade
    @id = id
  end

  def id
    id = DB[:conn].execute("
      SELECT id FROM students WHERE students.name = '#{self.name}';  
    ").flatten

    @id = id[0]
  end

  def self.create_table
    DB[:conn].execute("
      CREATE TABLE students (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        grade INTEGER
      );
    ")
  end

   def self.drop_table
    DB[:conn].execute("
      DROP TABLE students;
    ")
  end

  def save 
    DB[:conn].execute(" 
      INSERT INTO students(name, grade)
      VALUES ('#{self.name}', '#{self.grade}');
    ")
  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end
end
