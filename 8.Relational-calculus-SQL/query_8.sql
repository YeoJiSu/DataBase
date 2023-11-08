-- 부록
-- 1. 모든 프로젝트의 내용을 출력하라.
select * from j;
-- 2. 런던에 있는 모든 프로젝트의 내용을 출력하라.
select * from j where city = 'London';
-- 3. J1 프로젝트를 공급하는 공급자의 번호를 번호 순으로 출력하라.
select distinct sno from spj where jno = 'J1' order by sno;
-- 4. 300 이상 750 이하의 양인 모든 수송품들을 출력하라.
select * from spj where qty >= 300 and qty <= 750;
-- 5. 부품의 color와 city의 조합을 출력하라. 단, 중복되는 쌍이 없게 출력하라.
select distinct color, city from p;
-- 6. 공급자 번호, 부품 번호, 프로젝트 번호를 출력하라. 단, 공급자, 부품, 프로젝트는 모두 같은 지역이다. 
select distinct sno,pno,jno from s,p,j where s.city = p.city and p.city = j.city;
-- 7. 공급자 번호, 부품 번호, 프로젝트 번호를 출력하라. 단, 공급자, 부품, 프로젝트는 모두 같은 지역은 아니다.
select distinct sno,pno,jno from s,p,j where not (s.city = p.city and p.city = j.city);
-- 8. 공급자 번호, 부품 번호, 프로젝트 번호를 출력하라. 단, 공급자, 부품, 프로젝트의 어느 지역도 서로 같은 지역이 아니다.
select distinct sno,pno,jno from s,p,j where s.city <> p.city and p.city <> j.city and j.city <> s.city;
-- 9. 런던에 있는 공급자에 의해 공급된 부품의 번호를 출력하라.
select distinct spj.pno from spj, s where spj.sno = s.sno and s.city = 'london';
-- 10. 런던에 있는 프로젝트로 런던에 있는 공급자에 의해 공급된 부품의 번호를 출력하라.
select distinct spj.pno from spj, s, j where spj.sno = s.sno and spj.jno = j.jno and s.city = 'london'and j.city='london';
-- 11. 공급자의 도시(first)와 그 공급자가 공급한 프로젝트(second) 도시에 대한 모든 도시의 쌍을 구해라. 
select distinct s.city, j.city from spj, s, j where spj.sno = s.sno and spj.jno = j.jno;
-- 12. 한 도시에 있는 공급자가 같은 도시에 있는 프로젝트에 공급하는 부품의 부품 번호와 이름을 찾아라.
select distinct pno from spj,s,j where spj.sno = s.sno and spj.jno = j.jno and s.city = j.city;
-- 13. 같은 도시에 있지 않은 "적어도 하나"의 공급업체가 공급한 프로젝트에 대한 프로젝트 번호를 출력하라.
select distinct spj.jno from spj,s,j where spj.sno = s.sno and spj.jno = j.jno and s.city <> j.city;
-- 14. 어떤 공급자가 두 부품 모두 공급하는 모든 부품 번호의 쌍을 출력하라. 
select distinct A.pno, B.pno from spj A, spj B where A.sno = B.sno and A.pno > B.pno;
-- 15. 공급자 S1에 의해 공급되는 전체 프로젝트의 수를 구해라.
select count(distinct pno) from spj where sno = 's1';
-- 16. 공급자 S1에 의해 공급되는 부품 p1의 qty을 구해라.
select sum(qty) from spj where pno = 'p1' and sno = 's1';
-- 17. 프로젝트에 공급되는 각 부품들에 대해, 부품 번호, 프로젝트 번호, 그리고 그에 일치하는 총 qty를 구해라. 
select pno, jno, sum(qty) from spj group by pno, jno;
-- 18. 어떤 프로젝트에 평균 320 qty 이상 공급되는 부품의 번호를 출력하라. 
select distinct pno from spj group by pno, jno having avg(qty)>=320;
-- 19. qty가 null이 아닌 모든 수송품들을 출력하라.
select * from spj where qty is not null;
-- 20. 도시의 두번째 자리에 o가 들어있는 프로젝트 번호와 도시를 출력하라.
select jno, city from j where city like "_o%";
-- 21. 공급자 s1에 의해 공급되는 프로젝트 이름을 출력하라.
select jname from j where jno in (select jno from spj where sno = 's1');
-- 22. 공급자 s1에 의해 공급되는 부품의 색을 출력하라. 
select distinct color from p, spj where spj.pno = p.pno and sno = 's1';
-- 23. 런던에 있는 프로젝트에 공급되는 부품 번호를 출력하라. 
select distinct pno from spj,j where spj.jno = j.jno and city = 'London';
-- 24. 공급자 s1에 의해 이용가능한 "적어도 한개"의 부품을 사용하는 프로젝트 번호를 출력하라. 
select distinct jno from spj where spj.sno = 's1';
-- 25. 최소 한개의 빨간 부품을 공급 받는, 최소 한명의 공급자가 공급 받는, 최소 한개의 부품을 공급 받는 공급자에 대해 공급자 번호를 출력하라.
select distinct sno from spj  where pno in
(select pno from spj  where sno in
(select sno from spj  where pno in 
(select pno from p where color = 'red')));
-- 26. 공급자 s1의 어떤 status 보다도 낮은 공급자 번호를 출력하라. 
select distinct sno from s where status < (select status from s where sno = 's1');
-- 27. 알파벳 순으로 도시를 나열했을 때 첫번 째에 해당되는 프로젝트 번호를 출력하라. 
select jno from j where city = (select min(city) from j);
-- 28. 프로젝트 J1에 공급되는 어떠한 부품의 qty양 보다 평균적으로 더 많은 양을 가진, 부품 p1에 의해 공급받는 프로젝트 번호를 출력하라.
select jno from spj where pno = 'p1' group by jno having avg(qty) > (select max(qty) from spj where jno = 'J1');
-- 29. "해당 프로젝트에 사용되는" 부품 P1의 평균 양보다 더 많은 양을 가진, 어떤 프로젝트에 부품 p1을 공급하는 공급자 번호를 출력하라.
select sno from spj A where pno = 'p1' and qty > (select avg(qty) from spj B where pno = 'p1' and B.jno = A.jno);
-- 30. 런던에 있는 프로젝트에 공급되는 부품의 번호를 출력하라 (exists 사용하기)
select distinct pno from spj where exists (select * from j where city = 'london' and j.jno = spj.jno);
-- 31. 공급자 s1이 사용 가능한 적어도 하나의 부품을 사용하는 프로젝트 번호를 출력하라 (exists 사용하기)
select distinct jno from spj A where exists (select pno from spj B where A.jno = B.jno and B.sno = 's1');
-- 32. 어떠한 런던 공급자로부터 어떠한 빨간 부품을 공급받지 않는 프로젝트 번호를 출력하라
select distinct jno from j where not exists 
(select * from spj where sno in 
(select sno from s where city = 'London') and pno in -- in 쓸 때는 키 표시 안해도 됨.
(select pno from p where color = 'Red') and j.jno = spj.jno);	
-- 33. S1 업체에 완전히 의해 공급되는 프로젝트의 프로젝트 번호를 출력하라.
-- -> S1 업체에서만 공급되고 다른 어떤 업체에서도 공급되지 않는 프로젝트들의 프로젝트 번호 출력하라.
select distinct jno from spj A where not exists (select * from spj B where B.sno != 's1' and A.jno = B.jno);
-- 34. 런던에 있는 모든 프로젝트에 공급되는 부품 번호를 출력하라. 
-- -> 런던에 위치한 모든 프로젝트에 대해 부품이 공급되는 경우 해당 부품의 부품 번호 출력하라. 
select distinct pno from spj A where not exists ( -- 부품이 공급되는 경우 해당 부품의 부품 번호 출력
select * from j where city = 'london' and not exists( -- 런던에 위치한 모든 프로젝트에 대해 
select * from spj B where B.jno = j.jno and B.pno = A.pno));
-- 35. 모든 프로젝트에 같은 부품을 공급하는 공급자 번호를 출력하라. ⭐️ ⭐️ 
select distinct sno from spj A where exists ( -- 공급자 번호를 출력
select pno from spj B where not exists ( -- 같은 부품을 공급하는
select jno from j where not exists ( -- 모든 프로젝트에
select * from spj C where C.sno = A.sno and C.pno = B.pno and C.jno = j.jno)));
-- 36. 공급자 S1이 제공하는 모든 부품을 (적어도 모두 at least all) 사용하는 프로젝트의 프로젝트 번호를 가져와라. 
select distinct jno from spj A where not exists ( -- (적어도 모두) 사용하는 프로젝트의 프로젝트 번호를 가져와라
select pno from spj B where sno = 's1' and not exists( -- 공급자 S1이 제공하는 모든 부품을
select * from spj C where C.pno = B.pno and C.jno = A.jno));
-- 37. 공급자 s1이 사용 가능한 부품"만" 사용하는 프로젝트 번호를 출력하라.
select distinct jno from spj A where not exists (
select * from spj B where B.jno = A.jno and not exists(
select * from spj C where C.pno = B.pno and C.sno = 's1'));
-- 38. 공급자 S1이 공급하는 모든 부품 중 ( 몇몇 some of every) 공급업체 S1이 제공하는 프로젝트 번호를 출력하라.
select distinct jno from spj A where not exists(
select * from spj B where exists(
select * from spj C where C.sno = 's1' and C.pno = B.pno) and not exists(
select * from spj D where D.sno = 's1' and D.pno = B.pno and D.jno = A.jno));
select distinct jno from spj A where not exists( -- 공급업체 S1이 제공하는 프로젝트 번호를 출력하라.
select * from spj B where B.sno = 's1' and not exists( -- 공급자 S1이 공급하는 모든 부품 중
select * from spj C where C.sno = 's1' and C.pno = B.pno and C.jno = A.jno));
-- 39. 공급자 S1이 공급하는 부품 중 적어도 하나는 (at least some of every) 해당 프로젝트에 사용되는 모든 부품에 대해 프로젝트 번호를 가져와라.
-- 		해당 프로젝트가 사용하는 모든 부품 중 적어도 하나는 S1 업체에서 공급되어야 하며, 
-- 		이를 만족하는 프로젝트의 프로젝트 번호를 가져와라.
-- select * from spj B where B.sno = 's1'
select distinct jno from spj A where not exists(
select * from spj B where exists (
select * from spj C where C.pno = B.pno and C.jno = A.jno)and not exists(
select * from spj D where D.sno = 's1' and D.pno = B.pno and D.jno = A.jno));
select distinct jno from spj A where not exists (
select * from spj B where B.jno = A.jno and not exists(
select * from spj C where C.sno = 's1' and C.pno = B.pno and C.jno = A.jno));
-- 40. 빨간색 부품을 공급하는 어떤 공급자가 있는 모든 공급자로부터 공급받는 프로젝트의 프로젝트 번호를 가져와라.
-- 		즉, 빨간색 부품을 공급하는 어떤 공급자가 있는 모든 공급자에게서 프로젝트에 대한 공급이 이루어져야 하며, 
-- 		해당 프로젝트의 프로젝트 번호를 가져와야 합니다.
select distinct jno from spj A where not exists (
select * from spj B where exists 
(select * from spj C where C.sno = B.sno and C.pno in 
(select pno from p where color = 'red')and not exists (
select * from spj D where D.sno = B.sno and D.jno = A.jno)));
-- 41. 적어도 하나(at least one)의 공급업체, 부품 또는 프로젝트가 위치한 모든 도시의 순서가 지정된 목록을 만들어라.
-- 		모든 도시 중에서 공급업체, 부품 또는 프로젝트 중 적어도 하나가 위치한 도시를 나열하고, 
-- 		이를 특정한 순서로 정렬하여 목록을 생성하는 쿼리를 작성해야 합니다.
select city from s union select city from p union select city from j;
-- 42. 모든 빨간색 부품을 오렌지색으로 변경해라.
update p set color = 'Orange' where color = 'Red';
-- 43. 수송품이 없는 프로젝트를 삭제해라.
delete from j where jno not in (select jno from spj);
-- 44. 테이블 s에 새로운 공급자 s10을 추가해라. 이름은 Smith, 도시는 NewYork, status는 알려지지 않았다. 
insert into s (sno, name, city) values ('S10', 'Smith', 'NewYork');
-- 45. 런던 공급업체 또는 런던 프로젝트에 공급되는 부품의 부품 번호 목록이 포함된 테이블을 구성하라.
create table lp (pno char(46) not null, primary key(pno));
create unique index x46 on lp(pno);
insert into lp (pno) select distinct pno from spj 
where sno in (select sno from s where city = 'London') 
or jno in (select jno from j where city = 'London');
-- 46. 런던에 있거나 런던 공급자가 제공하는 프로젝트에 대한 프로젝트 번호 목록이 포함된 테이블을 구성하라.
create table lj (jno char(46) not null, primary key(jno));
create unique index x46 on lp(jno);
insert into lj (jno) select distinct jno from j where city = 'London' 
or jno in (select jno from spj where sno in (select sno from s where city = 'London'));

