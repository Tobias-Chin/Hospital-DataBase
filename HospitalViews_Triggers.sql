-- Group 15:Dennis Field,Tanya Khan, Tobias Chin 
-----------------
-- Drop Tables --
-----------------

Drop Table stayin;
Drop Table examine;
Drop Table admission;
Drop Table patient;
Drop Table roomaccess;
Drop Table roomservice;
Drop Table equipment;
Drop Table room;
Drop Table canrepairequipment;
Drop Table equipmenttype;
Drop Table equipmenttechnician;
Drop Table doctor;
Drop Table employee;

-----------------------------
-- Create Table Statements --
-----------------------------

CREATE TABLE Employee (
    EID NUMBER PRIMARY KEY,
    FName VARCHAR2(50),
    LName VARCHAR2(50),
    Salary NUMBER,
    jobTitle VARCHAR2(100),
    OfficeNum NUMBER ,
    empRank NUMBER CHECK (empRank IN (0, 1, 2)),     
    supervisorID NUMBER,
    AddressStreet VARCHAR2(100),
    AddressCity VARCHAR2(50),
    Constraint fk_supervisorID Foreign Key (supervisorID) References Employee(EID));

CREATE TABLE Doctor (
    EmployeeID NUMBER PRIMARY KEY,
    gender CHAR(1) CHECK (gender IN ('M', 'F')),
    specialty VARCHAR2(100),
    GraduatedFrom VARCHAR2(100),
    Constraint fk_EmployeeID1 FOREIGN KEY (EmployeeID) references Employee(EID));

CREATE TABLE EquipmentTechnician (
    EmployeeID NUMBER PRIMARY KEY,
    Constraint fk_EmployeeID2 FOREIGN KEY (EmployeeID) references Employee(EID));

CREATE TABLE EquipmentType (
    eTID NUMBER PRIMARY KEY,
    Description VARCHAR2(200),
    model VARCHAR2(100),
    instructions VARCHAR2(400),
    NumberOfUnits NUMBER);

CREATE TABLE CanRepairEquipment (
    EmployeeID NUMBER,
    EquipmentTypeID NUMBER,
    PRIMARY KEY (EmployeeID, EquipmentTypeID),
    Constraint fk_EmployeeID3 FOREIGN KEY (EmployeeID) references EquipmentTechnician(EmployeeID),
    Constraint fk_EquipmentTypeID FOREIGN KEY (EquipmentTypeID) references EquipmentType(eTID));

CREATE TABLE Room (
    rNum NUMBER PRIMARY KEY,
    occupiedFlag CHAR(1) CHECK (occupiedFlag IN ('Y', 'N'))
);

CREATE TABLE Equipment (
    SerialNumber VARCHAR2(50) PRIMARY KEY,
    TypeID NUMBER,
    PurchaseYear NUMBER,
    LastInspection DATE,
    roomNum NUMBER CHECK (roomNum >= 0),
    Constraint fk_TypeID FOREIGN KEY (TypeID) references EquipmentType(eTID),
    Constraint fk_roomNum1 FOREIGN KEY (roomNum) references Room(rNum));

CREATE TABLE RoomService (
    roomNum NUMBER,
    service VARCHAR2(100),
    PRIMARY KEY (roomNum, service),
    Constraint fk_roomNUM2 FOREIGN KEY (roomNum) references Room(rNum));


CREATE TABLE RoomAccess (
    roomNum NUMBER,
    EmpID NUMBER,
    PRIMARY KEY (roomNum, EmpID),
    Constraint fk_roomNum3 FOREIGN KEY (roomNum) references Room(rNum),
    Constraint fk_EmpID FOREIGN KEY (EmpID) references Employee(EID));

CREATE TABLE Patient (
    pSSN VARCHAR2(12) PRIMARY KEY,
    FirstName VARCHAR2(50),
    LastName VARCHAR2(50),
    Address VARCHAR2(200),
    TelNum VARCHAR2(15));

CREATE TABLE Admission (
    aNum NUMBER PRIMARY KEY,
    AdmissionDate DATE,
    LeaveDate DATE,
    TotalPayment NUMBER CHECK (TotalPayment >= 0),
    InsurancePayment NUMBER CHECK (InsurancePayment >= 0),
    Patient_SSN VARCHAR2(12),
    FutureVisit DATE,
    Constraint fk_Patient_SSN FOREIGN KEY (Patient_SSN) references Patient(pSSN));

CREATE TABLE Examine (
    DoctorID NUMBER,
    AdmissionNum NUMBER,
    comments VARCHAR2(400),
    Constraint fk_DoctorID  FOREIGN KEY (DoctorID) references Doctor(EmployeeID),
    Constraint fk_AdmissionNum1 FOREIGN KEY (AdmissionNum) references Admission(aNum));

CREATE TABLE StayIn (
    AdmissionNum NUMBER,
    RoomNum NUMBER,
    startDate DATE,
    endDate DATE,
    PRIMARY KEY (AdmissionNum, RoomNum, startDate),
    Constraint fk_AdmissionNum2  FOREIGN KEY (AdmissionNum) references Admission(aNum),
    Constraint fk_roomNum4 FOREIGN KEY (RoomNum) references Room(rNum));
    
--------------------
-- Data Insertion --
--------------------

-- Room
    
