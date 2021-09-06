CREATE TABLE Warehouse_Read (
    W_ID INTEGER, 
    W_NAME VARCHAR(10), 
    W_STREET_1 VARCHAR(20), 
    W_STREET_2 VARCHAR(20), 
    W_CITY VARCHAR(20), 
    W_STATE CHAR(2), 
    W_ZIP CHAR(9), 
    W_TAX DECIMAL(4, 4), 
    -- W_YTD DECIMAL(12, 2), 
    PRIMARY KEY (W_ID)
);

"""
Requirements: 

W_YTD: 
(2.2) Update the warehouse C_W_ID by incrementing W_YTD by PAYMENT
"""
CREATE TABLE Warehouse_Write (
    W_ID INTEGER, 
    -- W_NAME VARCHAR(10), 
    -- W_STREET_1 VARCHAR(20), 
    -- W_STREET_2 VARCHAR(20), 
    -- W_CITY VARCHAR(20), 
    -- W_STATE CHAR(2), 
    -- W_ZIP CHAR(9), 
    -- W_TAX DECIMAL(4, 4), 
    W_YTD DECIMAL(12, 2), 
    PRIMARY KEY (W_ID)
);

CREATE TABLE District_Read (
    D_W_ID INTEGER, 
    D_ID INTEGER, 
    D_STREET_1 VARCHAR(20), 
    D_STREET_2 VARCHAR(20), 
    D_CITY VARCHAR(20), 
    D_STATE CHAR(2), 
    D_ZIP CHAR(9), 
    D_TAX DECIMAL(4, 4), 
    -- D_YTD DECIMAL(12, 2), 
    -- D_NEXT_O_ID INTEGER, 
    PRIMARY KEY (D_W_ID, D_ID), 
    FOREIGN KEY D_ID REFERENCES Warehouse
);

"""
Requirements: 

D_YTD: 
(2.2) Update the warehouse (C_W_ID, C_D_ID) by incrementing D_YTD by PAYMENT 

D_NEXT_O_ID: 
(2.1) Update the district (W_ID, D_ID) by incrementing D_NEXT_O_ID by one
"""
CREATE TABLE District_Write (
    D_W_ID INTEGER, 
    D_ID INTEGER, 
    -- D_STREET_1 VARCHAR(20), 
    -- D_STREET_2 VARCHAR(20), 
    -- D_CITY VARCHAR(20), 
    -- D_STATE CHAR(2), 
    -- D_ZIP CHAR(9), 
    -- D_TAX DECIMAL(4, 4), 
    D_YTD DECIMAL(12, 2), 
    D_NEXT_O_ID INTEGER, 
    PRIMARY KEY (D_W_ID, D_ID), 
    FOREIGN KEY D_ID REFERENCES Warehouse
);

CREATE TABLE Customer_Read (
    C_W_ID INTEGER, 
    C_D_ID INTEGER, 
    C_ID INTEGER, 
    C_FIRST VARCHAR(16), 
    C_MIDDLE CHAR(2), 
    C_LAST VARCHAR(16), 
    C_STREET_1 VARCHAR(20), 
    C_STREET_2 VARCHAR(20), 
    C_CITY VARCHAR(20), 
    C_STATE CHAR(2), 
    C_ZIP CHAR(9), 
    C_PHONE CHAR(16), 
    C_SINCE TIMESTAMP, 
    C_CREDIT CHAR(2), 
    C_CREDIT_LIM DECIMAL(12, 2), 
    C_DISCOUNT DECIMAL(4, 4), 
    -- C_BALANCE DECIMAL(12, 2), 
    -- C_YTD_PAYMENT FLOAT, 
    -- C_PAYMENT_CNT INT, 
    -- C_DELIVERY_CNT INT, 
    -- C_DATA VARCHAR(500)
    PRIMARY KEY (C_W_ID, C_D_ID, C_ID), 
    FOREIGN KEY (C_W_ID, C_D_ID) REFERENCES District
);


