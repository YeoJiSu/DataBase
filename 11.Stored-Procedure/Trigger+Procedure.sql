use HW5;
-- 1번 수행(eer modeling에서 s1~s9, p1~p9 넣었음.)
select * from s;
select * from p;

-- 2번 수행
DELIMITER $$
CREATE TRIGGER `after_sp_insert`
AFTER INSERT ON `sp`
FOR EACH ROW
BEGIN
	DECLARE existing_qty INT;
    SELECT currentQty INTO existing_qty FROM stock WHERE pno = NEW.pno;
    
    IF existing_qty IS NULL THEN
		-- 만약, stock테이블에 없는 행이 sp 테이블로 들어온 것이라면, stock 테이블에 값을 넣어준다. 
        INSERT INTO stock (pno, currentQty, stockDate) VALUES (NEW.pno, NEW.qty, NEW.supplyDate);
    ELSE
        -- 만약, stock테이블에 이미 존재하는 행이라면, stock 테이블의 qty와 date를 업데이트한다. 
        UPDATE stock SET currentQty = existing_qty + NEW.qty, stockDate = NEW.supplyDate WHERE pno = NEW.pno;
    END IF;
END $$

-- 20개의 예시 데이터 삽입
INSERT INTO sp (sno, pno, qty, supplyDate) 
VALUES
('s5', 'p5', 12, '2022-12-01'),
('s6', 'p6', 5, '2022-12-02'),
('s7', 'p7', 18, '2022-12-03'),
('s8', 'p8', 7, '2022-12-04'),
('s9', 'p9', 11, '2022-12-05'),
('s1', 'p1', 14, '2022-12-06'),
('s2', 'p3', 9, '2022-12-07'),
('s3', 'p4', 6, '2022-12-08'),
('s4', 'p5', 22, '2022-12-09'),
('s5', 'p9', 13, '2022-12-10'),
('s6', 'p2', 16, '2022-12-11'),
('s7', 'p3', 10, '2022-12-12'),
('s8', 'p4', 25, '2022-12-13'),
('s9', 'p5', 8, '2022-12-14'),
('s4', 'p6', 17, '2022-12-15'),
('s5', 'p8', 19, '2022-12-16'),
('s4', 'p4', 8, '2023-11-23'),
('s3', 'p3', 20, '2023-11-24'),
('s2', 'p1', 30, '2023-11-25'),
('s1', 'p1', 30, '2023-11-26');

-- 3번 수행
DELIMITER $$
CREATE TRIGGER `after_order_insert`
AFTER INSERT ON `order`
FOR EACH ROW
BEGIN
    DECLARE p_currentQty INT;
    DECLARE p_salesQty INT;
    
    -- order 테이블에 값이 insert되면, order 테이블의 currentQty 값 저장.
    SELECT currentQty INTO p_currentQty FROM stock WHERE pno = NEW.pno;
    
    -- 만약, 주문량 <= 제공량
    IF NEW.orderQty <= p_currentQty THEN
        
        -- sale 테이블에 해당 pno 행이 있는지 확인하기.
        SELECT salesQty INTO p_salesQty FROM sale WHERE pno = NEW.pno;

        IF p_salesQty IS NULL THEN
            -- sale 테이블에 해당 pno 값이 없다면, sale 테이블에 값을 집어넣기.
            INSERT INTO sale (pno, salesQty, salesDate) VALUES (NEW.pno, NEW.orderQty, NEW.orderDate);
        ELSE
            -- 만약 sale테이블에 해당 pno 값이 이미 있다면, 판매 테이블 qty를 update하기.
            UPDATE sale SET salesQty = p_salesQty + NEW.orderQty WHERE pno = NEW.pno;
        END IF;

        -- 이후, stock 테이블의 qty를 update하기.
        UPDATE stock SET currentQty = p_currentQty - NEW.orderQty WHERE pno = NEW.pno;
    
    -- 만약, 주문량 > 제공량
    ELSE
        -- 주문 취소 테이블에 값 입력 ( 주문 날 바로 취소되는 셈이니 cancelDate에 orderDate 값을 그대로 넣는다.)
        INSERT INTO orderCancel (ono, pno, orderQty, orderDate, cancelDate) VALUES (NEW.ono, NEW.pno, NEW.orderQty, NEW.orderDate,  NEW.orderDate);
    END IF;
END $$

-- 주문량 <= 제공량 이면서 새로운 예시 데이터 삽입
INSERT INTO `order` (ono, pno, orderQty, orderDate) VALUES
('o1','p1',20,'2023-11-26'),
('o2','p2',15,'2023-11-26');

-- 주문량 <= 제공량 이면서 이미 판매된 제품에 대한 주문
INSERT INTO `order` (ono, pno, orderQty, orderDate) VALUES
('o3','p1',20,'2023-11-26');

-- 주문량 > 제공량 데이터 삽입
INSERT INTO `order` (ono, pno, orderQty, orderDate) VALUES
('o4','p5',50,'2023-11-26');

-- 4번 수행
DELIMITER $$
CREATE TRIGGER `after_order_delete`
AFTER DELETE ON `order`
FOR EACH ROW
BEGIN
    -- orderCancel 테이블에 값을 insert한다. (delete한 현재 시점을 cancelDate로 넣는다.)
    INSERT INTO orderCancel (ono, pno, orderQty, orderDate, cancelDate)
    VALUES (OLD.ono, OLD.pno, OLD.orderQty, OLD.orderDate, curdate());
    
    -- [판매 취소]sale 테이블 행에서 salesQty = salesQty - orderQty로 update
    UPDATE sale SET salesQty = salesQty - OLD.orderQty WHERE pno = OLD.pno;
    
    -- [재고 다시 쌓기]stock 테이블 행에서 currentQty = currentQty + orderQty로 update
    UPDATE stock SET currentQty = currentQty + OLD.orderQty WHERE pno = OLD.pno;
END $$
DELIMITER ;

-- order delete 수행
DELETE FROM `order`
WHERE ono = 'o1' AND pno = 'p1' AND orderQty = 20 AND orderDate = '2023-11-26';

-- 5번 수행
select * from `s`;
select * from `p`;
select * from `sp`;
select * from `order`;
select * from `orderCancel`;
select * from `sale`;
select * from `stock`;

-- 6번 수행
DELIMITER $$
CREATE PROCEDURE InsertOrderAndSelectTables(
    IN p_ono char(10),
    IN p_pno char(10),
    IN p_orderQty INT,
    IN p_orderDate DATE
)
BEGIN
    -- Insert into order table
    INSERT INTO `order` (ono, pno, orderQty, orderDate)
    VALUES (p_ono, p_pno, p_orderQty, p_orderDate);

    -- Select from s table
    SELECT * FROM s;

    -- Select from p table
    SELECT * FROM p;

    -- Select from sp table
    SELECT * FROM sp;

	-- Select from order table
    SELECT * FROM `order`;
    
    -- Select from stock table
    SELECT * FROM stock;

    -- Select from sale table
    SELECT * FROM sale;
    
    -- Select from orderCancel table
    SELECT * FROM orderCancel;
END $$
DELIMITER ;

-- 프로시져 실행하기
call InsertOrderAndSelectTables('o8','p7',4,curdate());