INSERT INTO Patient (pSSN, FirstName, LastName, Address, TelNum) VALUES
       ('223-60-7970', 'Henry', 'Lewis', '951 Fir Ct', '5552236067');
INSERT INTO Patient (pSSN, FirstName, LastName, Address, TelNum) VALUES
       ('111-22-3333', 'John', 'Doe', '123 Maple St', '5551234567');
INSERT INTO Patient (pSSN, FirstName, LastName, Address, TelNum) VALUES
       ('987-65-3210', 'Jane', 'Smith', '456 Oak Ave', '5559876543');
INSERT INTO Patient (pSSN, FirstName, LastName, Address, TelNum) VALUES
       ('135-79-4680', 'Alice', 'Brown', '789 Pine Rd', '5551357924');
INSERT INTO Patient (pSSN, FirstName, LastName, Address, TelNum) VALUES
       ('246-80-3570', 'Bob', 'Johnson', '321 Elm St', '5552468013');
INSERT INTO Patient (pSSN, FirstName, LastName, Address, TelNum) VALUES
       ('314-15-2650', 'Charlie', 'Davis', '654 Cedar Ln', '5553141592');
INSERT INTO Patient (pSSN, FirstName, LastName, Address, TelNum) VALUES
       ('271-82-1820', 'David', 'White', '987 Birch Blvd', '5552718281');
INSERT INTO Patient (pSSN, FirstName, LastName, Address, TelNum) VALUES
       ('161-80-3990', 'Eva', 'Wilson', '159 Ash Dr', '5551618033');
INSERT INTO Patient (pSSN, FirstName, LastName, Address, TelNum) VALUES
       ('141-42-3560', 'Frank', 'Taylor', '753 Poplar St', '5551414213');
INSERT INTO Patient (pSSN, FirstName, LastName, Address, TelNum) VALUES
       ('112-35-1320', 'Grace', 'Clark', '852 Willow Way', '5551123581');
       
-- Room

INSERT INTO Room (rNum, occupiedFlag) VALUES (101, 'N');
INSERT INTO Room (rNum, occupiedFlag) VALUES (102, 'Y');
INSERT INTO Room (rNum, occupiedFlag) VALUES (103, 'N');
INSERT INTO Room (rNum, occupiedFlag) VALUES (104, 'Y');
INSERT INTO Room (rNum, occupiedFlag) VALUES (105, 'N');
INSERT INTO Room (rNum, occupiedFlag) VALUES (106, 'N');
INSERT INTO Room (rNum, occupiedFlag) VALUES (107, 'Y');
INSERT INTO Room (rNum, occupiedFlag) VALUES (108, 'N');
INSERT INTO Room (rNum, occupiedFlag) VALUES (109, 'Y');
INSERT INTO Room (rNum, occupiedFlag) VALUES (110, 'N');

-- RoomService

INSERT INTO RoomService (roomNum, service) VALUES (101, 'Cleaning');
INSERT INTO RoomService (roomNum, service) VALUES (101, 'ICU');

INSERT INTO RoomService (roomNum, service) VALUES (102, 'Laundry');
INSERT INTO RoomService (roomNum, service) VALUES (102, 'ICU');

INSERT INTO RoomService (roomNum, service) VALUES (104, 'Food Service');
INSERT INTO RoomService (roomNum, service) VALUES (104, 'Laundry');

INSERT INTO RoomService (roomNum, service) VALUES (103, 'ICU');
INSERT INTO RoomService (roomNum, service) VALUES (103, 'Food Service');

INSERT INTO RoomService (roomNum, service) VALUES (105, 'Laundry');
INSERT INTO RoomService (roomNum, service) VALUES (105, 'Cleaning');

INSERT INTO RoomService (roomNum, service) VALUES (106, 'Food Service');
INSERT INTO RoomService (roomNum, service) VALUES (106, 'Laundry');

INSERT INTO RoomService (roomNum, service) VALUES (107, 'Food Service');

INSERT INTO RoomService (roomNum, service) VALUES (108, 'Cleaning');
INSERT INTO RoomService (roomNum, service) VALUES (108, 'Food Service');

INSERT INTO RoomService (roomNum, service) VALUES (109, 'Laundry');

INSERT INTO RoomService (roomNum, service) VALUES (110, 'Cleaning');
INSERT INTO RoomService (roomNum, service) VALUES (110, 'Food Service');

-- EquipmentType

INSERT INTO EquipmentType (eTID, Description, model, instructions, NumberOfUnits) 
VALUES (1, 'X-Ray Machine', 'ModelX100', 'Use with caution', 3);

INSERT INTO EquipmentType (eTID, Description, model, instructions, NumberOfUnits) 
VALUES (2, 'MRI Scanner', 'ModelMRI200', 'Read manual before use', 3);

INSERT INTO EquipmentType (eTID, Description, model, instructions, NumberOfUnits) 
VALUES (3, 'Ultrasound Machine', 'ModelUltra300', 'Follow guidelines strictly', 3);

-- Equipment

INSERT INTO Equipment (SerialNumber, TypeID, PurchaseYear, LastInspection, roomNum)
VALUES ('A01-02X', 1, 2012, TO_DATE('2024-06-15', 'YYYY-MM-DD'), 101);