"""
Requirements: 

C_BALANCE:
(2.2) Decrement C_BALANCE by PAYMENT
(2.3) Increment C_BALANCE by B, where B denote the sum of OL_AMOUNT for all the
items placed in order X

C_YTD_PAYMENT: 
(2.2) Increment C_YTD_PAYMENT by PAYMENT

C_PAYMENT_CNT: 
(2.2) Increment C_PAYMENT_CNT by 1

C_DELIVERY_CNT: 
(2.3) Increment C_DELIVERY_CNT by 1
"""
CREATE TABLE Customer_Write (
    C_W_ID INTEGER, 
    C_D_ID INTEGER, 
    C_ID INTEGER, 
    -- C_FIRST VARCHAR(16), 
    -- C_MIDDLE CHAR(2), 
    -- C_LAST VARCHAR(16), 
    -- C_STREET_1 VARCHAR(20), 
    -- C_STREET_2 VARCHAR(20), 
    -- C_CITY VARCHAR(20), 
    -- C_STATE CHAR(2), 
    -- C_ZIP CHAR(9), 
    -- C_PHONE CHAR(16), 
    -- C_SINCE TIMESTAMP, 
    -- C_CREDIT CHAR(2), 
    -- C_CREDIT_LIM DECIMAL(12, 2), 
    -- C_DISCOUNT DECIMAL(4, 4), 
    C_BALANCE DECIMAL(12, 2), 
    C_YTD_PAYMENT FLOAT, 
    C_PAYMENT_CNT INT, 
    C_DELIVERY_CNT INT, 
    -- C_DATA VARCHAR(500)
    PRIMARY KEY (C_W_ID, C_D_ID, C_ID), 
    FOREIGN KEY (C_W_ID, C_D_ID) REFERENCES District
);

"""
Requirements: 

C_DATA: 
Not used in ANY Transaction 
"""
CREATE TABLE Customer_Misc (
    C_W_ID INTEGER, 
    C_D_ID INTEGER, 
    C_ID INTEGER, 
    -- C_FIRST VARCHAR(16), 
    -- C_MIDDLE CHAR(2), 
    -- C_LAST VARCHAR(16), 
    -- C_STREET_1 VARCHAR(20), 
    -- C_STREET_2 VARCHAR(20), 
    -- C_CITY VARCHAR(20), 
    -- C_STATE CHAR(2), 
    -- C_ZIP CHAR(9), 
    -- C_PHONE CHAR(16), 
    -- C_SINCE TIMESTAMP, 
    -- C_CREDIT CHAR(2), 
    -- C_CREDIT_LIM DECIMAL(12, 2), 
    -- C_DISCOUNT DECIMAL(4, 4), 
    -- C_BALANCE DECIMAL(12, 2), 
    -- C_YTD_PAYMENT FLOAT, 
    -- C_PAYMENT_CNT INT, 
    -- C_DELIVERY_CNT INT, 
    C_DATA VARCHAR(500)
    PRIMARY KEY (C_W_ID, C_D_ID, C_ID), 
    FOREIGN KEY (C_W_ID, C_D_ID) REFERENCES District
);


CREATE TABLE Order_Read (
    O_W_ID INTEGER, 
    O_D_ID INTEGER, 
    O_ID INTEGER, 
    O_C_ID INTEGER, 
    -- O_CARRIER_ID INTEGER, 
    O_OL_CNT DECIMAL(2, 0), 
    O_ALL_LOCAL DECIMAL(1, 0), -- True or False 
    O_ENTRY_ID TIMESTAMP
    PRIMARY KEY (O_W_ID, O_D_ID, O_ID), 
    FOREIGN KEY (O_W_ID, O_D_ID, O_C_ID) REFERENCES Customer, 
    -- CHECK O_CARRIER_ID >= 1 AND O_CARRIER_ID <= 10
);

"""
Requirements: 

O_CARRIER_ID: 
(2.3) Update the order X by setting O CARRIER ID to CARRIER ID
"""
CREATE TABLE Order_Write (
    O_W_ID INTEGER, 
    O_D_ID INTEGER, 
    O_ID INTEGER, 
    O_C_ID INTEGER, 
    O_CARRIER_ID INTEGER, 
    -- O_OL_CNT DECIMAL(2, 0), 
    -- O_ALL_LOCAL DECIMAL(1, 0), -- True or False 
    -- O_ENTRY_ID TIMESTAMP
    PRIMARY KEY (O_W_ID, O_D_ID, O_ID), 
    FOREIGN KEY (O_W_ID, O_D_ID, O_C_ID) REFERENCES Customer, 
    CHECK O_CARRIER_ID >= 1 AND O_CARRIER_ID <= 10
);

CREATE TABLE Item_Read (
    I_ID INTEGER, 
    I_NAME VARCHAR(24), 
    I_PRICE DECIMAL(5, 2), 
    -- I_IM_ID INTEGER, 
    -- I_DATA VARCHAR(50), 
    PRIMARY KEY (I_ID)
);

"""
Requirements: 

I_IM_ID: 
Not used in ANY Transaction 

I_DATA: 
Not used in ANY Transaction 
"""
CREATE TABLE Item_Misc (
    I_ID INTEGER, 
    -- I_NAME VARCHAR(24), 
    -- I_PRICE DECIMAL(5, 2), 
    I_IM_ID INTEGER, 
    I_DATA VARCHAR(50), 
    PRIMARY KEY (I_ID)
);

