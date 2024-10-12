use bankingsector;


CREATE TABLE Branches (
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR(50),
    Location VARCHAR(100)
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    BranchID INT,
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);

CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    CustomerID INT,
    AccountType VARCHAR(20),
    Balance DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    AccountID INT,
    TransactionType VARCHAR(20),
    Amount DECIMAL(10, 2),
    TransactionDate DATE,
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    CustomerID INT,
    LoanAmount DECIMAL(10, 2),
    LoanType VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    BranchID INT,
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);


select * from Branches;
INSERT INTO Branches VALUES
(1, 'Main Branch', 'New Delhi'),
(2, 'City Center Branch', 'Mumbai');

select * from Customers;
INSERT INTO Customers VALUES
(1, 'Arun', 'Menon', 1),
(2, 'Deepa', 'Nair', 2),
(3, 'Suresh', 'Pillai', 1),
(4, 'Lekshmi', 'Kumar', 2),
(5, 'Pradeep', 'Nambiar', 1),
(6, 'Saranya', 'Chandran', 2),
(7, 'Rahul', 'Sharma', 1),
(8, 'Ananya', 'Singh', 2),
(9, 'Vikram', 'Gupta', 1),
(10, 'Pooja', 'Verma', 2);

select * from accounts;
INSERT INTO Accounts VALUES
(101, 1, 'Savings', 5000.00),
(102, 2, 'Checking', 1000.00),
(103, 3, 'Savings', 7500.00),
(104, 4, 'Checking', 3000.00),
(105, 5, 'Savings', 6000.00),
(106, 6, 'Checking', 2000.00),
(107, 7, 'Savings', 8000.00),
(108, 8, 'Checking', 2500.00),
(109, 9, 'Savings', 6000.00),
(110, 10, 'Checking', 3500.00);

select * from transactions;
INSERT INTO Transactions VALUES
(1001, 101, 'Deposit', 2000.00, '2023-01-01'),
(1002, 102, 'Withdrawal', 500.00, '2023-01-02'),
(1003, 103, 'Deposit', 3000.00, '2023-01-03'),
(1004, 104, 'Withdrawal', 1000.00, '2023-01-04'),
(1005, 105, 'Deposit', 1500.00, '2023-01-05'),
(1006, 106, 'Withdrawal', 800.00, '2023-01-06'),
(1007, 107, 'Deposit', 1200.00, '2023-01-07'),
(1008, 108, 'Withdrawal', 800.00, '2023-01-08'),
(1009, 109, 'Deposit', 2500.00, '2023-01-09'),
(1010, 110, 'Withdrawal', 1200.00, '2023-01-10');


select * from loans;
INSERT INTO Loans VALUES
(201, 1, 10000.00, 'Personal Loan'),
(202, 2, 150000.00, 'Home Loan'),
(203, 3, 5000.00, 'Car Loan'),
(204, 4, 20000.00, 'Education Loan'),
(205, 5, 75000.00, 'Business Loan'),
(206, 6, 3000.00, 'Personal Loan'),
(207, 7, 12000.00, 'Home Loan'),
(208, 8, 80000.00, 'Car Loan'),
(209, 9, 6000.00, 'Personal Loan'),
(210, 10, 25000.00, 'Education Loan');

select * from Employees;
INSERT INTO Employees VALUES
(301, 'Amit', 'Verma', 1, 'Branch Manager', 60000.00),
(302, 'Priya', 'Singh', 2, 'Customer Service Representative', 30000.00),
(303, 'Rajesh', 'Kumar', 2, 'Financial Advisor', 50000.00),
(304, 'Neha', 'Sharma', 2, 'Loan Officer', 45000.00),
(305, 'Vishal', 'Gupta', 2, 'Accountant', 40000.00),
(306, 'Preeti', 'Mishra', 2, 'Teller', 35000.00),
(307, 'Rahul', 'Das', 1, 'Customer Service Representative', 30000.00),
(308, 'Anjali', 'Rao', 1, 'Financial Advisor', 50000.00),
(309, 'Arun', 'Mehra', 1, 'Loan Officer', 45000.00),
(310, 'Deepika', 'Sen', 1, 'Branch Manager', 60000.00);



