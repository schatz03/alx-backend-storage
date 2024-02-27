export default function createIteratorObject(report) {
  const departments = Object.keys(report.allEmployees);
  let currentDepartmentIndex = 0;
  let currentEmployeeIndex = 0;

  const iterator = {
    next: function () {
      if (currentDepartmentIndex < departments.length) {
        const currentDepartment = departments[currentDepartmentIndex];
        const employees = report.allEmployees[currentDepartment];

        if (currentEmployeeIndex < employees.length) {
          const employee = employees[currentEmployeeIndex];
          currentEmployeeIndex++;
          return { value: employee, done: false };
        } else {
          // Move to the next department
          currentDepartmentIndex++;
          currentEmployeeIndex = 0;
          return this.next(); // Recursive call to handle empty departments
        }
      }

      // No more departments or employees
      return { done: true };
    },
    [Symbol.iterator]: function () {
      return this;
    },
  };
