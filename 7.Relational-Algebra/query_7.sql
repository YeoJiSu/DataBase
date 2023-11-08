-- 1. London에 있는 프로젝트 이름을 찾아라.
select jname from j where city = "London";
-- 2. 프로젝트 J1에 참여하는 공급자의 이름을 찾아라.
select distinct s.sname from s,spj where s.sno = spj.sno and spj.jno = "J1";
-- 3. 공급 수량이 300 이상 750 이하인 모든 공급의 sno, pno, qty를 찾아라.
select sno, pno, qty from spj where qty>=300 and qty <= 750;
-- 4. 부품의 color와 city의 모든 쌍을 찾아라. 같은 쌍은 한 번만 점색되어야 한다.
select distinct color, city from p ;
-- 5. 같은 도시에 있는 공급자, 부품, 프로젝트의 모든 sno,pno, jno 쌍을 찾아라. 찾아진 sng, pno, jno의 city들은 모두 같아야 한다.
select distinct s.sno, p.pno, j.jno from s,p,j where s.city = p.city and p.city = j.city and j.city = s.city;
-- 6. 같은 도시에 있지 않는 공급자, 부품, 프로젝트의 sno, pno, jno을 찾아라. 찾아진 sno, pno, jno의 city 들은 같은 것이 없어야 한다.
select distinct s.sno, p.pno, j.jno from s,p,j where s.city != p.city and p.city != j.city and j.city != s.city;
-- 7. London에 있는 공급자에 의해 공급된 부품의 번호, 이름을 찾아라.
select distinct p.pno, p.pname from p, spj, s where p.pno = spj.pno and spj.sno = s.sno and s.city = "London";
-- 8. London에 있는 공급자가 London의 프로젝트에 공급한 부품의 부품 번호와 이름을 찾아라.
select distinct p.pno, p.pname from p, spj, s, j where p.pno = spj.pno and spj.sno = s.sno and spj.jno = j.jno and j.city = "London" and s.city = "London";
-- 9. 한 도시에 있는 공급자가 다른 도시에 있는 프로젝트에 공급할 때 공급자 도시, 프로젝트 도시 쌍을 모두 구하라.
select distinct s.city, j.city from s, j, spj where spj.sno = s.sno and spj.jno = j.jno;
-- 10. 한 도시에 있는 공급자가 같은 도시에 있는 프로젝트에 공급하는 부품의 부품 번호와 이름을 찾아라.
select distinct p.pno, p.pname from s,p,j, spj where spj.sno = s.sno and spj.pno = p.pno and spj.jno = j.jno and s.city = j.city;
-- 11. 같은 도시에 있지 않은, 적어도 한 명 이상의 공급자들에 의해 공급되고 있는 프로젝트의 번호와 이름을 찾아라.
select distinct j.jno, j.jname from j, spj, s where spj.jno = j.jno and spj.sno = s.sno and s.city != j.city;
-- 12. 어떤 공급자가 2개 이상의 부품을 공급할 때 공급된 부품 sno의 리스트를 찾아라. 부품이 1개 공급한 경우는 제외한다.
select distinct sno from spj group by sno having count(pno)>=2; -- 단순 2개 이상
select distinct sno from spj group by sno having count(distinct pno)>=2; -- 부품 종류가 같으면 같은 걸로 취급한다면?
-- 13. 공급자 s1이 공급한 프로젝트 개수를 찾아라.
select count(distinct jno) from spj where sno = 's1';
-- 14. 공급자 S1이 공급한 부품 p1의 전체 수량을 찾아라.
select sum(qty) from spj where sno = 's1' and pno = 'p1';
-- 15. 프로젝트에 공급된 각 부품에 대하여, 각 부품 번호, 공급된 프로젝트 번호, 각 프로젝트에 공급된 수량을 찾아라.
select pno, jno, sum(qty) from spj group by pno, jno;
-- 16. any 프로젝트에 공급된 부품의 수량 평균이 350 이상인 부품의 번호를 찾아라. 부품이 여러 프로젝트 공급되는데 공급된 부품 수량의 평균(부품 수량을 프로젝트 개수로 나눈)이 350 이상 되는 것을 말한다.
select distinct pno from spj group by pno,jno having avg(qty) >= 350; -- ⭐️
-- 17. 공급자 s1이 공급한 프로젝트 번호와 이름을 찾아라.
select j.jno, j.jname from spj, j where spj.jno = j.jno and spj.sno = 's1';
-- 18. 공급자 S1이 공급한 부품의 color를 찾아라.
select distinct p.color from spj, p where spj.pno = p.pno and spj.sno = 's1';
-- 19. London에 있는 프로젝트에 공급한 부품의 번호와 이름을 찾아라.
select distinct p.pno, p.pname from spj, p,j where spj.pno = p.pno and spj.jno = j.jno and j.city = 'london';
-- 20. 공급자 S1이 공급한 any 부품을 적어도(at least) 한 개 이상 사용하는 프로젝트의 번호와 이름을 찾아라.
select distinct j.jno, j.jname from j,spj,s where j.jno = spj.jno and spj.sno = s.sno and s.sno = 's1'; -- 적어도 한개 이상 = 앞에꺼랑 똑같음.
-- 21. 적어도(at least) 한 개 이상의 red 부품을 공급하는 적어도(at least) 한 명 이상의 공급자들이 공급하는 적어도(at least) 한 개 이상의 부품을 공급하는 공급자의 번호와 이름을 찾아라.
select distinct s.sno, s.sname from s where sno in (select sno from spj where pno in (select pno from p where p.color = 'red'));
-- 22. 공급자 s1의 status 값보다 더 낮은 status를 갖는 공급자의 번호와 이름을 찾아라.
select s.sno, s.sname from s where status < (select status from s where sno = 's1');
-- 23. 프로젝트의 city 목록에서 알파벳 순서에서 첫 번째 도시의 프로젝트 번호와 이름을 찾아라.
select distinct jno, jname from j where city in (select min(city) from j); -- ⭐
-- 24. 부품 p1의 프로젝트 공급 수량의 평균이 프로젝트 j1에 공급된 any 부품의 최대 수량보다 더 큰 프로젝트의 번호와 이름을 찾아라. 
-- 부품 p1은 공급자 s1, s2, ., sn에 의하여 각 프로젝트에 공급될 때 각 공급자의 공급 수량의 평균을 구한다.
select jno, jname from j where exists (
select avg(qty) from spj where pno = 'p1' group by pno, sno having avg(qty) > (select max(qty) from spj where jno = 'j1' 
and j.jno = spj.jno)); 
-- 25. 부품 p1을 어떤 프로젝트에 공급하는 수량이 
-- 그 프로젝트를 위한 부품 p1의 평균 공급 수량(평균 공급 수량은 각 공급자가 공급하는 수량의 평균이다)보다 더 큰 공급자의 번호와 이름을 찾아라.
select sno, sname from s where sno in (
select sno from spj where pno = 'p1' and qty > (select avg(qty) from spj where pno = 'p1' group by pno));
-- 26. London에 있는 공급자에 의해 어떠한 red 부품도 공급받지 않는 프로젝트의 번호와 이름을 찾아라.
select jno, jname from j where not exists (select * from spj,p,s where p.color = 'red' and s.city = 'london' and spj.pno = p.pno and spj.sno = s.sno);
-- 27. 공급자 S1에 의해서만 부품을 공급받는 프로젝트의 번호와 이름을 찾아라.
select jno, jname from j where not exists (select * from spj where sno != 's1' and spj.jno = j.jno);
-- 28. London에 있는 모든 프로젝트에 공급되는 부품의 번호와 이름을 찾아라.
select pno, pname from p where not exists (
select * from j where city = 'london'and not exists(
select * from spj where spj.jno = j.jno and spj.pno = p.pno));
-- 29. 모든 프로젝트에 같은 부품들을 공급하는 공급자의 번호와 이름을 찾아라.
select distinct sno, sname from s where exists ( -- 공급자 번호를 출력
select pno from spj B where not exists ( -- 같은 부품을 공급하는
select jno from j where not exists ( -- 모든 프로젝트에
select * from spj C where C.sno = s.sno and C.pno = B.pno and C.jno = j.jno)));
-- 30. 공급자 s1이 공급하는 모든 부품을 적어도 그 이상 공급받는 프로젝트의 번호와 이름을 찾아라. -- 😂 애매함.
select jno, jname from j where not exists (
select pno from spj A where sno = 's1' and not exists (
select * from spj B where B.pno = A.pno and B.jno = j.jno));
-- 31. 적어도 한 공급자가 있는 city이거나, 적어도 한 부품의 city이거나, 적어도 한 프로젝트의 city인 모든 city 이름을 찾아라.
select distinct city from s union select distinct city from j union select distinct city from p;
-- 32. London에 있는 공급자에 의해서 공급되거나 London에 있는 프로젝트에 공급된 부품의 번호와 이름을 찾아라.
select distinct p.pno, p.pname from p, spj, s, j where spj.pno = p.pno and spj.sno = s.sno and spj.jno = j.jno and (s.city = 'London' or j.city = 'London');
-- 33. 어떤 부품을 공급하지 않는 공급자 또는 어떤 공급자에 의해서도 공급되지 않는 부품의 공급자 번호, 부품 번호 쌍을 찾아라.
select sno,pno from s, p where not exists (select sno,pno from spj);
select sno from s where not exists (select sno from spj);
select pno from p where not exists (select pno from spj);
-- 34. 같은 종류의 부품들을 공급하는 공급자 쌍을 공급자 번호의 쌍으로 찾아라.
select distinct A.sno, B.sno from spj A, spj B where A.pno = B.pno and A.sno < B.sno;