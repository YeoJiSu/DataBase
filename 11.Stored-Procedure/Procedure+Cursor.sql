use practice_final;
select sum(qty),jno from spj, s where spj.sno = s.sno and s.sname= "asd" group by jno ;
call getLevel(400,200,100, "asd");

select sum(qty), j.jname, j.city from spj,s,j
				where s.sno = spj.sno and j.jno = spj.jno and s.sname = "asd"
                group by spj.jno;
-- create function 
DELIMITER $$ 
USE `practice_final` $$
CREATE DEFINER = `root`@`localhost` FUNCTION `myLevel`(
gold int, silver int, bronze int, origin int) 
RETURNS varchar(20) DETERMINISTIC
BEGIN
	declare ml varchar(20);
    if origin > gold then set ml = 'gold';
    elseif origin > silver then set ml = 'silver';
    elseif origin > bronze then set ml = 'bronze';
    else set ml = 'nothing';
    end if;
RETURN ml;
END $$ 

-- create procedure - qty 합계별 등급 + 공급자의 이름을 조건 + cursor
DELIMITER $$ 
USE `practice_final` $$
CREATE DEFINER = `root`@`localhost` PROCEDURE `getLevel`(
	in gold int, in silver int, in bronze int, in sname varchar(45))
BEGIN
	declare stmt varchar(40);
    declare _gold int;
    declare _silver int;
    declare _bronze int;
    declare _sname varchar(45);
    
	declare _count int;
    declare _level varchar(10);
    declare _jname varchar(10);
    declare _city varchar(10);
    
    declare endRow int default 0;
    -- 여기 cursor에 선언되지 않은 _gold가 아닌, gold,silver,bronze,sname 고대로 넣어준다!!!! 
    declare dcursor cursor for select sum(qty), myLevel(gold,silver,bronze,sum(qty)) as level, j.jname, j.city from spj,s,j
				where s.sno = spj.sno and j.jno = spj.jno and s.sname = sname
                group by spj.jno;
	declare continue handler for not found set endRow = 1;
    set @_gold = gold;
    set @_silver = silver;
    set @_bronze = bronze;
    set @_sname = sname;
    set @stmt = "select j.jno,j.jname, j.city, sum(qty), myLevel(?,?,?,sum(qty)) as level from spj,s,j
				where s.sno = spj.sno and j.jno = spj.jno and s.sname = ?
                group by spj.jno";
    prepare st from @stmt;
    execute st using @_gold,@_silver,@_bronze, @_sname;
    deallocate prepare st;
    
    open dcursor;
    cursorLoop: loop 
		fetch dcursor into _count, _level, _jname, _city;
        if endRow then leave cursorLoop;
        end if;
        -- end if 밑에 다가 적어야 출력됨.
        select _count as count, _level as level, _jname as name, _city as city;
	end loop cursorLoop;
    close dcursor;
END $$

