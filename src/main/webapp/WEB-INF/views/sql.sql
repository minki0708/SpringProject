select p.* from product2 p left join blockProduct2 b 
		on p.idx = b.productIdx where b.productIdx is null order by p.idx desc
select * from orderProduct2 where sellerIdx = 27 or buyerIdx =27

delete from product2 p join reportProduct2 r on p.idx = r.productIdx where idx = #{idx}

delete p.*,r.* from product2 p join reportProduct2 r on p.idx = r.productIdx where r.idx = 8

select *, p.content as content, u.mid as reportedMid, u2.mid as reporterMid  
			from reportReply2 r inner join user2 u on r.userIdx = u.idx
			inner join user2 u2 on r.reporterIdx = u2.idx
			inner join productReply2 p on r.replyIdx = p.idx 
			inner join product2 pr on  pr.idx = p.productIdx 

select *
, o.idx as orderIdx
, u.mid as sellerMid, u.name as sellerName, u.tel as sellerTel, u.email as sellerEmail 
, u2.mid as buyerMid, u2.name as buyerName, u2.tel as buyerTel, u2.email as buyerEmail
, b.accountNumber as sellerAccount, b.bankInfo as sellerBank
, b2.accountNumber as buyerAccount, b2.bankInfo as buyerBank
from orderProduct2 o inner join user2 u on o.sellerIdx = u.idx
inner join user2 u2 on o.buyerIdx = u2.idx 
inner join product2 p on p.idx = o.productIdx			
inner join userBankAccount2 b on b.userIdx = u.idx			
inner join userBankAccount2 b2 on b2.userIdx = u2.idx			

/*
select *
, o.idx as orderIdx
, u.mid as sellerMid, u.name as sellerName, u.tel as sellerTel, u.email as sellerEmail 
, u2.mid as buyerMid, u2.name as buyerName, u2.tel as buyerTel, u2.email as buyerEmail
, b.accountNumber as sellerAccount, b.bankInfo as sellerBank
from orderProduct2 o inner join user2 u on o.sellerIdx = u.idx
inner join user2 u2 on o.buyerIdx = u2.idx 
inner join product2 p on p.idx = o.productIdx			
inner join userBankAccount2 b on b.userIdx = u.idx			
*/		
			
select *
		from orderProduct2 
		where sellerIdx = 27 or buyerIdx = 27			
			
			
			
select p.*, r.* 
from productReply2 p join reportReply2 r on p.idx = r.replyIdx where p.idx = 16

select *
from orderProduct2 where sellerIdx = 27 or buyerIdx = 27

select * from userOut2 where uIdx = 22


select userIdx from product2 where idx=4
select o.* , p.* from orderProduct2 o INNER JOIN product2 p on o.productIdx = p.idx where o.sellerIdx = 27 or o.buyerIdx = 27
show databases;
use javagreen_jmk;
update user2 set pwd = "", name = "성명명", nickName = "닉네임5", tel = "tel", email = "이메일", address = "ㅇ", content = "콘텐츠" where mid = "test1";
show tables;
drop table productReply2;
select * from smallCategory2 where midiumIdx = 6
update user2 set pwd = "1234", name = "이름", nickName = "니네임", tel = "tel", email = "emioal", address = "", content = "" where mid = "test1";
insert into user2 values(default,"admin","1234","관리자","관리자","01012341234","이메일","주소",default,0,default,"소개");  
insert into user2 values(default,"asdf1","1234","이름","닉네임1","01012341234","이메일","주소",default,0,default,"소개");  
SELECT * from user2 WHERE NOT EXISTS ( SELECT * FROM user2 WHERE mid = 'admin1' AND nickName ='관리자1' );
select * from user2 where mid = "admin" and pwd = "1234";     
select * from user2 where name = "관리자" and tel = "01012341234";
select * from user2 where mid = "admin" and name = "관리자" and tel = "01012341234";
desc user2;

