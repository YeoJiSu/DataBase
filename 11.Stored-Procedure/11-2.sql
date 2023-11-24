-- getSC procedure 생성
DELIMITER $$
USE `HW3` $$
CREATE DEFINER= `root`@`localhost` PROCEDURE `getSC`()
BEGIN 
	declare ratio int; -- declare 로 변수 선언
    set ratio = 15; -- 값의 변경은 set으로
    if ratio = 10 then
		select sno, city from s where status > 20 order by city desc;
	else
		select sname, status from s where status < 20;
	end if;
END $$

-- getSC procedure 실행
call getSC();

-- getStatus procedure 생성
DELIMITER $$
USE `HW3` $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getStatus`(
	in cname varchar(45),
    out sumStatus int)
BEGIN 
	select sum(status)
    into sumStatus -- output에 값을 넣음.
    from s
    where city=cname;
END $$

-- getStatus procedure 실행
call getStatus('London', @total);
select @total;

-- getStatus2 procedure 생성
DELIMITER $$
USE `HW3` $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getStatus2`(
	in cname varchar(45),
    out sumStatus int)
BEGIN
	declare amount int;
    set amount = 0;
    case
		when cname = 'London' then
			set amount = amount + 10;
		when cname = 'Paris' then
			set amount = amount + 20;
		when cname = 'Oslo' then
			set amount = amount + 30;
		else
			set amount = 5;
    end case;
    select sum(status)
    into sumStatus
    from s 
    where status < amount;
END $$

-- getStatus2 procedure 실행
call getStatus2('London', @total);
select @total;

-- getQtySum procedure 생성
DELIMITER $$
USE `HW3` $$
CREATE DEFINER = `root`@`localhost` PROCEDURE `getQtySum`(
	in base int)
BEGIN
	select pno, sum(qty) as tot_qty,
		case
			when (sum(qty) > base) then 'good_qty'
            when (sum(qty) = base) then 'usual_qty'
            when (sum(qty) > 0) then 'bad_qty'
            else 'poor_qty'
		end as 'part_level'
	from sp
    group by pno;
END$$

-- getQtySum procedure 실행
call getQtySum(500);

