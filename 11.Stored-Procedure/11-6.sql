-- procedure에서 cursor 사용하기 
DELIMITER $$
USE `HW3` $$
CREATE DEFINER = `root`@`localhost` PROCEDURE `cursor_dept`()
BEGIN
	declare bsum int default 0;
    declare b int;
    declare endRow int default 0;
    declare dcursor cursor for select budget from dept; -- cursor는 각 row를 하나씩 접근하는 방법을 제공
    declare continue handler for not found set endRow = 1;
    open dcursor;
    cursorLoop: loop
		fetch dcursor into b;
        if endRow then leave cursorLoop;
        end if;
        select b as 'budget'; -- 하나씩 접근하여 budget을 모두 더한다.
        set bsum = bsum + b;
	end loop cursorLoop;
    select bsum as 'total sum of budget';
    close dcursor;
END $$

call cursor_dept();