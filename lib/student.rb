class Student
  attr_accessor :name, :grade
  attr_reader :id

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn] 
  
  def initialize(name,grade,id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def save
    sql = "INSERT INTO students(name,grade) VALUES('#{@name}','#{@grade}')"
    DB[:conn].execute(sql)
    id = DB[:conn].execute("SELECT id FROM students ORDER BY id DESC")
    @id = id[0][0]
  end

  def self.create_table
    sql = "CREATE TABLE students(
          id INTEGER PRIMARY KEY,
          name TEXT,
          grade TEXT
          );"
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE students"
    DB[:conn].execute(sql)
  end

  def self.create(attr_hash)
    new_student = Student.new(attr_hash[:name],attr_hash[:grade])
    new_student.save
    new_student
  end
  
end
