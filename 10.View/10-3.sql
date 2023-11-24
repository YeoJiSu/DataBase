-- base table
select * from s;
-- view tables
select * from good_supplier;
select * from bad_supplier;

-- 해당 구문은 base table(s 테이블)에 반영되고, view table(good_supplier 태이블)에도 반영됨. 
insert into good_supplier values('S10', 100, 'Busan');
-- 해당 구문은 base table(s 테이블)에는 반영되지만,  view table(good_supplier 태이블)에는 반영안됨. -> 조건을 만족하지 않기 때문.
insert into good_supplier values('S11', 10, 'Masan');

-- with check option을 사용하여 조건을 만족하지 못할 경우에 base table에 insert가 안되게 한다.
create view bad_supplier as select sno, status, city from s where status < 10 with check option;
insert into bad_supplier values('S12', 9, 'Busan'); -- 반영 O
insert into bad_supplier values('S14', 100, 'Masan'); -- 반영 X

-- view 테이블이 base 테이블의 primary key를 포함하지 않을 때
create view sc as select status, city from s;
insert into sc values(5, 'Busan'); -- 실행 X => base 테이블의 primary key는 not null이기 때문.
select * from sc;

-- join view
create view ssp as select s.sno, sname, status, city, pno, qty from s join sp on s.sno = sp.sno;
select * from ssp;
insert into ssp values ('S1', 'Hong', 10, 'Busan', 'P1', 10); -- 오류: join view에서는 허용 X
insert into ssp(sno, sname, status, city) values('S9', 'Hong', 10, 'Busan'); -- 하나의 base table에 대한 insert일 때는 허용됨.
select * from s; -- base table에서는 보이지만, 
select * from ssp; -- view table에서는 보이지 않는다.