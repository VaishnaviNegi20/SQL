use files;

delimiter $$
create function movie_genre(  -- don't have to use in/out in functions as we do in procedure, we have returns here
    p_genre varchar(100)    
)
returns int
deterministic reads sql data
begin
    declare movie_var int;

    select  avg(rating)
    into    movie_var
    from    movies
    where   genres = p_genre;

    return(movie_var);
end $$
delimiter ;

select movie_genre('Action');

delimiter $$
create function movie_count(
    p_rating int
)
returns int
deterministic reads sql data
begin
    declare movie_var int;

    select  count(*)
    into    movie_var
    from    movies
    where   rating = p_rating;

    return(movie_var);
end $$
delimiter ;

select movie_count(3.5);



use bpdatabase;

DELIMITER $$
CREATE FUNCTION CalculateAge (p_DateOfBirth DATE) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE age INT;
    SET age = TIMESTAMPDIFF(YEAR, p_DateOfBirth, CURDATE());
    RETURN age;
END $$
DELIMITER ;

SELECT CalculateAge('1985-07-09');
SELECT CalculateAge('1980-07-09');


DELIMITER $$
CREATE FUNCTION GetDoctorFullName (p_DoctorID INT) RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE fullName VARCHAR(100);
    SELECT CONCAT(FirstName, ' ', LastName) INTO fullName
    FROM Doctors
    WHERE DoctorID = p_DoctorID;
    RETURN fullName;
END $$
DELIMITER ;

SELECT GetDoctorFullName(2);


/* Convert your Star Schema Design Data Retrieval Commands(dql) into Stored Functions */
/* Try 2-3 examples using Star Schema Design using CTE, Views & Temporary Table */
/* Create a Stored functions which helps us to calculate Running Total */