select *, u.mid as reportedMid, u2.mid as reporterMid  
from reportProduct2 r inner join user2 u on r.userIdx = u.idx
inner join user2 u2 on r.reporterIdx = u2.idx
inner join product2 p on r.productIdx= p.idx 

select u.mid as reportedMid
from reportProduct2 r inner join user2 u on r.userIdx = u.idx


select *,p.title
from orderProduct2 o inner join product2 p on o.productIdx = p.idx
inner join user2 u on p.userIdx = u.idx

delete from orderProduct2 where idx=2;
delete from midiumCategory2 where midiumIdx = 6;
update largeCategory2 set 
delete from largeCategory2 where largeIdx = 1;
select * from product2;
alter table product2 drop likes;
update user2 set pwd ="1234" where mid = "test2";
insert into largeCategory2 values(default,"Test");
select * from likes2;
select count(*) from likes2 where productIdx = 2
update product2 set largeIdx = 7,midiumIdx = 7,smallIdx = 6,fName = "123",fSName = "123",title = 123,content = 123,address = 123,price = 777 where idx = 1;
select * from likes2 where productIdx = 1 and userIdx = 2;
select l.name, m.name, s.name 
from smallCategory2 as s, midiumCategory2 as m, largeCategory2 as l, product2 as p 
where p.idx = 13 and s.smallIdx = p.smallIdx and m.midiumIdx = p.midiumIdx and l.largeIdx = p.largeIdx;
delete from likes2 where userIdx = 27 and productIdx = 21;
insert into likes2 values(27,21);
select m.name from midiumCategory2 as m where midiumIdx = (select midiumIdx from product2 where idx = 13)
//select s.name, m.name,  from  smallCategory2 as s, midiumCategory2 as m where (select midiumIdx, smallIdx from product2 where idx = 13)
select p.*,u.nickName from productReply2 as p,user2 as u where p.productIdx = 2 group by parentIdx order by idx, rOrder;
insert into likes2 values(27,21);
alter table smallCategory2 change sName name varchar(20)
midiumCategory2largeCategory2

delete from product2 where idx = 28;

update orderProduct2 set deliveryStatus="배송중" where idx=3;

select * from product2 where idx = 1;
select * from product2 where idx = 27;

select l.lName, m.mName, s.sName ,p.*
from smallCategory2 as s, midiumCategory2 as m, largeCategory2 as l, product2 as p 
where p.idx = 1 and s.smallIdx = p.smallIdx and m.midiumIdx = p.midiumIdx and l.largeIdx = p.largeIdx;
	delete from likes2 where userIdx = #{sIdx} and productIdx = #{idx};	
	
	delete from product2 where idx = 28;		
select * from product2 p LEFT JOIN blockProduct2 b on p.idx = b.productIdx order by p.idx desc limit 1,15;	

select * from product2 p right join blockProduct2 b 
		on p.idx = b.productIdx  order by p.idx desc limit 1,10;
select o.*, p.*, 
select * 
from orderProduct2 o inner join product2 p on o.productIdx = p.idx
inner join user2 u on p.userIdx = u.idx
		
select * from product2 p RIGHT JOIN blockProduct2 b on p.idx = b.productIdx order by p.idx desc;		
--if(
--select TIMESTAMPDIFF(HOUR,(select date from product2 where idx = 2),CURRENT_TIMESTAMP()) > 24,
--(insert into readNum value(2,27)),
--'');

--case 
--	when select TIMESTAMPDIFF(hour(select rTime from readNum where productIdx = 2 and userIdx = 1),CURRENT_TIMESTAMP()) < 24
--	then update readNum set rTime = now()  where productIdx = 2 and userIdx = 1
--	else 