CREATE TABLE OrderLine_Read (
    OL_W_ID INTEGER, 
    OL_D_ID INTEGER,
    OL_O_ID INTEGER,
    OL_NUMBER INTEGER, 
    OL_I_ID INTEGER, 
    -- OL_DELIVERY_D TIMESTAMP, 
    OL_AMOUNT DECIMAL(6, 2), 
    OL_SUPPLY_W_ID INTEGER, 
    OL_QUANTITY DECIMAL(2, 0), 
    OL_DIST_INFO CHAR(24)
    PRIMARY KEY (OL_W_ID, OL_D_ID, OL_O_ID, OL_NUMBER), 
    FOREIGN KEY (OL_W_ID, OL_D_ID, OL_O_ID) REFERENCES Order, 
    FOREIGN KEY (OL_I_ID) REFERENCES Item, 
);


"""
Requirements: 

OL_DELIVERY_D:
(2.3) Update all the order-lines in X by setting OL DELIVERY D to the current date and time
"""
CREATE TABLE OrderLine_Write (
    OL_W_ID INTEGER, 
    OL_D_ID INTEGER,
    OL_O_ID INTEGER,
    OL_NUMBER INTEGER, 
    OL_I_ID INTEGER, 
    OL_DELIVERY_D TIMESTAMP, 
    -- OL_AMOUNT DECIMAL(6, 2), 
    -- OL_SUPPLY_W_ID INTEGER, 
    -- OL_QUANTITY DECIMAL(2, 0), 
    -- OL_DIST_INFO CHAR(24)
    PRIMARY KEY (OL_W_ID, OL_D_ID, OL_O_ID, OL_NUMBER), 
    FOREIGN KEY (OL_W_ID, OL_D_ID, OL_O_ID) REFERENCES Order, 
    FOREIGN KEY (OL_I_ID) REFERENCES Item, 
);

"""
Requirements: 

S_QUANTITY: 
Update S QUANTITY to ADJUSTED QTY

S_YTD:
Increment S YTD by QUANTITY[i]

S_ORDER_CNT: 
Increment S ORDER CNT by 1

S_REMOTE_CNT: 
Increment S REMOTE CNT by 1 if SUPPLIER WAREHOUSE[i] =/= W ID
"""
CREATE TABLE Stock_Write (
    S_W_ID INTEGER, 
    S_I_ID INTEGER, 
    S_QUANTITY DECIMAL(4, 0), 
    S_YTD DECIMAL(8, 2), 
    S_ORDER_CNT INTEGER, 
    S_REMOTE_CNT INTEGER, 
    -- S_DIST_01 CHAR(24), 
    -- S_DIST_02 CHAR(24), 
    -- S_DIST_03 CHAR(24),
    -- S_DIST_04 CHAR(24), 
    -- S_DIST_05 CHAR(24), 
    -- S_DIST_06 CHAR(24), 
    -- S_DIST_07 CHAR(24), 
    -- S_DIST_08 CHAR(24), 
    -- S_DIST_09 CHAR(24), 
    -- S_DIST_10 CHAR(24),
    -- S_DATA VARCHAR(50), 
    PRIMARY KEY (S_W_ID, S_I_ID), 
    FOREIGN KEY (S_W_ID) REFERENCES Warehouse, 
    FOREIGN KEY (S_I_ID) REFERENCES Item
);

"""
Requirements: 

S_DIST_XX: 
Not used in ANY Transaction 

S_DATA: 
Not used in ANY Transaction 
"""
CREATE TABLE Stock_Misc (
    S_W_ID INTEGER, 
    S_I_ID INTEGER, 
    -- S_QUANTITY DECIMAL(4, 0), 
    -- S_YTD DECIMAL(8, 2), 
    -- S_ORDER_CNT INTEGER, 
    -- S_REMOTE_CNT INTEGER, 
    S_DIST_01 CHAR(24), 
    S_DIST_02 CHAR(24), 
    S_DIST_03 CHAR(24),
    S_DIST_04 CHAR(24), 
    S_DIST_05 CHAR(24), 
    S_DIST_06 CHAR(24), 
    S_DIST_07 CHAR(24), 
    S_DIST_08 CHAR(24), 
    S_DIST_09 CHAR(24), 
    S_DIST_10 CHAR(24),
    S_DATA VARCHAR(50), 
    PRIMARY KEY (S_W_ID, S_I_ID), 
    FOREIGN KEY (S_W_ID) REFERENCES Warehouse, 
    FOREIGN KEY (S_I_ID) REFERENCES Item
);