-- 8.4 Tuple calculus 예제 
-- 1. status > 20 인 paris에 있는 공급자의 번호와 status를 찾아라.
select sno, status from s where status > 20 and city = 'paris';
-- 2. 같은 도시에 있는 공급자들의 번호 쌍을 찾아라. 
select A.sno, B.sno from s A, s B where A.city = B.city and A.sno < B.sno;
-- 3. 부품 p2를 공급하는 공급자의 번호, 이름, status, 도시를 찾아라. 
select distinct * from s where sno in (select sno from spj where pno = 'p2');
select distinct * from s where exists (select * from spj where spj.sno = s.sno and pno = 'p2');
-- 4. 적어도 한 개 이상의 red 부품을 공급하는 공급자의 이름을 찾아라. 
select distinct sname from s where sno in 
(select sno from spj where pno in 
(select pno from p where color = 'red'));
select distinct sname from s where exists 
(select * from spj,p where spj.sno = s.sno and spj.pno = p.pno and p.color = 'red');
select distinct sname from s where exists (
select sno from spj where spj.sno = s.sno and exists (
select pno from p where p.pno = spj.pno and color = 'red'));
-- 5. 공급자 s2에 의해 공급된 부품을 적어도 한 개 이상 공급하는 공급자의 이름을 찾아라. 
select sname from s where sno in (
select sno from spj where pno in (
select pno from spj where sno = 's2'));
select sname from s where exists (
select sno from spj A where A.sno = s.sno and exists (
select pno from spj B where B.pno = A.pno and B.sno = 's2'));
select sname from s where exists (
select sno from spj A where exists (
select pno from spj B where B.pno = A.pno and A.sno = s.sno and B.sno = 's2'));
-- 6. 모든 부품을 공급하는 공급자의 이름을 찾아라. 
select sname from s where not exists (
select pno from p where not exists (
select * from spj where spj.pno = p.pno and spj.sno = s.sno));
-- 7. 부품 p2를 공급하지 않는 공급자의 이름을 찾아라. 
select sname from s where not exists (
select * from spj where spj.sno = s.sno and pno = 'p2');
-- 8. 공급자 s2에 의해 공급되는 부품을 적어도 모두(at least all) 공급하는 공급자의 번호를 찾아라. 
select distinct sno from spj A where not exists (
select pno from spj B where sno = 's2' and not exists(
select * from spj C where C.pno = B.pno and C.sno = A.sno));
-- 공급자 s1에 의해 공급되는 부품을 적어도 모두(at least all) 공급받는 프로젝트의 번호를 찾아라. (앞선 36번)
select distinct jno from spj A where not exists (
select pno from spj B where sno = 's1' and not exists (
select * from spj C where C.pno = B.pno and C.jno = A.jno));
-- 9. 공급자 s2가 공급하거나 부품의 무게가 26 pound 이상인 부품의 번호를 찾아라. 
select distinct pno from p where weight >= 26 or pno in (select pno from spj where sno = 's2');


