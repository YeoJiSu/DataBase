use HW3;

-- create trigger
delimiter $$
create trigger t_delete
	after delete
    on dept
    for each row
begin
	insert into deletedDept
		values(old.dno, old.dname, old.budget, curdate());
end $$

delete from dept where budget < 10;