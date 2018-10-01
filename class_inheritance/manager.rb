require_relative 'employee.rb'

class Manager < Employee

  attr_accessor :employees

  def initialize(name, title, salary, boss, employees=[])
    @employees = employees
    super(name, title, salary, boss)
  end

  def add_employee(employee)
    self.employees << employee
  end

  def bonus(multiplier)

    sum = 0
    employees.each do |employee|
      if employee.is_a?(Manager)
        sum += employee.bonus(1) + employee.salary
      else
        sum += employee.salary
      end
    end
    sum * multiplier
  end
end