#Retrieve customer names and their account balances
SELECT customers.CustomerID, Customers.FirstName, Customers.LastName, Accounts.Balance
FROM Customers 
JOIN Accounts ON Customers.CustomerID = Accounts.CustomerID;


#Find transactions with their associated customer names
SELECT T.TransactionID, C.FirstName, C.LastName, T.TransactionType, T.Amount, T.TransactionDate
FROM Transactions T
JOIN Accounts A ON T.AccountID = A.AccountID
JOIN Customers C ON A.CustomerID = C.CustomerID;


#Calculate the total balance for each account type:
SELECT AccountType, SUM(Balance) AS TotalBalance
FROM Accounts
GROUP BY AccountType;


#Find the average transaction amount for each transaction type:
SELECT TransactionType, AVG(Amount) AS AvgTransactionAmount
FROM Transactions
GROUP BY TransactionType;


#List employees along with their associated branch information
SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName, Employees.Position, Employees.Salary, Branches.BranchName
FROM Employees
JOIN Branches ON Employees.BranchID = Branches.BranchID;


#Retrieve transactions made by a specific customer (e.g., CustomerID = 3)
SELECT Transactions.TransactionID, Customers.FirstName, Customers.LastName, Transactions.TransactionType, Transactions.Amount, Transactions.TransactionDate
FROM Transactions
JOIN Accounts ON Transactions.AccountID = Accounts.AccountID
JOIN Customers ON Accounts.CustomerID = Customers.CustomerID
WHERE Customers.CustomerID = 3;


#Calculate the total salary expense for each branch
SELECT Branches.BranchName, SUM(Employees.Salary) AS TotalSalaryExpense
FROM Employees
JOIN Branches ON Employees.BranchID = Branches.BranchID
GROUP BY Branches.BranchName;


#Find the total loan amount for each loan type
SELECT LoanType, SUM(LoanAmount) AS TotalLoanAmount
FROM Loans
GROUP BY LoanType;










-- Calculate current balance for each account
SELECT
    a.AccountID,
    a.CustomerID,
    a.AccountType,
    a.Balance AS InitialBalance,
    SUM(CASE WHEN t.TransactionType = 'Deposit' THEN t.Amount ELSE -t.Amount END) AS CurrentBalance
FROM
    Accounts a
JOIN Transactions t ON a.AccountID = t.AccountID
GROUP BY
    a.AccountID, a.CustomerID, a.AccountType, a.Balance;


-- Drop the trigger if it exists
IF OBJECT_ID('prevent_negative_balance', 'TR') IS NOT NULL
    DROP TRIGGER prevent_negative_balance;
GO

-- Create the trigger
CREATE TRIGGER prevent_negative_balance
ON Transactions
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @current_balance DECIMAL(10, 2);

    SELECT @current_balance = a.Balance
    FROM Accounts a
    WHERE a.AccountID = (SELECT i.AccountID FROM inserted i);

    IF (SELECT i.TransactionType FROM inserted i) = 'Withdrawal' AND @current_balance - (SELECT i.Amount FROM inserted i) < 0
    BEGIN
        THROW 50000, 'Withdrawal amount exceeds available balance for Checking account', 1;
    END
    ELSE
    BEGIN
        -- Insert the transaction into the Transactions table
        INSERT INTO Transactions (AccountID, TransactionType, Amount, TransactionDate)
        SELECT i.AccountID, i.TransactionType, i.Amount, i.TransactionDate
        FROM inserted i;
    END
END;



INSERT INTO Transactions (AccountID, TransactionType, Amount, TransactionDate)
VALUES (102, 'Withdrawal', 1200.00, '2023-01-15');


INSERT INTO Transactions (TransactionID, AccountID, TransactionType, Amount, TransactionDate)
VALUES (10011, 102, 'Withdrawal', 1200.00, '2023-01-15');

SELECT * FROM Transactions;


-- Example INSERT without specifying TransactionID
INSERT INTO Transactions(TransactionID, AccountID, TransactionType, Amount, TransactionDate)
VALUES (1011, 111, 'Withdrawal', 1200.00, '2023-01-10');