select rTime
(
case
 when select TIMESTAMPDIFF(HOUR,rtime,CURRENT_TIMESTAMP()) > 24 then update readNum set rTime = now()  where productIdx=1 and userIdx=1

 from readNum where productIdx=1 and userIdx=1
select count(*) from product2 
where title like "테헤란" or 
			address like "테헤란";

SELECT IF(IFNULL(rTime=0, 
(insert into readNum values(1,1,default)),
(update readNum set rTime = now() where productIdx=1 and userIdx=1)) 
from readNum where productIdx=1 and userIdx=1

select IF(IS NULL(rTime) from readNum where productIdx=1 and userIdx=2
insert into readNum values(1,1,default)
update readNum set rTime = now() where productIdx=1 and userIdx=1
select TIMESTAMPDIFF(HOUR,(select rTime from readNum where productIdx=1 and userIdx=1),CURRENT_TIMESTAMP()) as time,
(update readNum set(2,27)),
'');
 
select *
from orderProduct2 o inner join product2 p on o.productIdx = p.idx
inner join user2 u on p.userIdx = u.idx

select *, 
from orderProduct2 o inner join user2 u on o.sellerIdx = u.idx
inner join user2 u2 on o.buyerIdx = u2.idx 
inner join product2 p on p.idx = o.productIdx 

select * 
from orderProduct2 o inner join product2 p on o.productIdx = p.idx
inner join user2 u on p.userIdx = u.idx

select *, u.mid as sellerMid, u.name as sellerName, u.tel as sellerTel, u.email as sellerEmail 
, u2.mid as buyerMid, u2.name as buyerName, u2.tel as buyerTel, u2.email as buyerEmail
from orderProduct2 o inner join user2 u on o.sellerIdx = u.idx
inner join user2 u2 on o.buyerIdx = u2.idx 
inner join product2 p on p.idx = o.productIdx 

select DISTINCT(p.idx), p.title, s.name from product2 p, smallCategory2 s where p.smallIdx = 6
select p.*, s.name from product2 p, smallCategory2 s where p.smallIdx = 6 group by p.idx

select *, o.idx as orderIdx, u.mid as sellerMid, u.name as sellerName, u.tel as sellerTel, u.email as sellerEmail 
		, u2.mid as buyerMid, u2.name as buyerName, u2.tel as buyerTel, u2.email as buyerEmail
		from orderProduct2 o inner join user2 u on o.sellerIdx = u.idx
		inner join user2 u2 on o.buyerIdx = u2.idx 
		inner join product2 p on p.idx = o.productIdx 

SELECT
    CASE
        WHEN (select TIMESTAMPDIFF(HOUR,rtime,CURRENT_TIMESTAMP()) > 24) THEN (update readNum set rTime = now() where productIdx=1 and userIdx=2) 
        WHEN (select TIMESTAMPDIFF(HOUR,rtime,CURRENT_TIMESTAMP()) < 24) THEN "조회수증가 실패"
        ELSE insert insert into readNum values(1,2,default)
    END T
FROM readNum WHERE productIdx=1 and userIdx=2

select p.*,u.nickName from productReply2 as p,user2 as u where p.productIdx = 10 and u.idx = sIdx group by p.idx having p.idx = parentIdx;
select * from productReply2  where productIdx = 10 group by parentIdx having idx  
select * from productReply2 where productIdx = 10 order by field(productIdx,parentIdx = idx,idx)
select * from productReply2 where productIdx = 10

select p1.idx,p2.parentIdx from productReply2 p1 CROSS join productReply2 p2 on p1.idx = p2.parentIdx where p1.productIdx = 10
select p1.*, p2.* from productReply2 p1 CROSS join productReply2 p2 on p1.idx = p2.parentIdx and p1.idx < p2.idx where p1.productIdx = 10 order by p1.idx,p2.idx

select p1.*,p2.* from productReply2 p1 CROSS join productReply2 p2 where p1.productIdx = 10

select (select * from productReply2 where productIdx = 10) from productReply2 where productIdx = 10 order by idx;

SELECT LEAST(productIdx ,idx) FROM productReply2 where productIdx = 10;

select idx,(select parentIdx from productReply2 where productIdx = 10) from productReply2 where productIdx = 10
SELECT CASE WHEN idx >= parentIdx THEN idx END parentIdx
      ,CASE WHEN parentIdx >= idx THEN parentIdx END idx
  FROM productReply2 where productIdx = 10;

  show tables 
insert into readNum values(1,1,default)

select * from largeCategory2 l, midiumCategory2 m, smallCategory2 s where l.name = "여성의류" and m.name = "상의" or s.name = "상의"
select * from largeCategory2 where lName = "여성의류" or m.mName = "여성의류" or s.sName = "여성의류"
select p.* from largeCategory2 l join product2 p where l.largeIdx = 10

select * from product2 where largeIdx = 7
create table readNum ( 
	productIdx int not null,
	userIdx int not null,
	rTime datetime default now(),
	foreign key(productIdx) references user2(idx),
	foreign key(userIdx) references product2(idx)
)

create table user2 ( 
	idx int not null auto_increment primary key,
	mid varchar (20) not null unique,
	pwd varchar (120) not null,
	name varchar (20) not null,
	nickName varchar(20) not null,
	tel varchar (20) not null,
	email varchar(50) not null,
	address varchar(50) not null,
	joinday datetime default now(), 
	authority int default 1, 
	photo varchar(100) default 'noimage.jpg',
	content text
);
create table userBankAccount2 (
	userIdx int not null,
	idx int not null auto_increment primary key, 
	bankInfo varchar(20) not null,
	accountNumber varchar(20) not null,
	foreign key(userIdx) references user2(idx) on update cascade on delete cascade
);


create table userOut2(
	uIdx int,
	idx int not null auto_increment primary key,
	reason text not null,
	oDate datetime default now(), 
	foreign key(uIdx) references user2(idx) on update cascade on delete set null
);

select * from largeCategory2
create table largeCategory2 (
	largeIdx int not null auto_increment primary key,
	name varchar(20) unique
);

create table midiumCategory2 (
	largeIdx int not null,
	midiumIdx int not null auto_increment primary key,
	mName varchar(20) not null unique,
	foreign key(largeIdx) references largeCategory2(largeidx) on delete cascade
);
desc smallCategory2;
create table smallCategory2 (
	largeIdx int not null,
	midiumIdx int not null,
	smallIdx int not null auto_increment primary key,
	sName varchar(20) not null,
	foreign key(largeIdx) references largeCategory2(largeidx) on delete cascade,
	foreign key(midiumIdx) references midiumCategory2(midiumIdx) on delete cascade
);

insert into product2 values(#{vo.largeIdx},#{vo.midiumIdx},#{vo.smallIdx},#{vo.userIdx},default,#{vo.fName},#{vo.fSName},#{vo.title},#{vo.content},default,default,default,#{vo.address},#{vo.price},#{vo.hostIp);
insert into product2 values(7,7,6,1,default,"파일네임","파일시스템","타이틀","콘텐츠",default,default,default,"주소",20000,"hostip");
insert into product2 values(#{vo.})
select * from proudct2 where userIdx = 27;
select * from product2 where userIdx = 1 order by idx desc limit 1,5 ;
desc product2;
select p.* from product2 p,likes2 l where l.userIdx = 1 and l.productIdx = p.idx;
delete from product2 where idx = 30
DESC product2
DROP TABLE product2

select * from product2 where title like "%te%" or content like "%te%" or title="test"
select * from product2 where (title LIKE '%te%') OR (contents LIKE '%te%')
select * from product2 where concat(title,content,address) regexp "테스트";
select * from product2 where (title or content or address) like "%test%";


alter table product2 add state varchar(10) not null after exchange
alter table product2 change selling sell int default 0 

select o.*, p.* 
			from orderProduct2 o inner join product2 p
			on o.productIdx = p.idx
			where sellerIdx = 28
alter table product2 modify readNum selling int not null 
desc product2
create table product2 (
	largeIdx int,
	midiumIdx int,
	smallIdx int,  
    userIdx  int,		/* ��ǰ�� �ø������ idx */
	idx  int not null auto_increment primary key,	/* ��ǰ�� ������ȣ */
    fName varchar(200) not null,	/* ó�� ���ε��Ҷ��� ���ϸ� */
    fSName	varchar(200) not null,	/* ���ϼ����� ����Ǵ� �������ϸ� */
    title	varchar(100) not null,		/* �Խñ��� �� ���� */
    content	text not null,				/* �� ���� */
    date	datetime default now(),		/* �� �ø� ��¥ */
    sell	int default 0,				/* 판매중 0 판매완료 1 */
	address	varchar(50) not null,
	price 	int not null,
	hostIp  varchar(50) not null, 
	exchange varchar(10) not null, /* 교환가능 여부 */
	state varchar(10) not null,    /* 새상품 중고상품 여부 */
	foreign key(userIdx) references user2(idx) ON DELETE CASCADE,
	foreign key(largeIdx) references largeCategory2(largeIdx) ON UPDATE CASCADE ON DELETE SET NULL, 
	foreign key(midiumIdx) references midiumCategory2(midiumIdx) ON UPDATE CASCADE ON DELETE SET NULL,
	foreign key(smallIdx) references smallCategory2(smallIdx) ON UPDATE CASCADE ON DELETE SET NULL
);
drop table readCount2
create table readCount2 (
	produdctIdx int, 
	userIdx int,
	idx int not null auto_increment primary key,
	readDate datetime default now(),
	foreign key(produdctIdx) references product2(idx) ON UPDATE CASCADE ON DELETE CASCADE,
	foreign key(userIdx) references user2(idx) ON UPDATE CASCADE ON DELETE CASCADE
)

select l.name as lName, m.name as mName, s.name as sName, count(r.idx) as readCount
from smallCategory2 as s, midiumCategory2 as m, largeCategory2 as l, product2 as p,readCount2 as r 
where p.idx = 6 and s.smallIdx = p.smallIdx and m.midiumIdx = p.midiumIdx
and l.largeIdx = p.largeIdx and r.produdctIdx = p.idx;

select l.name as lName, m.name as mName, s.name as sName, count(r.idx) as readCount,p.*
		from smallCategory2 as s, midiumCategory2 as m, largeCategory2 as l, product2 as p,readCount2 r 
		where p.idx = 6 and s.smallIdx = p.smallIdx and m.midiumIdx = p.midiumIdx 
		and l.largeIdx = p.largeIdx and r.produdctIdx = p.idx;

SET foreign_key_checks = 0;
SET foreign_key_checks = 1;

ALTER TABLE product2 ADD CONSTRAINT FOREIGN KEY (smallIdx)
REFERENCES smallCategory2 (smallIdx) ON UPDATE CASCADE
ALTER TABLE product2 DROP FOREIGN KEY midiumIdx 


select * from productReply2 where productIdx = 25

select p.*,u.nickName from productReply2 as p,user2 as u where p.productIdx = 25 and u.idx = sIdx order by parentIdx,idx;
select p.* from productReply2 as p where p.productIdx = 25 order by idx;

insert into productReply2 values(25,default,27,default,default,"ip","content",default);
alter table productReply2 add deleteSwich int default 0;
desc productReply2
DROP TABLE productReply2
insert into productReply2 values(4,default,27,default,default,"ip","content",default);
update productReply2 set deleteSwich = 1 where sIdx = 27 and idx = 3;
desc productReply2
create table productReply2 (
	productIdx int not null,
	idx int not null auto_increment primary key,
	sIdx int not null,
  	parentIdx int not null default 0, 
  	rDate datetime default now(),
	hostIp   varchar(50) not null,
  	content text not null,
  	deleteSwitch int default 0,
	foreign key(productIdx) references product2(idx),
	foreign key(sIdx) references user2(idx)
);

drop table report2
create table reportProduct2 (
	reporterIdx int, /* 신고자 */
	userIdx int, /* 신고당한자 */
	productIdx int,
	idx int not null auto_increment primary key,
	reportType varchar(20) not null, 
	detail text,
	rDate datetime default now(),
	foreign key(reporterIdx) references user2(idx) on update cascade on delete set null,
	foreign key(userIdx) references user2(idx) on update cascade on delete set null,
	foreign key(productIdx) references product2(idx) on update cascade on delete set null
);

create table reportReply2 (
	reporterIdx int, /* 신고자 */
	userIdx int, /* 신고당한자 */
	replyIdx int,
	idx int not null auto_increment primary key,
	reportType varchar(20) not null, 
	detail text,
	rDate datetime default now(),
	foreign key(reporterIdx) references user2(idx) on update cascade on delete set null,
	foreign key(userIdx) references user2(idx) on update cascade on delete set null,
	foreign key(replyIdx) references productReply2(idx) on update cascade on delete set null
);


create table follow2 (
	followingIdx int not null,
	followerIdx int not null,
	foreign key(followingIdx) references user2(idx) on delete cascade,
	foreign key(followerIdx) references user2(idx) on delete cascade
);

drop table trading2
create table likes2 (
	userIdx	int not null,
	productIdx int not null,
	foreign key(userIdx) references user2(idx) on delete cascade,
	foreign key(productIdx) references product2(idx) on delete cascade	
);
DESC USER2
DROP TABLE trading2
create table trading2 (
	idx int not null auto_increment primary key,
	customerIdx int,
	productIdx int,
	date datetime default now(),
	foreign key(customerIdx) references user2(idx) ON DELETE SET NULL,
	foreign key(productIdx) references product2(idx) ON DELETE SET NULL
);

drop table updateInfo2
/* 유저정보 수정 일주일에 한번만 가능하게 (수정내역 저장?)*/
create table updateInfo2 (
	idx int not null auto_increment primary key,
	customerIdx int not null,
	date datetime default now(),
	foreign key(customerIdx) references user2(idx)
);
drop table blockProduct2
create table blockProduct2 (
	productIdx int not null,
	idx int not null auto_increment primary key,
	bDate datetime default now(),
	bContent text not null,
	foreign key(productIdx) references product2(idx)on delete cascade
	);
desc blockProduct2;
drop table blockProduct2;
alter table [blockProduct2] add constraint name foreign key productIdx references product2(idx) on delete cascade


ALTER TABLE [테이블 명] ADD CONSTRAINT [제약조건 이름] FOREIGN KEY(컬럼 명) REFERENCES [부모테이블 명](PK 컬럼 명) [ON DELETE CASCADE / ON UPDATE CASCADE];

create table userResign (
	userIdx,
	idx int not null auto_increment primary key,
	resignDate datetime default now(),
	foreign key(productIdx) references product2(idx) on update restrict on delete set null,
)

drop table orderProduct2
desc orderProduct2
		select o.*, p.* 
			from orderProduct2 o inner join product2 p
			on o.productIdx = p.idx
			where buyerIdx = 27
insert into orderProduct2 values(default,4,27,28,"아이디",default,"주소","우편번호","이메일","전화번호",10,default,default);
update orderProduct2 set deliveryStatus="test", deliveryDate=now() where idx=3;
desc orderProduct2

select count(DISTINCT u.joinday), count(DISTINCT p.Date)
from user2 u, product2 p
where u.joinday, p.Date
between date("2022-01-01") and date("2022-08-02")+1 

select DISTINCT u.joinday, p.Date
from user2 u, product2 p
where u.joinday, p.Date
between date("2022-01-01") and date("2022-08-02")+1 

select o.orderDate AND u.joinday AND p.Date AND r.rDate 
from user2 u, product2 p, orderProduct2 o, productReply2 r
where between date("2022-01-01") and date("2022-08-02")+1 group by

select o.orderDate, u.joinday
from orderProduct2 o, user2 u
where o.orderDate and u.joinday
between date("2022-01-01") and date("2022-08-02")+1 group by o.orderDate, u.joinday

select a.oc, b.uc, c.pc, d.rc
from 
(select count(*) oc from orderProduct2 where orderDate between date("2022-01-01") and date("2022-08-02")+1) a,
(select count(*) uc from user2 where joinday between date("2022-01-01") and date("2022-08-02")+1) b,
(select count(*) pc from product2 where Date between date("2022-01-01") and date("2022-08-02")+1) c,
(select count(*) rc from productReply2 where rDate between date("2022-01-01") and date("2022-08-02")+1) d



select count(u.joinday) as uc, count(o.orderDate) as oc, count(p.Date) as pc, count(r.rDate) as rc
from user2 u, product2 p, orderProduct2 o, productReply2 r
where o.orderDate AND u.joinday AND p.Date AND r.rDate 

(select count(*) from user2 where joinday
between date("2022-01-01") and date("2022-08-02")+1) as uc
UNION
(select count(*) from product2 where Date
between date("2022-01-01") and date("2022-08-02")+1) as pc



select count(*) as pc from product2 where Date between date("2022-01-01") and date("2022-08-02")+1
select count(*) as uc from user2 where joinday between date("2022-01-01") and date("2022-08-02")+1
select count(*) as oc from orderProduct2 where orderDate between date("2022-01-01") and date("2022-08-02")+1
select count(*) as rc from productReply2 where rDate  between date("2022-01-01") and date("2022-08-02")+1

select count(case where joinday between date("2022-01-01") and date("2022-08-02")+1) then 1 end) from user2 as uc


create table orderProduct2 (
	idx int not null auto_increment primary key,
	productIdx int,
	sellerIdx int,
	buyerIdx int,
	name varchar (20) not null,
	orderDate datetime default now(),
	address varchar(50) not null,
	postcode varchar(20) not null,	
	email varchar(50) not null,
	tel varchar (20) not null,
	price int not null,
	deliveryStatus varchar(20) not null default "주문확인중", 
	deliveryRequire varchar(30) default "없음",
	deliveryDate datetime,
	foreign key(productIdx) references product2(idx) on update cascade on delete SET NULL,
	foreign key(sellerIdx) references user2(idx) on update cascade on delete SET NULL,
	foreign key(buyerIdx) references user2(idx) on update cascade on delete SET NULL 
)
drop table cancelReason
create table cancelReason2 (
	idx int not null auto_increment primary key,
	productIdx int,
	sellerIdx int,
	buyerIdx int,
	reason text not null,
	foreign key(productIdx) references product2(idx) on update cascade on delete SET NULL,
	foreign key(sellerIdx) references user2(idx) on update cascade on delete SET NULL,
	foreign key(buyerIdx) references user2(idx) on update cascade on delete SET NULL 
)

select count(*) from user2 where between date(#{datepicker1}) and date(#{datepicker2})+1
references product2(idx)   

insert into update2 values(default,1,default);
update if(TIMESTAMPDIFF(info.date,now()) < 7, ) updateInfo2 info,user2 us set 업데이트할 내용들

where info.customerIdx = 1; 

update updateInfo2 info,user2 us, if TIMESTAMPDIFF(date, now()) > 7;
set 

TIMESTAMPDIFF(day, date) from updateInfo2 

CASE WHEN TIMESTAMPDIFF(date, now()) then
 
select * from user2
select * from updateInfo2
insert into updateInfo2 values(default,1,default);
drop table updateInfo2;

select if(TIMESTAMPDIFF())

update user2,updateInfo2 set user2.name ="test",updateInfo2.date = now() where user2.idx=1
if(TIMESTAMPDIFF(updateInfo2.date,now()) < 7, )

select modiDate from updateInfo2 where customerIdx = (select idx from user2 where mid = "admin") 
insert into update2 values(default,1,default);
update if(TIMESTAMPDIFF(info.date,now()) < 7, ) updateInfo2 info,user2 us set 업데이트할 내용들

where info.customerIdx = 1; 

update updateInfo2 info,user2 us, if TIMESTAMPDIFF(date, now()) > 7;
set 

TIMESTAMPDIFF(day, date) from updateInfo2 

CASE WHEN TIMESTAMPDIFF(date, now()) then

select modiDate from updateInfo2;

/* ��ǰ ���� ���� 신고당한 유저 블락처리*/

/*  상품 블락처리상태 공개상태*/
