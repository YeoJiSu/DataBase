-- 동적 SQL : prepare 문으로 저장시켜 놓은 후, execute로 실행하는 것.
DELIMITER $$
USE `HW3` $$
CREATE DEFINER = `root`@`localhost` PROCEDURE `simplePrepare`()
BEGIN
	declare stmt varchar(45); 
    set @stmt = 'select * from emp';-- @를 사용해야함.
    prepare st from @stmt;
    execute st;
    deallocate prepare st;
END $$

-- simplePrepare 실행
call simplePrepare();

-- dynamicSQL 생성
DELIMITER $$
USE `HW3` $$
CREATE DEFINER = `root`@`localhost` PROCEDURE `dynamicSQL` (
	in tbl varchar(45))
BEGIN
	declare stmt varchar(45);
    set @stmt = concat('select * from ', tbl);
    select @stmt as 'statement';
    prepare st from @stmt;
    execute st;
    deallocate prepare st;
END $$

-- dynamicSQL 실행
call dynamicSQL('spj');

-- dynamicSQL2 생성
DELIMITER $$
USE `HW3` $$
CREATE DEFINER = `root`@`localhost` PROCEDURE `dynamicSQL2` (
	in tbl varchar(45), in val int)
BEGIN
	declare stmt varchar(45);
    declare num int;
    set @num = val;
    set @stmt = concat('select * from ', tbl, ' where qty < ?');
    select @stmt as 'statement';
    prepare st from @stmt;
    execute st using @num; -- using을 사용하여 where 절에 조건 비교 값을 전달한다.
    deallocate prepare st;
END $$

-- dynamicSQL2 실행
call dynamicSQL2('spj', 200);