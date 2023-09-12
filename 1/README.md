# MySQL workbench 사용

<details>
<summary>1. schema 생성</summary>
<div markdown="1">
  
<img height="200" alt="스크린샷 2023-09-12 오후 4 12 19" src="https://github.com/YeoJiSu/DataBase/assets/76769044/568d4873-74ac-4b66-8159-7f23983caaeb"/>
<img height="200" alt="스크린샷 2023-09-12 오후 4 13 18" src="https://github.com/YeoJiSu/DataBase/assets/76769044/aa424fc2-fed7-4ae9-ac35-15df69708983"/>

```mysql
CREATE SCHEMA 'warehouse' DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
```

```mysql
CREATE TABLE `p` (
  `pno` char(4) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `pname` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `color` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `weight` double NOT NULL,
  `city` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`pno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci
```

</div>
</details>

<details>
<summary>2. 테이블 레코드 입력</summary>
<div markdown="1">
<img width="280" alt="스크린샷 2023-09-12 오후 4 20 04" src="https://github.com/YeoJiSu/DataBase/assets/76769044/2802c4d4-940d-42dc-bbd8-00dca3853687">
<img width="280" alt="스크린샷 2023-09-12 오후 4 20 20" src="https://github.com/YeoJiSu/DataBase/assets/76769044/f17ba5f0-dba2-4815-bc37-84fa785ef5a3">
<img width="280" alt="스크린샷 2023-09-12 오후 4 20 37" src="https://github.com/YeoJiSu/DataBase/assets/76769044/bf7161ca-4c6e-4788-8f20-b77f43bf0028">
<img width="280" alt="스크린샷 2023-09-12 오후 4 20 51" src="https://github.com/YeoJiSu/DataBase/assets/76769044/78260923-f62d-4c54-89aa-31a725a4693f">
<img width="280" alt="스크린샷 2023-09-12 오후 4 21 16" src="https://github.com/YeoJiSu/DataBase/assets/76769044/d46abf70-79e0-46a6-b950-006d7936cba0">
<img width="280" alt="스크린샷 2023-09-12 오후 4 21 27" src="https://github.com/YeoJiSu/DataBase/assets/76769044/7cba6f96-d638-4d27-b04f-246f3e81c464">
</div>
</details>

<details>
<summary>3. SQL 검색</summary>
<div markdown="1">
  
```mysql
select * from warehouse.s;
select sname,city from s;
```

</div>
</details>

<details>
<summary>4. Table 생성과 삭제</summary>
<div markdown="1">

* 테이블 생성
```mysql
create table tempS(id int);
```
* 테이블 삭제
```mysql
drop table tempS;
```

</div>
</details>

<details>
<summary>5. Index</summary>
<div markdown="1">

```mysql
create index myindex on s(city);
```
<img width="397" alt="스크린샷 2023-09-12 오후 4 31 34" src="https://github.com/YeoJiSu/DataBase/assets/76769044/f51d2416-ba68-4b58-a3dc-ba062d39fda9">

</div>
</details>

<details>
<summary>6. View </summary>
<div markdown="1">
  
```mysql
CREATE VIEW `new_view` AS select sname from s where status >20;
```
<img width="845" alt="스크린샷 2023-09-12 오후 4 30 14" src="https://github.com/YeoJiSu/DataBase/assets/76769044/1b6d2213-255c-46cf-9a63-61db8936cdf4">

</div>
</details>

<details>
<summary>7. Stored procedure</summary>
<div markdown="1">

```mysql
CREATE PROCEDURE `new_procedure` ()
BEGIN
select * from s;
select city from s where status > 20;
END
```

<img width="652" alt="스크린샷 2023-09-12 오후 4 33 45" src="https://github.com/YeoJiSu/DataBase/assets/76769044/ae5c016a-b416-452d-a409-a7386c536d36">

</div>
</details>

<details>
<summary>8. Trigger</summary>
<div markdown="1">

1. dept, deletedDept 테이블 정의하기
   * dept에서 레코드가 삭제되면, 해당 레코드를 deletedDept에 저장하는 trigger를 만들 예정.

2. trigger 설정

   <img width="1436" alt="스크린샷 2023-09-12 오후 4 38 39" src="https://github.com/YeoJiSu/DataBase/assets/76769044/ba09a62b-29fb-4d78-a23a-6afd74ddc504">

  ```mysql
  insert into deletedDept values(old.dno, old.dname, old.budget);
  ```


</div>
</details>

<details>
<summary>9. DB backup과 관리</summary>
<div markdown="1">
  
<img width="721" alt="스크린샷 2023-09-12 오후 4 41 57" src="https://github.com/YeoJiSu/DataBase/assets/76769044/262c9537-f0ab-4e70-b085-efe50beb0d5d">

</div>
</details>
