-- view 생성하기
create view good_supplier as select sno, status, city from s where status > 15;

-- view table에 select문 적용하기
select * from good_supplier;
select * from good_supplier where city != 'London';

-- view table에 update문 적용하기
SET SQL_SAFE_UPDATES = 0 -- 안전한 update 모드 해제해야 "You are using safe update mode ... "에러가 발생하지 않음
update good_supplier set status = status + 10 where city = 'Paris';

-- 기존 view 테이블을 재정의하고자 할 때
alter view good_supplier as select sno, city from s where status > 15;

-- view 제거하기
drop view if exists good_supplier;
