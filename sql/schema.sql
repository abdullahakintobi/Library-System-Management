-- Library System Management SQL Project

-- Drop tables in correct dependency order
DROP TABLE IF EXISTS return_status;
DROP TABLE IF EXISTS issued_status;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS branch;

-- Create table "branch"
CREATE TABLE branch (
    branch_id VARCHAR(10) PRIMARY KEY,
    manager_id VARCHAR(10),
    branch_address TEXT NOT NULL,
    contact_no VARCHAR(15) CHECK (contact_no ~ '^\+?[0-9]{7,15}$')
);

-- Create table "employees"
CREATE TABLE employees (
    emp_id VARCHAR(10) PRIMARY KEY,
    emp_name TEXT NOT NULL,
    position TEXT NOT NULL,
    salary DECIMAL(10, 2) NOT NULL CHECK (salary >= 0),
    branch_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

-- Create table "members"
CREATE TABLE members (
    member_id VARCHAR(10) PRIMARY KEY,
    member_name TEXT NOT NULL,
    member_address TEXT NOT NULL,
    reg_date DATE NOT NULL DEFAULT CURRENT_DATE
);

-- Create table "books"
CREATE TABLE books (
    isbn VARCHAR(50) PRIMARY KEY,
    book_title TEXT NOT NULL,
    category TEXT NOT NULL,
    rental_price DECIMAL(10,2) NOT NULL CHECK (rental_price >= 0),
    status VARCHAR(10) NOT NULL CHECK (status IN ('available', 'issued', 'lost')),
    author TEXT,
    publisher TEXT
);

-- Create table "issued_status"
CREATE TABLE issued_status (
    issued_id VARCHAR(10) PRIMARY KEY,
    member_id VARCHAR(10) NOT NULL,
    isbn VARCHAR(50) NOT NULL,
    issued_date DATE NOT NULL DEFAULT CURRENT_DATE,
    emp_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (isbn) REFERENCES books(isbn),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- Create table "return_status"
CREATE TABLE return_status (
    return_id VARCHAR(10) PRIMARY KEY,
    issued_id VARCHAR(10) NOT NULL,
    return_date DATE NOT NULL DEFAULT CURRENT_DATE,
    FOREIGN KEY (issued_id) REFERENCES issued_status(issued_id)
);
