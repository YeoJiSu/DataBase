## EER modelling
<img width="900" alt="스크린샷 2023-09-23 오후 5 32 23" src="https://github.com/YeoJiSu/DataBase/assets/76769044/289a6b6f-9535-4770-bd81-110912bf2ccb">

- sj,sp,pj, spj,pp,wp의 경우 다대다 관계이기 때문에 모두 테이블로 만들어 관계를 표시했습니다. 
- 나머지는 관계는 아래의 시나리오에 의해 관계를 표현했습니다.
- sl: 한 지역에는 여러 공급자가 있다. 
- wl: 한 지역에는 여러개의 창구가 있다. 
- we: 한 창구는 여러 직원이 관리할 수 있다. 
- ld: 한 지역에는 여러 부서가 있다. 
- ed: 한 부서에는 여러 직원이 있다. 
- ej: 한 프로젝트는 여러 직원이 담당할 수 있다. 
- mj: 한 프로젝트에 대해 여러 직원 중 isManager == 1인 직원이 매니저 역할을 담당할 수 있다. 

#### 보충 설명
<img width="800" src="https://github.com/YeoJiSu/DataBase/blob/main/2/20230926.png">
* 1대다는 테이블을 생성하지 않지만, 다대다는 테이블을 생성한다. 
* identifying(실선)은 foreign 식별자를 생성하지만, non-identifying(점선)은 식별자를 생성하진 않는다. 단순 foriegn 속성을 생성한다. 