-- 8.5장
-- 1. 무게 7000그램 이상인 부품의 번호와 무게를 그램으로 찾아라(p 테이블의 weight는 pound 단위이며 1파운드는 454그램이다)
select pno, weight*454 from p where weight*454 >= 7000;
-- 2. 모든 공급자의 번호, 이름, status, 도시를 찾아서 5번째 column에 "공급자"를 tag 항목으로 출력하라. 
select sno, sname, status, city, "공급자" as "tag" from s;
-- 3. 부품이 공급된 경우에 공급자 번호, 부품 번호, 부품 수량, 부품 무게(파운드)를 찾아라. 
select distinct spj.sno, p.pno, spj.qty, p.weight from spj, p where spj.pno = p.pno;
-- 4. 각 부품에 대하여 부품 번호와 공급된 부품 수량의 합을 구하라. 
select pno, sum(qty) from spj group by pno;
-- 5. 모든 부품의 총공급 수량의 합을 구하라.
select sum(qty) from spj;
-- 6. 각 공급자에 대하여 공급자 번호와 공급된 부품의 개수를 찾아라.
select sno, count(*) from spj group by sno;
select s.sno, count(*) from s,spj where spj.sno = s.sno group by s.sno;
-- 7. red 부품을 3개 이상 저장(공급 아님.)한 부품의 도시를 찾아라.
select distinct city from p where pno in
(select  pno from p where  p.color = 'red' group by pno having count(pno)>=3);

