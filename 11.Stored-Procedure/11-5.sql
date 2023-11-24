-- bLevel function 생성
DELIMITER $$
USE `HW3` $$
CREATE DEFINER = `root`@`localhost` FUNCTION `bLevel`(money int)
RETURNS varchar(10) 
DETERMINISTIC
BEGIN
	declare bl varchar(10);
    if money < 20 then set bl = 'silver';
    elseif money < 40 then set bl = 'gold';
    else set bl = 'platinum';
    end if;
RETURN bl;
END $$

-- bLevel function 호출
select * from dept;
select dname, bLevel(budget) from dept;

-- stored function(bLevel)을 이용하여 stored procedure 작성
DELIMITER $$
USE `HW3` $$
CREATE PROCEDURE `getBudgetLevel` (
	in deptName varchar(45), 
    out deptLevel varchar(45))
BEGIN
	declare dmoney int;
    select budget into dmoney from dept where dname = deptName;
    select bLevel(dmoney) into deptLevel;
END $$

-- getBudgetLevel procedure 호출
call getBudgetLevel('Research', @deptLevel);
select @deptLevel;

-- stored procedure를 호출하는 또 다른 procedure 만들기
DELIMITER $$
USE `HW3` $$
CREATE DEFINER = `root`@`localhost` PROCEDURE `findLevel`()
BEGIN
	declare x varchar(45);
    declare outLevel varchar(45);
    set x = 'DB';
    call getBudgetLevel(x, outLevel);
    select outLevel;
END $$

-- findLevel 호출
call findLevel();