INSERT INTO Equipment (SerialNumber, TypeID, PurchaseYear, LastInspection, roomNum)
VALUES ('XR10002', 1, 2020, TO_DATE('2024-07-20', 'YYYY-MM-DD'), 102);

INSERT INTO Equipment (SerialNumber, TypeID, PurchaseYear, LastInspection, roomNum)
VALUES ('XR10003', 1, 2021, TO_DATE('2024-08-10', 'YYYY-MM-DD'), 103);

INSERT INTO Equipment (SerialNumber, TypeID, PurchaseYear, LastInspection, roomNum)
VALUES ('MRI20001', 2, 2020, TO_DATE('2024-05-12', 'YYYY-MM-DD'), 104);

INSERT INTO Equipment (SerialNumber, TypeID, PurchaseYear, LastInspection, roomNum)
VALUES ('MRI20002', 2, 2010, TO_DATE('2024-06-30', 'YYYY-MM-DD'), 105);

INSERT INTO Equipment (SerialNumber, TypeID, PurchaseYear, LastInspection, roomNum)
VALUES ('MRI20003', 2, 2022, TO_DATE('2024-07-25', 'YYYY-MM-DD'), 106);

INSERT INTO Equipment (SerialNumber, TypeID, PurchaseYear, LastInspection, roomNum)
VALUES ('US30001', 3, 2011, TO_DATE('2024-05-05', 'YYYY-MM-DD'), 107);

INSERT INTO Equipment (SerialNumber, TypeID, PurchaseYear, LastInspection, roomNum)
VALUES ('US30002', 3, 2011, TO_DATE('2024-06-10', 'YYYY-MM-DD'), 108);

INSERT INTO Equipment (SerialNumber, TypeID, PurchaseYear, LastInspection, roomNum)
VALUES ('US30003', 3, 2023, TO_DATE('2024-08-15', 'YYYY-MM-DD'), 109);

