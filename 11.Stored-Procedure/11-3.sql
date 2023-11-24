-- exception_handle procedure 작성
DELIMITER $$
USE `HW3` $$
CREATE PROCEDURE `exception_handle` (
	in tbl varchar(45))
BEGIN
	declare continue handler for 1146
		select 'No talbe of ', tbl as 'error message';
        select * from tbl;
END $$

-- exception_handle procedure 실행
call exception_handle('dept'); -- 테이블 이름이 전달되어도, select 문에 parameter로 사용될 수 없기 떄문에 에러코드가 발생한다.

-- newData 예외처리 procedure 생성
DELIMITER $$
USE `HW3` $$
CREATE PROCEDURE `newData` ()
BEGIN
	declare continue handler for sqlexception
    begin
		show errors;
        select 'primary key error' as 'error message';
        rollback;
	end;
    insert into s values('S1', 'Hong', 20, 'Busan');
END$$

-- newData procedure 실행
call newData();