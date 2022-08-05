# 송학관의 JSP 프로젝트

``` sql
DROP SEQUENCE BOOK_MEMBER_SEQ;
CREATE SEQUENCE BOOK_MEMBERS_SEQ
START WITH 1
INCREMENT BY 1
MINVALUE 1;

DROP TABLE BOOK_MEMBERS;
CREATE TABLE BOOK_MEMBERS (
	MCODE		NUMBER PRIMARY KEY,
	ID			VARCHAR2(15),
	PWD			VARCHAR2(10),
	NAME		VARCHAR2(20),
	BIRTH		DATE,
	GENDER		VARCHAR2(6),
	EMAIL		VARCHAR2(40),
	PHONE		VARCHAR2(11),
	REG_DATE	DATE
);

SELECT * FROM BOOK_CATEGORY;
```

``` sql
DROP TABLE BOOK_CATEGORY;
CREATE TABLE BOOK_CATEGORY (
	CATECODE	VARCHAR2(10) PRIMARY KEY,
	CATEGROUP	VARCHAR2(10),
	CATENAME	VARCHAR2(30),
	REG_DATE	DATE DEFAULT SYSDATE
);

SELECT * FROM BOOK_CATEGORY;
```

``` sql
CREATE SEQUENCE BOOK_PRODUCTS_SEQ
START WITH 1
INCREMENT BY 1
MINVALUE 1;

DROP TABLE BOOK_PRODUCTS;
CREATE TABLE BOOK_PRODUCTS (
	PCODE		NUMBER PRIMARY KEY,
	TITLE		VARCHAR2(50),
	AUTHOR		VARCHAR2(20),
	CONTENT		VARCHAR2(4000),
	PUBLISHER	VARCHAR2(20),
	ISBN		VARCHAR2(30),
	IDX		VARCHAR2(200),
	QTY			NUMBER,
	PRICE		NUMBER,
	SALE		NUMBER,
	CATECODE	VARCHAR2(20),
	IMAGE		VARCHAR2(50),
	PUB_DATE	DATE,
	REG_DATE	DATE DEFAULT SYSDATE
);
```

``` sql
DROP TABLE BOOK_CART;
CREATE TABLE BOOK_CART (
	CCODE		VARCHAR2(20) PRIMARY KEY,
	MCODE		NUMBER,
	REG_DATE	DATE DEFAULT SYSDATE
);

DROP TABLE BOOK_CART_DETAIL;
CREATE TABLE BOOK_CART_DETAIL (
	PCODE		NUMBER,
	QTY			NUMBER,
	CCODE		VARCHAR2(20),
	REG_DATE	DATE DEFAULT SYSDATE
)
```

``` sql
CREATE OR REPLACE PROCEDURE INERT_CART_DETAIL
(
	VPCODE BOOK_PRODUCTS.PCODE%TYPE,
	VQTY BOOK_CART_DETAIL.QTY%TYPE,
	VCCODE BOOK_CART.CCODE%TYPE,
	VMCODE BOOK_MEMBERS.MCODE%TYPE
)
IS
	NUM NUMBER := 0;
BEGIN
	IF VMCODE = -1 THEN
		SELECT COUNT(*) INTO NUM
		FROM BOOK_CART_DETAIL
		WHERE CCODE = VCCODE
		AND PCODE = VPCODE;
	ELSE
		SELECT COUNT(*) INTO NUM
		FROM BOOK_CART_DETAIL C
		INNER JOIN BOOK_CART C2
		ON C.CCODE = C2.CCODE
		WHERE C.PCODE = VPCODE
		AND C2.MCODE = VMCODE;
	END IF;
	
	IF NUM = 0 THEN
		INSERT INTO BOOK_CART_DETAIL (PCODE, MOCDE, QTY, CCODE, REG_DATE) VALUES (VPCODE, VMCODE, VQTY, VCCODE, SYSDATE);
	ELSE
		IF VMCODE = -1 THEN
			UPDATE BOOK_CART_DETAIL SET QTY = VQTY WHERE CCODE = VCCODE AND PCODE = VPCODE;
		ELSE
			UPDATE BOOK_CART_DETAIL SET QTY = VQTY WHERE PCODE = VPCODE AND MOCDE = VMCODE;
		END IF;
	END IF;
END;

DROP PROCEDURE MERGE_CART;
CREATE OR REPLACE PROCEDURE MERGE_CART
(
	VMCODE BOOK_MEMBERS.MCODE%TYPE,
	VCCODE BOOK_CART.CCODE%TYPE
)
IS
	VPCODE BOOK_PRODUCTS.PCODE%TYPE := 0;
BEGIN
	FOR F1 IN (SELECT * FROM BOOK_CART_DETAIL WHERE CCODE = VCCODE AND MCODE = -1) LOOP
		BEGIN
			SELECT PCODE INTO VPCODE FROM BOOK_CART_DETAIL WHERE MCODE = VMCODE AND PCODE = F1.PCODE;
			
			EXCEPTION
				WHEN NO_DATA_FOUND THEN VPCODE = 0;
		END;
		
		IF VPCODE = 0 THEN
			UPDATE BOOK_CART_DETAIL SET MCODE = VMCODE WHERE CCODE = VCCODE AND MCODE = -1;
		ELSE
			DELETE FROM BOOK_CART_DETAIL WHERE CCODE = VCCODE AND MCODE = -1;
		END IF;
	END LOOP;
END;
```
