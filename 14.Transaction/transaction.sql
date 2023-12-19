-- read uncommitted: 다른 transaction의 commit되지 않은 데이터를 read하거나 write하는 경우
set session transaction isolation level read uncommitted;
start transaction;
-- read committed 
set session transaction isolation level read committed;
start transaction;
-- repeatable read
set session transaction isolation level repeatable read;
start transaction;
-- serializable
set session transaction isolation level serializable;
start transaction;

-- Dirty Read
-- TA: read uncommitted,  TB: repeatable read
-- TA가 TB에서 commit하지 않은 데이터를 읽은 경우
-- TA
select * from s;
-- TB
insert into s values("s6","Jisu",15, "Pusan");

-- Non-Repeatable Read
-- TA: read uncommitted,  TB: repeatable read
-- TA의 두번의 select 문 결과가 다른 경우
-- TA
select * from s;
-- TB
insert into s values("s6","Jisu",15, "Pusan");
-- TA
select * from s;

-- Phantom Read
-- TA: read uncommitted,  TB: repeatable read
-- TA의 두번째 결과가 첫번째 결과에는 없던 새로운 record가 나오는 경우
-- 이걸 방지하려면, 둘다 repeatable read로 설정되어야한다. 
-- TA
select * from s;
-- TB
insert into s values("s6","Jisu",15, "Pusan");
-- TA
select * from s;

-- 락이 잘 걸어진 경우
-- TA: serializable,  TB: serializable
-- TA
update spj set qty = qty * (1+0.1);
-- TB 
update spj set qty = qty - 1 where sno = 's1'; -- 여기서 대기함
-- 만약 TA에서 commit; 수행하면, TB 쿼리문 실행됨. 
commit; 