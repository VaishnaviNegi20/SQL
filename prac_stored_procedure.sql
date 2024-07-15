use parks_and_recreation;
create procedure new_proc1()
	select salary 
    from employee_salary
    where salary > 50000;
call new_proc1();

delimiter $$
create procedure new_proc2()
begin
	select salary 
    from employee_salary
    where salary>50000;
    select salary 
    from employee_salary
    where salary = 50000;
end $$
delimiter ;
call new_proc2()

delimiter $$
create procedure new_proc3(p_employee_id int)
begin
	select employee_id , salary
    from employee_salary
    where employee_id = p_employee_id;
end $$
delimiter ;
call new_proc3(1);


use bpdatabase;

CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender VARCHAR(10),
    Address VARCHAR(255),
    PhoneNumber VARCHAR(20)
);

CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Specialty VARCHAR(50),
    PhoneNumber VARCHAR(20)
);

CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATETIME,
    Reason VARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

INSERT INTO Patients (FirstName, LastName, DateOfBirth, Gender, Address, PhoneNumber)
VALUES ('John', 'Doe', '1980-01-01', 'Male', '123 Main St', '555-1234'),('Johnny', 'Depp', '1982-01-01', 'Male', '1234 Main St', '5535-1234');

INSERT INTO Doctors (FirstName, LastName, Specialty, PhoneNumber)
VALUES ('Jane', 'Smith', 'Cardiology', '555-5678'),('Janny', 'riw', 'ent', '555-52678');

SELECT * FROM patients;
SELECT * FROM doctors;
SELECT PatientID FROM Patients WHERE FirstName = 'John' AND LastName = 'Doe';
SELECT DoctorID FROM Doctors WHERE FirstName = 'Jane' AND LastName = 'Smith';


DELIMITER %%
CREATE PROCEDURE ScheduleAppointment (
    IN p_PatientID INT,
    IN p_DoctorID INT,
    IN p_AppointmentDate DATETIME,
    IN p_Reason VARCHAR(255)
)
BEGIN
    INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Reason)
    VALUES (p_PatientID, p_DoctorID, p_AppointmentDate, p_Reason);
END %%
DELIMITER ;

CALL ScheduleAppointment(1,1, '2024-07-10 12:00:00', 'Medication');

select * from Appointments;

DELIMITER $$
CREATE PROCEDURE ViewAppointments()
BEGIN
    SELECT a.AppointmentID, p.FirstName AS PatientFirstName, p.LastName AS PatientLastName, 
           d.FirstName AS DoctorFirstName, d.LastName AS DoctorLastName, 
           a.AppointmentDate, a.Reason
    FROM Appointments a
    JOIN Patients p ON a.PatientID = p.PatientID
    JOIN Doctors d ON a.DoctorID = d.DoctorID;
END $$
DELIMITER ;

CALL ViewAppointments();

select * from Appointments;

DELIMITER $$
CREATE PROCEDURE ManageAppointments(
    IN operation_type VARCHAR(10),
    IN p_AppointmentID INT,
    IN p_PatientID INT,
    IN p_DoctorID INT,
    IN p_AppointmentDate DATETIME,
    IN p_Reason VARCHAR(255)
)
BEGIN
    IF operation_type = 'view' THEN
        SELECT a.AppointmentID, p.FirstName AS PatientFirstName, p.LastName AS PatientLastName, 
               d.FirstName AS DoctorFirstName, d.LastName AS DoctorLastName, 
               a.AppointmentDate, a.Reason
        FROM Appointments a
        JOIN Patients p ON a.PatientID = p.PatientID
        JOIN Doctors d ON a.DoctorID = d.DoctorID;
    ELSEIF operation_type = 'modify' THEN
        UPDATE Appointments
        SET PatientID = p_PatientID,
            DoctorID = p_DoctorID,
            AppointmentDate = p_AppointmentDate,
            Reason = p_Reason
        WHERE AppointmentID = p_AppointmentID;
    END IF;
END $$
DELIMITER ;

CALL ManageAppointments('view', NULL, NULL, NULL, NULL, NULL);

CALL ManageAppointments('modify', 4, 2, 2, '2024-07-18 10:00:00', 'Follow-up Checkup');

Select * from Appointments;

use files;
select * from movies;
delimiter $$
create procedure movie_count_pro(
  in rating_param int		-- in is used for input
)
begin
  select  count(*)
    from    movies
    where   rating = rating_param;
end $$
delimiter ;

call movie_count_pro(3);

use bpdatabase;
select * from employees;

DELIMITER $$
DROP PROCEDURE if exists ManageEmployee $$
CREATE PROCEDURE ManageEmployee(
    IN empID INT,
    IN empName VARCHAR(100),
    IN empDept VARCHAR(50),
    IN newSalary DECIMAL(10,2),
    OUT statusMessage VARCHAR(255)
)
BEGIN
    DECLARE empExists INT;
-- Error handling
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET statusMessage = 'An error occurred during the procedure';
END;

    -- Check if the employee exists
    SELECT COUNT(*) INTO empExists FROM employees WHERE employee_id = empID;

    IF empExists > 0 THEN
        -- Employee exists, update salary
        UPDATE employees
        SET salary = newSalary
        WHERE employee_id = empID;
        SET statusMessage = CONCAT('Salary updated for employee ID ', empID);
    ELSE
        -- Employee does not exist, insert new employee
        INSERT INTO employees(employee_id, name, department, salary)
        VALUES (empID, empName, empDept, newSalary);
        SET statusMessage = CONCAT('New employee added with ID ', empID);
    END IF;
END $$
DELIMITER ;

CALL ManageEmployee(3, 'Michael Johnson', 'Human Resources', 75000.00, @status); -- @status is a variable we created and it stores the statusMessage
SELECT @status AS StatusMessage;    -- to show the statusMessage, we have to retrieve it
CALL ManageEmployee(4, 'Mike Johnson', 'Human Resources', 78000.00, @statusMessage); -- we can change the variable name for storing purpose only
select @statusMessage;    -- after that retrieve the data