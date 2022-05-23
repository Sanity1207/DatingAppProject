--fk 두 개를 같은 COLUMN 으로 가져올 수 있나 테스트.

CREATE TABLE sqltest(
	usernum number(10) PRIMARY KEY,
	userid varchar(300) NOT NULL,
	username varchar(300)
);

INSERT INTO sqltest VALUES (2,'abc1231234', '1113421');

CREATE TABLE sqltest1(
	testnumber number(10) PRIMARY KEY,
	col1 number(10) NOT NULL,
	col2 number(10) NOT NULL,
	col3 varchar(300) NOT NULL,
	col4 varchar(300),
	CONSTRAINT fk_test_test1_col1 FOREIGN KEY(col1)
	REFERENCES sqltest(usernum) ON DELETE CASCADE, 
	CONSTRAINT fk_test_test1_col2 FOREIGN KEY(col2)
	REFERENCES sqltest(usernum) ON DELETE CASCADE	
)

--가져올 수 있따.


