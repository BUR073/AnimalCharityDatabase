DROP DATABASE IF EXISTS animal;

CREATE
    DATABASE animal;

USE
    animal;

CREATE TABLE Address
(
    AddressId INT PRIMARY KEY AUTO_INCREMENT,
    Line1     VARCHAR(100) NOT NULL,
    Line2     VARCHAR(100),
    Postcode  VARCHAR(7)   NOT NULL,
    Town      VARCHAR(30)  NOT NULL,
    County    VARCHAR(30)  NOT NULL
);

CREATE TABLE Branch
(
    BranchId   INT PRIMARY KEY AUTO_INCREMENT,
    BranchName VARCHAR(100) NOT NULL,
    AddressId  INT          NOT NULL,

    FOREIGN KEY (AddressId) REFERENCES Address (AddressId) ON DELETE RESTRICT
);

CREATE TABLE AdoptionFormQuestion
(
    QuestionId INT PRIMARY KEY AUTO_INCREMENT,
    Question   TEXT NOT NULL
);

CREATE TABLE Campaign
(
    CampaignId  INT PRIMARY KEY AUTO_INCREMENT,
    Name        Varchar(100) NOT NULL,
    Description TEXT,
    StartDate   DATE,
    EndDate     DATE
);


CREATE TABLE MedicalStatus
(
    MedicalStatusId   INT PRIMARY KEY AUTO_INCREMENT,
    CurrentMedication TEXT,
    MedicalHistory    TEXT

);

CREATE TABLE AdoptionProgress
(
    AdoptionProgressId INT PRIMARY KEY AUTO_INCREMENT,
    AdoptionStatus     ENUM ('In Branch', 'Adoption In progress', 'Awaiting Home visit', 'Adopted'),
    Notes              TEXT,
    StatusUpdateAt     DATE NOT NULL

);

CREATE TABLE Animal
(
    AnimalId           INT PRIMARY KEY AUTO_INCREMENT,
    BranchId           INT         NOT NULL,
    Name               VARCHAR(50) NOT NULL,
    Type               VARCHAR(50) NOT NULL,
    Breed              VARCHAR(50) NOT NULL,
    DOB                DATE        NOT NULL,
    Size               ENUM ('Small', 'Medium', 'Large'),
    Description        TEXT,
    MedicalStatusId    INT UNIQUE,
    AdoptionProgressId INT UNIQUE  NOT NULL,

    FOREIGN KEY (BranchId) REFERENCES Branch (BranchId) ON DELETE RESTRICT,
    FOREIGN KEY (MedicalStatusId) REFERENCES MedicalStatus (MedicalStatusId) ON DELETE RESTRICT,
    FOREIGN KEY (AdoptionProgressId) REFERENCES AdoptionProgress (AdoptionProgressId) ON DELETE RESTRICT
);

CREATE TABLE User
(
    UserId    INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100)        NOT NULL,
    LastName  VARCHAR(100)        NOT NULL,
    Email     VARCHAR(100) UNIQUE NOT NULL,
    Phone     VARCHAR(15)         NOT NULL,
    AddressId INT                 NOT NULL,

    FOREIGN KEY (AddressId) REFERENCES Address (AddressId) ON DELETE RESTRICT
);

CREATE TABLE Role
(
    RoleId   INT PRIMARY KEY AUTO_INCREMENT,
    UserId   INT     NOT NULL,
    Salary   INT,
    RoleType ENUM ('Staff', 'Volunteer'),
    IsActive BOOLEAN NOT NULL DEFAULT TRUE,

    FOREIGN KEY (UserId) REFERENCES User (UserId) ON DELETE CASCADE
);

CREATE TABLE PaymentMethod
(
    PaymentMethodId   INT PRIMARY KEY AUTO_INCREMENT,
    UserId            INT                           NOT NULL,
    PaymentMethodType ENUM ('Direct Debit', 'Card') NOT NULL,

    FOREIGN KEY (UserId) REFERENCES User (UserId) ON DELETE CASCADE
);

CREATE TABLE DirectDebitDetails
(
    PaymentMethodId   INT PRIMARY KEY,
    SortCode          VARCHAR(10)  NOT NULL,
    AccountNumber     VARCHAR(15)  NOT NULL,
    AccountHolderName VARCHAR(100) NOT NULL,
    FOREIGN KEY (PaymentMethodId) REFERENCES PaymentMethod (PaymentMethodId) ON DELETE CASCADE
);

CREATE TABLE CardDetails
(
    PaymentMethodId  INT PRIMARY KEY,
    CardNumber       VARCHAR(50) NOT NULL,
    ExpDate          DATE        NOT NULL,
    SecurityCode     VARCHAR(4)  NOT NULL,
    BillingAddressId INT         NOT NULL,
    FOREIGN KEY (PaymentMethodId) REFERENCES PaymentMethod (PaymentMethodId) ON DELETE CASCADE,
    FOREIGN KEY (BillingAddressId) REFERENCES Address (AddressId)
);