-- Admissions for Patient 1 (John Doe)
INSERT INTO Admission (aNum, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, Patient_SSN, FutureVisit)
VALUES (1, TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-05', 'YYYY-MM-DD'), 5000, 4000, '111-22-3333', TO_DATE('2024-10-01', 'YYYY-MM-DD'));

INSERT INTO Admission (aNum, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, Patient_SSN, FutureVisit)
VALUES (2, TO_DATE('2024-03-01', 'YYYY-MM-DD'), TO_DATE('2024-03-10', 'YYYY-MM-DD'), 6000, 4500, '111-22-3333', NULL);

INSERT INTO Admission (aNum, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, Patient_SSN, FutureVisit)
VALUES (16, TO_DATE('2024-08-10', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), 6000, 4500, '111-22-3333', NULL);

-- Admissions for Patient 2 (Jane Smith)
INSERT INTO Admission (aNum, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, Patient_SSN, FutureVisit)
VALUES (3, TO_DATE('2024-02-01', 'YYYY-MM-DD'), TO_DATE('2024-02-07', 'YYYY-MM-DD'), 5500, 4200, '987-65-3210', TO_DATE('2024-12-01', 'YYYY-MM-DD'));

INSERT INTO Admission (aNum, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, Patient_SSN, FutureVisit)
VALUES (4, TO_DATE('2024-05-15', 'YYYY-MM-DD'), TO_DATE('2024-05-20', 'YYYY-MM-DD'), 4800, 3800, '987-65-3210', NULL);

INSERT INTO Admission (aNum, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, Patient_SSN, FutureVisit)
VALUES (17, TO_DATE('2024-08-03', 'YYYY-MM-DD'), TO_DATE('2024-08-05', 'YYYY-MM-DD'), 5500, 4200, '987-65-3210', TO_DATE('2024-12-01', 'YYYY-MM-DD'));

INSERT INTO Admission (aNum, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, Patient_SSN, FutureVisit)
VALUES (18, TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_DATE('2024-12-01', 'YYYY-MM-DD'), 4800, 3800, '987-65-3210', NULL);

INSERT INTO Admission (aNum, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, Patient_SSN, FutureVisit)
VALUES (19, TO_DATE('2024-12-10', 'YYYY-MM-DD'), TO_DATE('2024-12-14', 'YYYY-MM-DD'), 5500, 4200, '987-65-3210', TO_DATE('2024-12-25', 'YYYY-MM-DD'));

-- Admissions for Patient 3 (Alice Brown)
INSERT INTO Admission (aNum, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, Patient_SSN, FutureVisit)
VALUES (5, TO_DATE('2024-04-01', 'YYYY-MM-DD'), TO_DATE('2024-04-05', 'YYYY-MM-DD'), 5200, 3900, '135-79-4680', TO_DATE('2024-11-01', 'YYYY-MM-DD'));

INSERT INTO Admission (aNum, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, Patient_SSN, FutureVisit)
VALUES (6, TO_DATE('2024-07-01', 'YYYY-MM-DD'), TO_DATE('2024-07-10', 'YYYY-MM-DD'), 6100, 4700, '135-79-4680', NULL);

-- Admissions for Patient 4 (Bob Johnson)
INSERT INTO Admission (aNum, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, Patient_SSN, FutureVisit)
VALUES (7, TO_DATE('2024-01-15', 'YYYY-MM-DD'), TO_DATE('2024-01-20', 'YYYY-MM-DD'), 4900, 3700, '246-80-3570', TO_DATE('2024-09-01', 'YYYY-MM-DD'));

INSERT INTO Admission (aNum, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, Patient_SSN, FutureVisit)
VALUES (8, TO_DATE('2024-05-10', 'YYYY-MM-DD'), TO_DATE('2024-05-18', 'YYYY-MM-DD'), 5700, 4500, '246-80-3570', NULL);

-- Admissions for Patient 5 (Charlie Davis)
INSERT INTO Admission (aNum, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, Patient_SSN, FutureVisit)
VALUES (9, TO_DATE('2024-02-20', 'YYYY-MM-DD'), TO_DATE('2024-02-25', 'YYYY-MM-DD'), 5300, 4000, '314-15-2650', TO_DATE('2024-10-15', 'YYYY-MM-DD'));

INSERT INTO Admission (aNum, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, Patient_SSN, FutureVisit)
VALUES (10, TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-12', 'YYYY-MM-DD'), 6200, 4800, '314-15-2650', NULL);

-- Patient 6 (David White)

INSERT INTO Admission (aNum, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, Patient_SSN, FutureVisit)
VALUES (11, TO_DATE('2024-08-01', 'YYYY-MM-DD'), TO_DATE('2024-08-07', 'YYYY-MM-DD'), 5400, 4100, '271-82-1820', NULL);

-- Patient 7 (Eva Wilson)

INSERT INTO Admission (aNum, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, Patient_SSN, FutureVisit)
VALUES (12, TO_DATE('2024-03-20', 'YYYY-MM-DD'), TO_DATE('2024-03-25', 'YYYY-MM-DD'), 5000, 4000, '161-80-3990', NULL);

-- Patient 8 (Frank Taylor)

INSERT INTO Admission (aNum, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, Patient_SSN, FutureVisit)
VALUES (13, TO_DATE('2024-04-15', 'YYYY-MM-DD'), TO_DATE('2024-04-22', 'YYYY-MM-DD'), 4800, 3500, '141-42-3560', NULL);

-- Patient 9 (Grace Clark)

INSERT INTO Admission (aNum, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, Patient_SSN, FutureVisit)
VALUES (14, TO_DATE('2024-07-01', 'YYYY-MM-DD'), TO_DATE('2024-07-08', 'YYYY-MM-DD'), 5600, 4200, '112-35-1320', NULL);

-- Patient 10 (Henry Lewis)

INSERT INTO Admission (aNum, AdmissionDate, LeaveDate, TotalPayment, InsurancePayment, Patient_SSN, FutureVisit)
VALUES (15, TO_DATE('2024-09-01', 'YYYY-MM-DD'), TO_DATE('2024-09-06', 'YYYY-MM-DD'), 5900, 4500, '223-60-7970', NULL);

-- General Managers

INSERT INTO Employee (EID, FName, LName, Salary, jobTitle, OfficeNum, empRank, supervisorID, AddressStreet, AddressCity)
VALUES (20, 'Sophia', 'Martin', 130000, 'General Manager', 501, 2, NULL, '579 Walnut St', 'Metropolis');

INSERT INTO Employee (EID, FName, LName, Salary, jobTitle, OfficeNum, empRank, supervisorID, AddressStreet, AddressCity)
VALUES (21, 'Liam', 'Lee', 140000, 'General Manager', 502, 2, NULL, '680 Cherry Blvd', 'Metropolis');

-- Division Managers

INSERT INTO Employee (EID, FName, LName, Salary, jobTitle, OfficeNum, empRank, supervisorID, AddressStreet, AddressCity)
VALUES (16, 'James', 'Thompson', 90000, 'Division Manager', 401, 1, 20, '135 Ash St', 'Metropolis');

INSERT INTO Employee (EID, FName, LName, Salary, jobTitle, OfficeNum, empRank, supervisorID, AddressStreet, AddressCity)
VALUES (17, 'Mia', 'Jackson', 95000, 'Division Manager', 402, 1, 20, '246 Oak Ave', 'Metropolis');

INSERT INTO Employee (EID, FName, LName, Salary, jobTitle, OfficeNum, empRank, supervisorID, AddressStreet, AddressCity)
VALUES (18, 'Jacob', 'White', 88000, 'Division Manager', 403, 1, 21, '357 Maple St', 'Metropolis');

INSERT INTO Employee (EID, FName, LName, Salary, jobTitle, OfficeNum, empRank, supervisorID, AddressStreet, AddressCity)
VALUES (19, 'Emma', 'Moore', 92000, 'Division Manager', 404, 1, 21, '468 Cedar Ct', 'Metropolis');

-- Regular Employees

INSERT INTO Employee (EID, FName, LName, Salary, jobTitle, OfficeNum, empRank, supervisorID, AddressStreet, AddressCity)
VALUES (1, 'Michael', 'Smith', 60000, 'Nurse', 101, 0, 16, '123 Oak St', 'Metropolis');

INSERT INTO Employee (EID, FName, LName, Salary, jobTitle, OfficeNum, empRank, supervisorID, AddressStreet, AddressCity)
VALUES (2, 'Sarah', 'Johnson', 65000, 'Nurse', 101, 0, 16, '234 Maple St', 'Metropolis');

INSERT INTO Employee (EID, FName, LName, Salary, jobTitle, OfficeNum, empRank, supervisorID, AddressStreet, AddressCity)
VALUES (3, 'Robert', 'Brown', 70000, 'Nurse', 102, 0, 16, '345 Pine St', 'Metropolis');

INSERT INTO Employee (EID, FName, LName, Salary, jobTitle, OfficeNum, empRank, supervisorID, AddressStreet, AddressCity)
VALUES (4, 'Emily', 'Davis', 72000, 'Nurse', 102, 0, 17, '456 Cedar St', 'Metropolis');

INSERT INTO Employee (EID, FName, LName, Salary, jobTitle, OfficeNum, empRank, supervisorID, AddressStreet, AddressCity)
VALUES (5, 'David', 'Wilson', 55000, 'Nurse', 103, 0, 17, '567 Birch St', 'Metropolis');

-- 5 Doctors

INSERT INTO Employee (EID, FName, LName, Salary, jobTitle, OfficeNum, empRank, supervisorID, AddressStreet, AddressCity)
VALUES (6, 'Alice', 'Brown', 120000, 'Doctor', 201, 0, 16, '678 Elm St', 'Metropolis');

INSERT INTO Doctor (EmployeeID, gender, specialty, GraduatedFrom)
VALUES (6, 'F', 'Cardiology', 'WPI');

INSERT INTO Employee (EID, FName, LName, Salary, jobTitle, OfficeNum, empRank, supervisorID, AddressStreet, AddressCity)
VALUES (7, 'Charlie', 'Williams', 115000, 'Doctor', 202, 0, 16, '789 Walnut St', 'Metropolis');

INSERT INTO Doctor (EmployeeID, gender, specialty, GraduatedFrom)
VALUES (7, 'M', 'Pediatrics', 'WPI');

INSERT INTO Employee (EID, FName, LName, Salary, jobTitle, OfficeNum, empRank, supervisorID, AddressStreet, AddressCity)
VALUES (8, 'Sophia', 'Jones', 130000, 'Doctor', 203, 0, 17, '890 Chestnut St', 'Metropolis');

INSERT INTO Doctor (EmployeeID, gender, specialty, GraduatedFrom)
VALUES (8, 'F', 'Neurology', 'RIT');

INSERT INTO Employee (EID, FName, LName, Salary, jobTitle, OfficeNum, empRank, supervisorID, AddressStreet, AddressCity)
VALUES (9, 'William', 'Garcia', 125000, 'Doctor', 204, 0, 17, '321 Spruce St', 'Metropolis');

INSERT INTO Doctor (EmployeeID, gender, specialty, GraduatedFrom)
VALUES (9, 'M', 'Orthopedics', 'RIT');

INSERT INTO Employee (EID, FName, LName, Salary, jobTitle, OfficeNum, empRank, supervisorID, AddressStreet, AddressCity)
VALUES (10, 'Olivia', 'Martinez', 118000, 'Doctor', 205, 0, 17, '432 Fir St', 'Metropolis');

INSERT INTO Doctor (EmployeeID, gender, specialty, GraduatedFrom)
VALUES (10, 'F', 'Internal Medicine', 'RPI');

-- 5 Equipment Technicians

INSERT INTO Employee (EID, FName, LName, Salary, jobTitle, OfficeNum, empRank, supervisorID, AddressStreet, AddressCity)
VALUES (11, 'Ethan', 'Hernandez', 50000, 'Equipment Technician', 301, 0, 18, '543 Sycamore St', 'Metropolis');

INSERT INTO EquipmentTechnician (EmployeeID)
VALUES (11);

INSERT INTO Employee (EID, FName, LName, Salary, jobTitle, OfficeNum, empRank, supervisorID, AddressStreet, AddressCity)
VALUES (12, 'Isabella', 'Lopez', 52000, 'Equipment Technician', 302, 0, 18, '654 Maple Ave', 'Metropolis');

INSERT INTO EquipmentTechnician (EmployeeID)
VALUES (12);

INSERT INTO Employee (EID, FName, LName, Salary, jobTitle, OfficeNum, empRank, supervisorID, AddressStreet, AddressCity)
VALUES (13, 'Mason', 'Gonzalez', 51000, 'Equipment Technician', 303, 0, 19, '765 Oak Ct', 'Metropolis');

INSERT INTO EquipmentTechnician (EmployeeID)
VALUES (13);

INSERT INTO Employee (EID, FName, LName, Salary, jobTitle, OfficeNum, empRank, supervisorID, AddressStreet, AddressCity)
VALUES (14, 'Ava', 'Wilson', 53000, 'Equipment Technician', 304, 0, 19, '876 Birch Blvd', 'Metropolis');

INSERT INTO EquipmentTechnician (EmployeeID)
VALUES (14);

INSERT INTO Employee (EID, FName, LName, Salary, jobTitle, OfficeNum, empRank, supervisorID, AddressStreet, AddressCity)
VALUES (15, 'Lucas', 'Anderson', 55000, 'Equipment Technician', 305, 0, 19, '987 Pine Dr', 'Metropolis');

INSERT INTO EquipmentTechnician (EmployeeID)
VALUES (15);

-- Can Repair

INSERT INTO CanRepairEquipment (EmployeeID, EquipmentTypeID)
VALUES (11, 1);

INSERT INTO CanRepairEquipment (EmployeeID, EquipmentTypeID)
VALUES (11, 2);

INSERT INTO CanRepairEquipment (EmployeeID, EquipmentTypeID)
VALUES (11, 3);

INSERT INTO CanRepairEquipment (EmployeeID, EquipmentTypeID)
VALUES (12, 1);

INSERT INTO CanRepairEquipment (EmployeeID, EquipmentTypeID)
VALUES (13, 1);

INSERT INTO CanRepairEquipment (EmployeeID, EquipmentTypeID)
VALUES (14, 3);

INSERT INTO CanRepairEquipment (EmployeeID, EquipmentTypeID)
VALUES (15, 1);

INSERT INTO CanRepairEquipment (EmployeeID, EquipmentTypeID)
VALUES (15, 3);

-- Admissions

INSERT INTO Examine (DoctorID, AdmissionNum, comments)
VALUES (6,	1,	'Looking Good');

INSERT INTO Examine (DoctorID, AdmissionNum, comments) 
VALUES (6, 2, 'Uh Oh');

INSERT INTO Examine (DoctorID, AdmissionNum, comments) 
VALUES (6, 3, 'My');

INSERT INTO Examine (DoctorID, AdmissionNum, comments) 
VALUES (6, 4, 'Favorite');

INSERT INTO Examine (DoctorID, AdmissionNum, comments) 
VALUES (6, 5, 'Marvel');

INSERT INTO Examine (DoctorID, AdmissionNum, comments) 
VALUES (6, 6, 'Character');

INSERT INTO Examine (DoctorID, AdmissionNum, comments) 
VALUES (6, 7, 'Is');

INSERT INTO Examine (DoctorID, AdmissionNum, comments) 
VALUES (6, 8, 'Loki');

INSERT INTO Examine (DoctorID, AdmissionNum, comments) 
VALUES (6, 9, 'Hes');

INSERT INTO Examine (DoctorID, AdmissionNum, comments) 
VALUES (6, 10, 'Cool');

INSERT INTO Examine (DoctorID, AdmissionNum, comments) 
VALUES (6, 16, 'Welcome Back');

INSERT INTO Examine (DoctorID, AdmissionNum, comments) 
VALUES (7, 3, 'Neat');

INSERT INTO Examine (DoctorID, AdmissionNum, comments) 
VALUES (7, 4, 'Not Sick');

INSERT INTO Examine (DoctorID, AdmissionNum, comments) 
VALUES (7, 5, 'Page Psychiatry');

INSERT INTO Examine (DoctorID, AdmissionNum, comments) 
VALUES (8, 19, 'I');

INSERT INTO Examine (DoctorID, AdmissionNum, comments) 
VALUES (8, 18, 'really');

INSERT INTO Examine (DoctorID, AdmissionNum, comments) 
VALUES (8, 17, 'hate');

INSERT INTO Examine (DoctorID, AdmissionNum, comments) 
VALUES (8, 16, 'making');

INSERT INTO Examine (DoctorID, AdmissionNum, comments) 
VALUES (8, 15, 'fucking');

INSERT INTO Examine (DoctorID, AdmissionNum, comments) 
VALUES (8, 14, 'pointless');

INSERT INTO Examine (DoctorID, AdmissionNum, comments) 
VALUES (8, 13, 'data');

INSERT INTO Examine (DoctorID, AdmissionNum, comments) 
VALUES (8, 12, 'Why didnt you just give it to us like last time???');

INSERT INTO Examine (DoctorID, AdmissionNum, comments) 
VALUES (8, 6, 'Prank');

INSERT INTO Examine (DoctorID, AdmissionNum, comments) 
VALUES (8, 7, 'Im Bored');

INSERT INTO Examine (DoctorID, AdmissionNum, comments) 
VALUES (8, 8, 'Call Me');

INSERT INTO Examine (DoctorID, AdmissionNum, comments) 
VALUES (9, 9, 'Hey');

INSERT INTO Examine (DoctorID, AdmissionNum, comments) 
VALUES (10, 10, 'I Just Met You');

-- Room Access 

INSERT INTO RoomAccess (roomNum, EmpID) VALUES (101, 1);
INSERT INTO RoomAccess (roomNum, EmpID) VALUES (102, 2);
INSERT INTO RoomAccess (roomNum, EmpID) VALUES (103, 3);
INSERT INTO RoomAccess (roomNum, EmpID) VALUES (104, 4);
INSERT INTO RoomAccess (roomNum, EmpID) VALUES (105, 5);
INSERT INTO RoomAccess (roomNum, EmpID) VALUES (106, 6);
INSERT INTO RoomAccess (roomNum, EmpID) VALUES (107, 7);
INSERT INTO RoomAccess (roomNum, EmpID) VALUES (108, 8);
INSERT INTO RoomAccess (roomNum, EmpID) VALUES (109, 9);
INSERT INTO RoomAccess (roomNum, EmpID) VALUES (110, 10);
INSERT INTO RoomAccess (roomNum, EmpID) VALUES (101, 11);
INSERT INTO RoomAccess (roomNum, EmpID) VALUES (101, 12);
INSERT INTO RoomAccess (roomNum, EmpID) VALUES (101, 13);
INSERT INTO RoomAccess (roomNum, EmpID) VALUES (101, 14);
INSERT INTO RoomAccess (roomNum, EmpID) VALUES (101, 15);
INSERT INTO RoomAccess (roomNum, EmpID) VALUES (101, 16);
INSERT INTO RoomAccess (roomNum, EmpID) VALUES (101, 17);
INSERT INTO RoomAccess (roomNum, EmpID) VALUES (101, 18);
INSERT INTO RoomAccess (roomNum, EmpID) VALUES (101, 19);
INSERT INTO RoomAccess (roomNum, EmpID) VALUES (102, 19);
INSERT INTO RoomAccess (roomNum, EmpID) VALUES (101, 20);
INSERT INTO RoomAccess (roomNum, EmpID) VALUES (102, 20);
INSERT INTO RoomAccess (roomNum, EmpID) VALUES (103, 20);
INSERT INTO RoomAccess (roomNum, EmpID) VALUES (101, 21);
INSERT INTO RoomAccess (roomNum, EmpID) VALUES (102, 21);
INSERT INTO RoomAccess (roomNum, EmpID) VALUES (103, 21);
    
INSERT INTO StayIN(AdmissionNum, RoomNum, startDate, endDate) VALUES (1, 101, TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-05', 'YYYY-MM-DD'));
INSERT INTO StayIN(AdmissionNum, RoomNum, startDate, endDate) VALUES (2, 101, TO_DATE('2024-03-01', 'YYYY-MM-DD'), TO_DATE('2024-03-10', 'YYYY-MM-DD'));
INSERT INTO StayIN(AdmissionNum, RoomNum, startDate, endDate) VALUES (3, 101, TO_DATE('2024-02-01', 'YYYY-MM-DD'), TO_DATE('2024-02-07', 'YYYY-MM-DD'));
INSERT INTO StayIN(AdmissionNum, RoomNum, startDate, endDate) VALUES (4, 102, TO_DATE('2024-05-15', 'YYYY-MM-DD'), TO_DATE('2024-05-20', 'YYYY-MM-DD'));
INSERT INTO StayIN(AdmissionNum, RoomNum, startDate, endDate) VALUES (5, 102, TO_DATE('2024-04-01', 'YYYY-MM-DD'), TO_DATE('2024-04-05', 'YYYY-MM-DD'));
INSERT INTO StayIN(AdmissionNum, RoomNum, startDate, endDate) VALUES (6, 106, TO_DATE('2024-07-01', 'YYYY-MM-DD'), TO_DATE('2024-07-10', 'YYYY-MM-DD'));
INSERT INTO StayIN(AdmissionNum, RoomNum, startDate, endDate) VALUES (7, 105, TO_DATE('2024-01-15', 'YYYY-MM-DD'), TO_DATE('2024-09-01', 'YYYY-MM-DD'));
INSERT INTO StayIN(AdmissionNum, RoomNum, startDate, endDate) VALUES (8, 104, TO_DATE('2024-05-10', 'YYYY-MM-DD'), TO_DATE('2024-05-18', 'YYYY-MM-DD'));
INSERT INTO StayIN(AdmissionNum, RoomNum, startDate, endDate) VALUES (9, 110, TO_DATE('2024-02-20', 'YYYY-MM-DD'), TO_DATE('2024-02-25', 'YYYY-MM-DD'));
INSERT INTO StayIN(AdmissionNum, RoomNum, startDate, endDate) VALUES (10, 109, TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-12', 'YYYY-MM-DD'));
INSERT INTO StayIN(AdmissionNum, RoomNum, startDate, endDate) VALUES (11, 108, TO_DATE('2024-08-01', 'YYYY-MM-DD'), TO_DATE('2024-08-07', 'YYYY-MM-DD'));
INSERT INTO StayIN(AdmissionNum, RoomNum, startDate, endDate) VALUES (12, 107, TO_DATE('2024-03-20', 'YYYY-MM-DD'), TO_DATE('2024-03-25', 'YYYY-MM-DD'));
INSERT INTO StayIN(AdmissionNum, RoomNum, startDate, endDate) VALUES (13, 106, TO_DATE('2024-04-15', 'YYYY-MM-DD'), TO_DATE('2024-04-22', 'YYYY-MM-DD'));
INSERT INTO StayIN(AdmissionNum, RoomNum, startDate, endDate) VALUES (14, 105, TO_DATE('2024-07-01', 'YYYY-MM-DD'), TO_DATE('2024-07-08', 'YYYY-MM-DD'));
INSERT INTO StayIN(AdmissionNum, RoomNum, startDate, endDate) VALUES (15, 104, TO_DATE('2024-09-01', 'YYYY-MM-DD'), TO_DATE('2024-09-06', 'YYYY-MM-DD'));
INSERT INTO StayIN(AdmissionNum, RoomNum, startDate, endDate) VALUES (16, 102, TO_DATE('2024-08-10', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'));
INSERT INTO StayIN(AdmissionNum, RoomNum, startDate, endDate) VALUES (17, 103, TO_DATE('2024-08-03', 'YYYY-MM-DD'), TO_DATE('2024-08-05', 'YYYY-MM-DD'));
INSERT INTO StayIN(AdmissionNum, RoomNum, startDate, endDate) VALUES (18, 103, TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_DATE('2024-12-01', 'YYYY-MM-DD'));
INSERT INTO StayIN(AdmissionNum, RoomNum, startDate, endDate) VALUES (19, 103, TO_DATE('2024-12-10', 'YYYY-MM-DD'), TO_DATE('2024-12-14', 'YYYY-MM-DD'));

--------------------
--     Views      --
--------------------
Drop View Criticalcases;
Drop View DoctorsLoad;

/* Create a view named CriticalCases that selects the patients who have been admitted to
Intensive Care Unit (ICU) at least 2 times. The view columns should be: Patient_SSN,
firstName, lastName, numberOfAdmissionsToICU.*/

CREATE VIEW CriticalCases AS
    SELECT 
        p.pSSN AS Patient_SSN,
        p.FirstName,
        p.LastName,
        COUNT(s.AdmissionNum) AS numberOfAdmissionsToICU
    FROM 
        Patient p
    JOIN 
        Admission a ON p.pSSN = a.Patient_SSN
    JOIN 
        StayIn s ON a.aNum = s.AdmissionNum
    JOIN 
        RoomService rs ON s.RoomNum = rs.roomNum
    WHERE 
        rs.service = 'ICU'
    GROUP BY 
        p.pSSN, p.FirstName, p.LastName
    HAVING 
        COUNT(s.AdmissionNum) >= 2;
    
SELECT *
FROM CriticalCases;

/*Create a view named DoctorsLoad that reports for each doctor whether this doctor has an
overload or not. A doctor has an overload if they have more than 10 distinct admission
cases; otherwise, the doctor has an underload. Notice that if a doctor examined a patient
multiple times in the same admission, that still counts as one admission case. The view
columns should be: DoctorID, graduatedFrom, load.*/

CREATE VIEW DoctorsLoad AS
    SELECT 
        D.EmployeeID AS DoctorID,
        D.GraduatedFrom,
        CASE 
            WHEN COUNT(DISTINCT E.AdmissionNum) > 10 THEN 'Overloaded'
            ELSE 'Underloaded'
        END AS load
    FROM 
        Doctor D
    JOIN 
        Examine E ON D.EmployeeID = E.DoctorID
    GROUP BY 
        D.EmployeeID, D.GraduatedFrom;

SELECT *
FROM DoctorsLoad;

/* Use the views created above (you may need the original tables as well) to report the
critical-case patients with number of admissions to ICU greater than 4 */

SELECT *
FROM CriticalCases
WHERE numberOfAdmissionsToICU > 4;

/*Use the views created above (you may need the original tables as well) to report the
overloaded doctors that graduated from WPI. You should report the doctor ID, firstName,
and lastName.*/

SELECT DoctorID, fName, lName
FROM Employee E
JOIN DoctorsLoad D ON E.EID = D.DoctorID
WHERE D.GraduatedFrom = 'WPI' 
AND D.Load = 'Overloaded';

/* Use the views created above (you may need the original tables as well) to report the
comments inserted by underloaded doctors when examining critical-case patients. You
should report the doctor Id, patient SSN, and the comment */

SELECT D.DoctorID, C.Patient_SSN, E.Comments
FROM DoctorsLoad D
JOIN Examine E ON D.DoctorID = E.DoctorID
JOIN Admission A ON A.aNum = E.AdmissionNum
JOIN CriticalCases C ON C.Patient_SSN = A.Patient_SSN
WHERE D.Load = 'Underloaded';

--------------------
--    Triggers    --
--------------------

Drop Trigger icuComments;

/* If a doctor visits a patient who has been in the ICU during their current admission, they
must leave a comment. An example of this could be a patient whose admission involved a
1 day stay in a room designated as an Emergency Room, a 2 hour stay in an operating
room, and a 1 day stay in a room designated as an ICU. If a doctor was to visit the patient
during this admission, then they must leave a comment. */

CREATE TRIGGER icuComments
Before Insert On Examine E
For Each Row
When (new.comments = null)
Declare x VARCHAR2(100);
Begin
    SELECT service into x
        FROM roomservice RS 
        Join (SELECT roomnum
              FROM stayin S
              WHERE S.admissionNum = E.AdmissionNum) R
        ON RS.roomNum = R.roomNum;
    if (x = 'ICU') THEN
        if (E.comments = null) THEN
            RAISE_APPPLICATION_ERROR (-20004, 'Comment(s) required');   
        END IF;
    END IF;
END;
        
/* The insurance payment should be calculated automatically as 65% of the total payment.
If the total payment changes, then the insurance amount should also change. */



/* Ensure that regular employees (with rank 0) must have their supervisors as division
managers (with rank 1). Also, each regular employee must have a supervisor at all times. */



/* Similarly, division managers (with rank 1) must have their supervisors as general
managers (with rank 2). Division managers must have supervisors at all times. General
Managers must not have any supervisors. */



/* When a patient is admitted to an Emergency Room (a room with an Emergency service)
on date D, the futureVisitDate should be automatically set to 2 months after that date, i.e.,
D + 2 months. The futureVisitDate may be manually changed later, but when the
Emergency Room admission happens, the date should be set to default as mentioned
above. */



/* When a new piece of equipment is purchased and it has not been inspected for over a
month, check if there is an equipment technician who can service it. If there is, update the
inspection date. */












