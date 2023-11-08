select jname from j where city = 'London';
select s.sname from s, j, spj where j.jno = 'J1' and spj.jno = j.jno and spj.sno = s.sno;
select sno, pno, qty from sp where qty >= 300 and qty <= 750;
select distinct color, city from p;
select sno, pno, jno from s, p, j where s.city = p.city and p.city = j.city;
select sno, pno, jno from s, p, j where s.city <> p.city and p.city <> j.city and j.city <> s.city;
select distinct p.pno, p.pname from p, s, sp where sp.pno = p.pno and sp.sno = s.sno and s.city = 'London';
select p.pno, p.pname from s , j, p, spj where s.city = 'London' and j.city = 'London' and spj.sno = s.sno and spj.jno = j.jno and spj.pno = p.pno;

select distinct p.pno, p.pname from s,p,j, spj where s.city = j.city and spj.sno = s.sno and spj.pno = p.pno and spj.jno = j.jno;
