-- Tworzenie tabel: 
CREATE TABLE DimClient 
(
    ID_Client INTEGER NOT NULL , 
    ClientName VARCHAR (200) , 
    LegalFormOfClient VARCHAR (200) , 
    YearFounded NUMERIC (8,2) 
)
GO

ALTER TABLE DimClient ADD CONSTRAINT DimClient_PK PRIMARY KEY CLUSTERED (ID_Client)
    WITH (
    ALLOW_PAGE_LOCKS = ON , 
    ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE DimDepartment 
(
    ID_Department INTEGER NOT NULL , 
    DepartmentManager VARCHAR (200) , 
    DepartmentRoomNumber NUMERIC (8,2) , 
    InternalDepartmentNumber NUMERIC (8,2) , 
    DepartmentEmployee VARCHAR (200) 
)
GO

ALTER TABLE DimDepartment ADD CONSTRAINT Department_PK PRIMARY KEY CLUSTERED (ID_Department)
    WITH (
    ALLOW_PAGE_LOCKS = ON , 
    ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE DimDocumentType 
(
    ID_DocumentType INTEGER NOT NULL , 
    DocumentName VARCHAR (200) , 
    Ledger VARCHAR (200) , 
    DocumentNumber NUMERIC (8,2) 
)
GO

ALTER TABLE DimDocumentType ADD CONSTRAINT DimDocumentType_PK PRIMARY KEY CLUSTERED (ID_DocumentType)
    WITH (
    ALLOW_PAGE_LOCKS = ON , 
    ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE DimProgram 
(
    ID_Program INTEGER NOT NULL , 
    Name VARCHAR (200) , 
    Expiration_Date DATE , 
    ID_Department INTEGER NOT NULL 
)
GO

ALTER TABLE DimProgram ADD CONSTRAINT DimProgram_PK PRIMARY KEY CLUSTERED (ID_Program)
    WITH (
    ALLOW_PAGE_LOCKS = ON , 
    ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE FactDocument 
(
    ID_Document INTEGER NOT NULL , 
    ID_DocumentType INTEGER NOT NULL , 
    Amount NUMERIC (8,2) , 
    ID_Program INTEGER NOT NULL , 
    ID_Client INTEGER NOT NULL 
)
GO

ALTER TABLE FactDocument ADD CONSTRAINT FactAccountingDocument_PK PRIMARY KEY CLUSTERED (ID_Document)
    WITH (
    ALLOW_PAGE_LOCKS = ON , 
    ALLOW_ROW_LOCKS = ON )
GO

ALTER TABLE DimProgram 
    ADD CONSTRAINT DimProgram_DimDepartment_FK FOREIGN KEY 
    ( 
        ID_Department
    ) 
    REFERENCES DimDepartment 
    ( 
        ID_Department 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FactDocument 
    ADD CONSTRAINT FactDocument_DimClient_FK FOREIGN KEY 
    ( 
        ID_Client
    ) 
    REFERENCES DimClient 
    ( 
        ID_Client 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FactDocument 
    ADD CONSTRAINT FactDocument_DimDocumentType_FK FOREIGN KEY 
    ( 
        ID_DocumentType
    ) 
    REFERENCES DimDocumentType 
    ( 
        ID_DocumentType 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FactDocument 
    ADD CONSTRAINT FactDocument_DimProgram_FK FOREIGN KEY 
    ( 
        ID_Program
    ) 
    REFERENCES DimProgram 
    ( 
        ID_Program 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO
-- Dodawanie rekordów do wymiarów: 
-- Wstawianie rekordów do DimClient
INSERT INTO DimClient (ID_Client, ClientName, LegalFormOfClient, YearFounded)
VALUES
    (3, 'Client3', 'LegalForm3', 2010),
    (4, 'Client4', 'LegalForm4', 2008),
    (5, 'Client5', 'LegalForm5', 2015),
    (6, 'Client6', 'LegalForm6', 2002),
    (7, 'Client7', 'LegalForm7', 2018),
    (8, 'Client8', 'LegalForm8', 2007),
    (9, 'Client9', 'LegalForm9', 2012),
    (10, 'Client10', 'LegalForm10', 2019);

-- Wstawianie rekordów do DimDepartment
INSERT INTO DimDepartment (ID_Department, DepartmentManager, DepartmentRoomNumber, InternalDepartmentNumber, DepartmentEmployee)
VALUES
    (3, 'Manager3', 103, 1003, 'Employee3'),
    (4, 'Manager4', 104, 1004, 'Employee4'),
    (5, 'Manager5', 105, 1005, 'Employee5'),
    (6, 'Manager6', 106, 1006, 'Employee6'),
    (7, 'Manager7', 107, 1007, 'Employee7'),
    (8, 'Manager8', 108, 1008, 'Employee8'),
    (9, 'Manager9', 109, 1009, 'Employee9'),
    (10, 'Manager10', 110, 1010, 'Employee10');

-- Wstawianie rekordów do DimDocumentType
INSERT INTO DimDocumentType (ID_DocumentType, DocumentName, Ledger, DocumentNumber)
VALUES
    (3, 'DocumentType3', 'Ledger3', 10003),
    (4, 'DocumentType4', 'Ledger4', 10004),
    (5, 'DocumentType5', 'Ledger5', 10005),
    (6, 'DocumentType6', 'Ledger6', 10006),
    (7, 'DocumentType7', 'Ledger7', 10007),
    (8, 'DocumentType8', 'Ledger8', 10008),
    (9, 'DocumentType9', 'Ledger9', 10009),
    (10, 'DocumentType10', 'Ledger10', 10010);

-- Wstawianie rekordów do DimProgram
INSERT INTO DimProgram (ID_Program, Name, Expiration_Date, ID_Department)
VALUES
    (3, 'Program3', '2027-01-01', 3),
    (4, 'Program4', '2028-01-01', 4),
    (5, 'Program5', '2029-01-01', 5),
    (6, 'Program6', '2030-01-01', 6),
    (7, 'Program7', '2031-01-01', 7),
    (8, 'Program8', '2032-01-01', 8),
    (9, 'Program9', '2033-01-01', 9),
    (10, 'Program10', '2034-01-01', 10);

-- Wstawianie rekordów do FactDocument
INSERT INTO FactDocument (ID_Document, ID_DocumentType, Amount, ID_Program, ID_Client)
VALUES
    (3, 3, 200.00, 3, 3),
    (4, 4, 75.25, 4, 4),
    (5, 5, 120.50, 5, 5),
    (6, 6, 180.00, 6, 6),
    (7, 7, 90.75, 7, 7),
    (8, 8, 110.25, 8, 8),
    (9, 9, 250.50, 9, 9),
    (10, 10, 300.75, 10, 10);
SELECT * FROM FactDocument