-- 8.6장
-- 1. 부품의 무게가 10 pound 이상이고 부품의 도시가 파리가 아닌 부품의 도시와 색상을 찾아라.
select city, color from p where p.city != 'Paris' and weight >= 10;
-- 2. 모든 부품에 대하여 부품 번호와 부품의 무게를 그램으로 찾아라. 
select pno, weight*454 as gram from p;
-- 3. 공급자의 도시와 부품의 도시가 같은 공급자와 부품 정보를 찾아라. 
select * from s,p where s.city = p.city;
select * from s join p where s.city = p.city;
select * from s join p on s.city = p.city;
-- 4. first city에 있는 공급자가 second city에 있는 부품을 공급할 때 두 도시 쌍을 찾아라. 
select distinct s.city, p.city from s,p,spj where spj.sno = s.sno and spj.pno = p.pno;
select distinct s.city, p.city from s join spj join p on s.sno = spj.sno and spj.pno = p.pno;
-- 5. 같은 도시에 있는 공급자의 모든 공급자 번호 쌍을 찾아라. 
select distinct A.sno, B.sno from s A, s B where A.city = B.city and A.sno < B.sno;
-- 6. 공급자 전체 숫자를 찾아라. 
select count(*)from s;
-- 7. 부품 p2의 최대, 최소 qty 값을 찾아라. 
select max(qty), min(qty) from spj where pno = 'p2';
-- 8. 공급된 부품에 대하여 부품 번호와 공급된 부품 수량을 찾아라.
select pno, sum(qty) from spj group by pno;
-- 9. 한 명 이상의 공급자에 공급된 부품의 번호를 찾아라.
select pno from spj group by pno having count(sno)>=1;
-- 10. 부품 p2를 공급하는 공급자의 이름을 찾아라. 
select distinct sname from s where sno in (select sno from spj where pno = 'p2');
select distinct sname from s, spj where spj.sno = s.sno and spj.pno = 'p2';
select distinct sname from s where exists (select * from spj where spj.sno = s.sno and spj.pno = 'p2');
-- 11. red 부품을 적어도 한 개 이상 공급하는 공급자의 이름을 찾아라. 
select distinct sname from s, spj, p where spj.sno = s.sno and spj.pno = p.pno and p.color = 'red';
-- 12. s 테이블의 최대 status 값보다 작은 status를 갖는 공급자의 이름을 찾아라. 
select sname from s where status < (select max(status) from s);
-- 13. 부품 p2를 공급하는 공급자의 이름을 찾아라. 
select distinct sname from s,spj where spj.sno = s.sno and spj.pno = 'p2';
-- 14. 부품 p2를 공급하지 않는 공급자의 이름을 찾아라. 
select sname from s where not exists (select * from spj where spj.sno = s.sno and spj.pno = 'p2');
-- 15. 모든 부품을 공급하는 공급자의 이름을 찾아라. 
select sname from s where not exists (
select pno from p where not exists (
select * from spj where spj.pno = p.pno and spj.sno = s.sno));
-- 16. 공급자의 부품 종류 갯수가 모든 부품의 종류 숫자와 같은 공급자의 이름을 찾아라. 
select sname from s where (select count(pno) from spj where spj.sno = s.sno) = (select count(pno)from p);
-- 17. 부품의 무게가 16 파운드 이상이거나 공급자 s2에 의해 공급된 부품 번호를 찾아라. 
select distinct p.pno from p,spj where spj.pno = p.pno and (p.weight>=16 or spj.sno = 's2');
select pno from p where p.weight >= 16 union select pno from spj where spj.sno = 's2';
-- 18. 부품의 무게가 10000그램 이상인 부품의 번호와 무게를 그램으로 찾아라. 
select pno, weight*454 as gram from p where weight*454 >= 10000;
-- 19. 공급된 모든 부품의 번호를 찾되 중복 결과는 제거하여 찾아라. 
select distinct pno from spj;
-- 20. 파리에 있는 공급자의 번호와 status를 찾되 공급자 번호는 올림차순으로 status는 내림차순으로 찾아라. 
select sno, status from s where city = 'paris' order by sno ASC, status DESC;
-- 21. 부품의 무게가 16보다 크고 19보다 작은 부품의 번호를 찾아라. 
select pno from p where weight>16 and weight<19;
-- 22. 공급된 부품 p2의 전체 수량을 찾아라. 
select count(pno) from spj where pno='p2';
-- 23. 한 명 이상의 공급자에 의해서 공급된 모든 부품의 부품 번호를 찾아라. 
select pno from p where pno in (select pno from spj group by pno having count(sno)>=1);
-- 24. 부품의 공급시에 수량이 300 이상인 공급 관계를 삭제하라.
delete from spj where qty >= 300;
-- 25. 부품 p2의 색상을 yellow로 바꾸고 무게는 5 증가하고 도시는 oslo로 변경하라.
update p set color = 'yellow', weight = weight+5, city = 'oslo' where pno = 'p2';

-- 8.7장
-- 1. 부품의 무게가 12 ~ 15인 부품의 이름을 찾아라.
select pname from p where weight>=12 and weight <= 15;
-- 2. 부품의 이름이 b로 시작하는 부품의 도시를 찾아라. 
select city from p where pname like "b%";
-- 3. 두번째 글짜가 u인 부품이름의 도시를 찾아라.
select city from p where pname like "_u%";

-- 8.8장
-- [insert 문]
insert into s(sno, sname, status, city) values('s9','Hong',10, 'Busan');
insert into s(sno, sname) values('s9','Hong');
-- [update 문]
update s set status = status + 10;
-- [delete 문] 
delete from s where city = 'London';