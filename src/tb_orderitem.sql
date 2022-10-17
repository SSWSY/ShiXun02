-- 1.将图 1.3.4 给出的测试数据集插入到对应的数据表中
CREATE DATABASE db_store;

USE db_store;

CREATE TABLE IF NOT EXISTS tb_orderitem(
   `itemId` INT NOT NULL,
   `orderQuntit` VARCHAR(255) NOT NULL,
   `unitPrice` INT NOT NULL,
   `orderId` INT NOT NULL,
   `goodsId` INT NOT NULL,
   PRIMARY KEY ( `itemId` )
)ENGINE=INNODB DEFAULT CHARSET=utf8;

INSERT INTO tb_orderitem (itemId,orderQuntit,unitPrice,orderId,goodsId)
VALUES(1001,1300,30,2001,3001),
      (1002,1800,50,2002,3002),
      (1003,10000,100,2003,3003),
      (1004,100,190,2004,3004),
      (1005,30,150,2005,3005);
      
 SELECT *FROM tb_orderitem;
 
-- 2.向 tb_orderitem 表插入数据："1006，1500, 880，2006,3006"
 
 INSERT INTO tb_orderitem (itemId,orderQuntit,unitPrice,orderId,goodsId)
 VALUES(1006,1500,880,2006,3006);
 
-- 3.查询订购数量大于 1000 的所有订单明细信息，要求输出明细编号、订购数量、单价和商品编号 
 
 SELECT itemID AS 明细编号,orderQuntit AS 订购数量,unitPrice AS 单价,goodsId AS 商品编号 FROM tb_orderitem WHERE orderQuntit > 1000;
 
-- 4.统计订单单价大于 80 且订购数量也大于 80 的订单数，要求输出该订单数 
 
 SELECT orderQuntit AS 订购数量 FROM tb_orderitem WHERE unitPrice >80 AND orderQuntit >80;
 
 -- 5.查询订购数量按从大到小排列的第 3 条至第 5 条订单明细信息，要求输出明细编号、订购数量、单价和商品编号
 
 SELECT itemId,orderQuntit,unitPrice,goodsId FROM tb_orderitem ORDER BY orderQuntit ASC LIMIT 3,4;
 
 -- 6.将订单编号‚2002‛、‚2004‛分别改为‚2001‛、‚2003‛，
 
 UPDATE tb_orderitem
SET orderId =
        CASE orderId
            WHEN 2002 THEN 2001
            WHEN 2004 THEN 2003
            END
WHERE orderId IN (2002,2004);

-- 7.查询各类订单总的订购数量、平均订购数量，要求输出订单编号、订购总数和平均订购数

SELECT orderId,SUM(orderQuntit) AS 订购总数,AVG(orderQuntit) AS 平均订购数 FROM tb_orderitem GROUP BY orderId;

-- 8.查询订购数量高于订单编号为‚2001‛的最小订购数量的订单信息，要求输出订单编号、订购数量

SELECT orderId,orderQuntit FROM tb_orderitem WHERE orderQuntit>(SELECT MIN(orderQuntit) FROM tb_orderitem WHERE orderId=2001);

-- 9.查询某订单的单价高于其他订单的最高单价的该订单信息，要求输出订单编号、单价

SELECT orderId,unitPrice FROM tb_orderitem WHERE unitPrice = (SELECT MAX(unitPrice) FROM tb_orderitem WHERE unitPrice);

-- 10.查询最热销商品和最滞销商品的相关信息，要求输出商品编号、订购数量，并按商品编号降序显示

SELECT goodsId,orderQuntit FROM tb_orderitem WHERE orderQuntit=(SELECT MAX(CONVERT(orderQuntit,SIGNED)) FROM tb_orderitem) UNION ALL SELECT goodsId,orderQuntit FROM tb_orderitem WHERE orderQuntit=(SELECT MIN(CONVERT(orderQuntit,SIGNED)) FROM tb_orderitem);
