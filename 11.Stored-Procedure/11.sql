-- stored procedure, function, cursor, 동적 SQL을 실습하는 문제로
-- s,p,j,spj 등의 테이블로 구성되는 warehouse 프로젝트에 대하여 다음 기능들을 작성한다.

-- 1. 부품의 프로젝트별 공급량(qty)의 합계가 gold, silver, bronze으로 나눈다.  등급 기준 값은 procedure 호출시 에 parameter로 전달한다.
-- 2. 등급 부여는 create function을 사용한다.
-- 3. 등급 비교 조건은 prepare ..., execute ... using ...으로 전달한다.
-- 4. 공급자의 이름을 조건으로 전달하여 해당 공급자의  프로젝트별 부품 갯수를 출력한다. cursor를 사용하여 해당되는 프로젝트의  이름과 도시를 모두 출력한다.

-- 2번 함수 생성
DELIMITER $$
USE `HW3` $$
CREATE DEFINER = `root`@`localhost` FUNCTION `getProjectLevel`(in_qty int, in_std_A int, in_std_B int, in_std_C int) 
RETURNS VARCHAR(10) DETERMINISTIC
BEGIN
    declare level varchar(10);
    if in_qty > in_std_A then
        set level = 'gold';
    elseif in_qty > in_std_B then
        set level = 'silver';
    elseif in_qty > in_std_C then
        set level = 'bronze';
    else
        set level = 'no_level';
    end if;
RETURN level;
END $$

-- 1번, 3번 procedure 생성
DELIMITER $$
USE `HW3` $$
CREATE DEFINER = `root`@`localhost` PROCEDURE `myProcedure` (
    in std_A int, in std_B int, in std_C int
)
BEGIN
	declare stmt varchar(50);
    declare in_std_A int;
    declare in_std_B int;
    declare in_std_C int;
    set @in_std_A = std_A;
    set @in_std_B = std_B;
    set @in_std_C = std_C;
    set @stmt = 'SELECT jno, SUM(qty) AS tot_qty, getProjectLevel(SUM(qty), ?, ?, ?) AS project_level FROM spj GROUP BY jno';
    prepare st from @stmt;
    execute st using @in_std_A, @in_std_B, @in_std_C;
    deallocate prepare st;
END $$

-- 4번 최종 구현
DELIMITER $$
USE `HW3` $$
CREATE DEFINER = `root`@`localhost` PROCEDURE `myCursor2`(
	in std_A int, in std_B int, in std_C int,
	in supplier_name varchar(45)
)
BEGIN
	declare stmt varchar(50);
    declare in_std_A int;
    declare in_std_B int;
    declare in_std_C int;
    declare in_supplier_name varchar(45);
    
    declare jno_val char(4);
    declare pno_count int;
    declare qty_sum int;
    declare project_level_val varchar(10);
    declare jname_val varchar(45);
    declare city_val varchar(45);
    
    declare endRow int default 0;
    declare cur cursor for select j.jno, count(pno), sum(qty) as sum, 
							getProjectLevel(sum(qty), std_A, std_B, std_C) AS project_level, 
                            j.jname, j.city
							from spj, s, j
							where spj.sno = s.sno and spj.jno = j.jno and s.sname = supplier_name
							group by jno;
    declare continue handler for not found set endRow = 1;
    
    set @in_std_A = std_A;
    set @in_std_B = std_B;
    set @in_std_C = std_C;
    set @in_supplier_name = supplier_name;
    set @stmt = 'SELECT j.jno, count(pno), sum(qty) as sum, 
						getProjectLevel(sum(qty), ?, ?, ?) AS project_level, 
                        j.jname, j.city
						FROM spj,s,j 
						WHERE spj.sno = s.sno and spj.jno = j.jno and s.sname = ?
						GROUP BY jno';
    prepare st from @stmt;
    execute st using @in_std_A, @in_std_B, @in_std_C, @in_supplier_name;
    deallocate prepare st;
    
    open cur;
    cursorLoop: loop
        fetch cur into jno_val, pno_count, qty_sum, project_level_val, jname_val, city_val;
        if endRow then leave cursorLoop;
        end if;
        -- 공급자의 이름을 조건으로 전달하여 해당 공급자의 프로젝트별 부품 갯수를 출력한다. 
        -- cursor를 사용하여 해당되는 프로젝트의 이름(jname)과 도시(city)를 모두 출력한다. 
        select jno_val as jno, pno_count, 
				qty_sum as sum, project_level_val as project_level, 
                jname_val as jname, city_val as city;
    end loop cursorLoop;
    close cur;
END $$

call myCursor2(300,150,10, 'Blake')