CREATE TABLE HomeVisit
(
    HomeVisitId        INT PRIMARY KEY AUTO_INCREMENT,
    VisitDate          DATE NOT NULL,
    StaffWhoVisited    INT,
    Adopter            INT,
    AdoptionProgressId INT UNIQUE,

    FOREIGN KEY (StaffWhoVisited) REFERENCES User (UserId) ON DELETE RESTRICT,
    FOREIGN KEY (Adopter) REFERENCES User (UserId) ON DELETE RESTRICT,
    FOREIGN KEY (AdoptionProgressId) REFERENCES AdoptionProgress (AdoptionProgressId) ON DELETE RESTRICT,

    CHECK (StaffWhoVisited <> Adopter)
);

CREATE TABLE AdoptionForm
(
    AdoptionFormId     INT PRIMARY KEY AUTO_INCREMENT,
    UserId             INT NOT NULL,
    DateSubmitted      DATETIME DEFAULT CURRENT_TIMESTAMP,
    AdoptionProgressId INT UNIQUE,

    FOREIGN KEY (UserId) REFERENCES User (UserId) ON DELETE RESTRICT,
    FOREIGN KEY (AdoptionProgressId) REFERENCES AdoptionProgress (AdoptionProgressId) ON DELETE RESTRICT
);

CREATE TABLE AdoptionProgressHistory
(
    HistoryId          INT PRIMARY KEY AUTO_INCREMENT,
    AdoptionProgressId INT  NOT NULL,
    AdoptionStatus     ENUM ('In Branch', 'Adoption In progress', 'Awaiting Home visit', 'Adopted'),
    StatusUpdateAt     DATE NOT NULL,
    Notes              TEXT,
    FOREIGN KEY (AdoptionProgressId) REFERENCES AdoptionProgress (AdoptionProgressId) ON DELETE CASCADE
);

CREATE TABLE Assignment
(
    AssignmentId   INT PRIMARY KEY AUTO_INCREMENT,
    AnimalId       INT,
    AdoptionFormId INT,
    CampaignId     INT,

    FOREIGN KEY (AnimalId) REFERENCES Animal (AnimalId) ON DELETE RESTRICT,
    FOREIGN KEY (CampaignId) REFERENCES Campaign (CampaignId) ON DELETE RESTRICT,
    FOREIGN KEY (AdoptionFormId) REFERENCES AdoptionForm (AdoptionFormId) ON DELETE RESTRICT
);

CREATE TABLE Sponsorship
(
    SponsorshipId     INT PRIMARY KEY AUTO_INCREMENT,
    UserId            INT NOT NULL,
    AnimalId          INT NOT NULL,
    SponsorshipAmount INT NOT NULL,
    PaymentMethodId   INT NOT NULL,

    FOREIGN KEY (UserId) REFERENCES User (UserId) ON DELETE RESTRICT,
    FOREIGN KEY (AnimalId) REFERENCES Animal (AnimalId) ON DELETE RESTRICT,
    FOREIGN KEY (PaymentMethodId) REFERENCES PaymentMethod (PaymentMethodId) ON DELETE RESTRICT
);

CREATE TABLE AdoptionFormAnswer
(
    AnswerId       INT PRIMARY KEY AUTO_INCREMENT,
    AdoptionFormId INT  NOT NULL,
    QuestionId     INT  NOT NULL,
    Answer         TEXT NOT NULL,

    FOREIGN KEY (AdoptionFormId) REFERENCES AdoptionForm (AdoptionFormId) ON DELETE CASCADE,
    FOREIGN KEY (QuestionId) REFERENCES AdoptionFormQuestion (QuestionId) ON DELETE RESTRICT
);

CREATE TABLE RoleAssignments
(
    RoleId       INT,
    AssignmentId INT,
    PRIMARY KEY (RoleId, AssignmentId),
    FOREIGN KEY (RoleId) REFERENCES Role (RoleId) ON DELETE CASCADE,
    FOREIGN KEY (AssignmentId) REFERENCES Assignment (AssignmentId) ON DELETE CASCADE
);

CREATE TABLE RecurringDonation
(
    RecurringDonationId INT PRIMARY KEY AUTO_INCREMENT,
    UserId              INT            NOT NULL,
    PaymentMethodId     INT            NOT NULL,
    AmountPerPayment    DECIMAL(10, 2) NOT NULL,
    StartDate           DATE           NOT NULL,
    FreqInDays          INT            NOT NULL,
    NextPaymentDate     DATE           NOT NULL,
    IsActive            BOOLEAN        NOT NULL DEFAULT TRUE,

    FOREIGN KEY (UserId) REFERENCES User (UserId) ON DELETE CASCADE,
    FOREIGN KEY (PaymentMethodId) REFERENCES PaymentMethod (PaymentMethodId) ON DELETE RESTRICT
);

CREATE TABLE Donation
(
    DonationId          INT PRIMARY KEY AUTO_INCREMENT,
    UserId              INT            NOT NULL,
    Amount              DECIMAL(10, 2) NOT NULL,
    DonationDate        DATE           NOT NULL,
    PaymentMethodId     INT,
    CampaignId          INT,
    RecurringDonationId INT,

    FOREIGN KEY (UserId) REFERENCES User (UserId) ON DELETE RESTRICT,
    FOREIGN KEY (CampaignId) REFERENCES Campaign (CampaignId) ON DELETE RESTRICT,
    FOREIGN KEY (PaymentMethodId) REFERENCES PaymentMethod (PaymentMethodId) ON DELETE RESTRICT,
    FOREIGN KEY (RecurringDonationId) REFERENCES RecurringDonation (RecurringDonationId) ON DELETE SET NULL
);







