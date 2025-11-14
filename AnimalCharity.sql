CREATE
    DATABASE animal;

USE
    animal;

CREATE TABLE RecurringDonation
(
    RecurringDonationId INT PRIMARY KEY AUTO_INCREMENT,
    StartDate           Date    NOT NULL,
    IsActive            BOOLEAN NOT NULL DEFAULT TRUE,
    FreqInDays          INT     NOT NULL,
    LastPayment         DATE,
    NextPayment         DATE AS (DATE_ADD(LastPayment, INTERVAL FreqInDays DAY)) VIRTUAL
);

CREATE TABLE Donation
(
    DonationId          INT PRIMARY KEY AUTO_INCREMENT,
    UserId              INT            NOT NULL,
    Amount              DECIMAL(10, 2) NOT NULL,
    PaymentMethodId     INT,
    DonationDate        DATE,
    RecurringDonationId INT,
    CampaignId          INT,

    FOREIGN KEY (UserId) REFERENCES User (UserId),
    FOREIGN KEY (PaymentMethodId) REFERENCES PaymentMethod (PaymentMethodId),
    FOREIGN KEY (RecurringDonationId) REFERENCES RecurringDonation (RecurringDonationId),
    FOREIGN KEY (CampaignId) REFERENCES Campaign (CampaignId),
    CHECK (RecurringDonationId IS NULL OR RecurringDonationId > 0)

);

CREATE TABLE AdoptionProgress
(
    AdoptionProgressId INT PRIMARY KEY AUTO_INCREMENT,
    AnimalId           INT,
    AdoptionStatus     ENUM ('In Branch', 'Adoption In progress', 'Awaiting Home visit', 'Adopted'),
    Notes              TEXT,
    StatusUpdateAt     DATE NOT NULL,
    AdoptionFormId     INT,
    HomeVisitId        INT,

    FOREIGN KEY (AdoptionFormId) REFERENCES AdoptionForm (AdoptionFormId),
    FOREIGN KEY (HomeVisitId) REFERENCES HomeVisit (HomeVisitId),
    FOREIGN KEY (AnimalId) REFERENCES Animal (AnimalId)

);

CREATE TABLE AdoptionProgressHistory
(
    HistoryId          INT PRIMARY KEY AUTO_INCREMENT,
    AdoptionProgressId INT  NOT NULL,
    AdoptionStatus     ENUM ('In Branch', 'Adoption In progress', 'Awaiting Home visit', 'Adopted'),
    StatusUpdateAt     DATE NOT NULL,
    Notes              TEXT,
    FOREIGN KEY (AdoptionProgressId) REFERENCES AdoptionProgress (AdoptionProgressId)
);


CREATE TABLE HomeVisit
(
    HomeVisitId     INT PRIMARY KEY AUTO_INCREMENT,
    VisitDate       DATE NOT NULL,
    StaffWhoVisited INT,
    Adopter         INT,

    FOREIGN KEY (StaffWhoVisited) REFERENCES User (UserId),
    FOREIGN KEY (Adopter) REFERENCES User (UserId),

    CHECK (StaffWhoVisited <> Adopter)
);

CREATE TABLE Sponsorship
(
    SponsorshipId     INT PRIMARY KEY AUTO_INCREMENT,
    UserId            INT NOT NULL,
    AnimalId          INT NOT NULL,
    SponsorshipAmount INT NOT NULL,
    PaymentMethodId   INT NOT NULL,

    FOREIGN KEY (UserId) REFERENCES User (UserId),
    FOREIGN KEY (AnimalId) REFERENCES Animal (AnimalId),
    FOREIGN KEY (PaymentMethodId) REFERENCES PaymentMethod (PaymentMethodId)
);

CREATE TABLE PaymentMethod
(
    PaymentMethodId   INT PRIMARY KEY AUTO_INCREMENT,
    UserId            INT                           NOT NULL,
    PaymentMethodType ENUM ('Direct Debit', 'Card') NOT NULL,
    FOREIGN KEY (UserId) REFERENCES User (UserId)
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
    PaymentMethodId INT PRIMARY KEY,
    CardNumber      VARCHAR(50) NOT NULL,
    ExpDate         DATE        NOT NULL,
    SecurityCode    VARCHAR(4)  NOT NULL,
    BillingPostCode VARCHAR(6)  NOT NULL,
    FOREIGN KEY (PaymentMethodId) REFERENCES PaymentMethod (PaymentMethodId) ON DELETE CASCADE
);


CREATE TABLE Address
(
    AddressId INT PRIMARY KEY AUTO_INCREMENT,
    Line1     VARCHAR(100) NOT NULL,
    Line2     VARCHAR(100),
    Postcode  VARCHAR(7)   NOT NULL,
    Town      VARCHAR(30)  NOT NULL,
    County    VARCHAR(30)  NOT NULL
);

CREATE TABLE AdoptionForm
(
    AdoptionFormId INT PRIMARY KEY AUTO_INCREMENT,
    UserId         INT NOT NULL,
    DateSubmitted  DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (UserId) REFERENCES User (UserId)
);

CREATE TABLE AdoptionFormQuestion
(
    QuestionId INT PRIMARY KEY AUTO_INCREMENT,
    Question   TEXT NOT NULL
);

CREATE TABLE AdoptionFormAnswer
(
    AnswerId       INT PRIMARY KEY AUTO_INCREMENT,
    AdoptionFormId INT  NOT NULL,
    QuestionId     INT  NOT NULL,
    Answer         TEXT NOT NULL,

    FOREIGN KEY (AdoptionFormId) REFERENCES AdoptionForm (AdoptionFormId),
    FOREIGN KEY (QuestionId) REFERENCES AdoptionFormQuestion (QuestionId)
);


CREATE TABLE Animal
(
    AnimalId        INT PRIMARY KEY AUTO_INCREMENT,
    BranchId        INT         NOT NULL,
    Name            VARCHAR(50) NOT NULL,
    Type            VARCHAR(50) NOT NULL,
    Breed           VARCHAR(50) NOT NULL,
    DOB             DATE        NOT NULL,
    Age             INT AS (TIMESTAMPDIFF(YEAR, DOB, CURDATE())) VIRTUAL,
    Size            ENUM ('Small', 'Medium', 'Large'),
    Description     TEXT,
    MedicalStatusId INT         NOT NULL,

    FOREIGN KEY (BranchId) REFERENCES Branch (BranchId),
    FOREIGN KEY (MedicalStatusId) REFERENCES MedicalStatus (MedicalStatusId)
);

CREATE TABLE Campaign
(
    CampaignId  INT PRIMARY KEY AUTO_INCREMENT,
    Description TEXT,
    StartDate   DATE,
    EndDate     DATE
);

CREATE TABLE Assignment
(
    AssignmentId   INT PRIMARY KEY AUTO_INCREMENT,
    AnimalId       INT,
    AdoptionFormId INT,
    CampaignId     INT,

    FOREIGN KEY (AnimalId) REFERENCES Animal (AnimalId),
    FOREIGN KEY (AdoptionFormId) REFERENCES AdoptionForm (AdoptionFormId),
    FOREIGN KEY (CampaignId) REFERENCES Campaign (CampaignId)
);

CREATE TABLE Role
(
    RoleId   INT PRIMARY KEY AUTO_INCREMENT,
    Salary   INT,
    RoleType ENUM ('Staff', 'Volunteer')
);


CREATE TABLE RoleAssignments
(
    RoleId       INT,
    AssignmentId INT,
    PRIMARY KEY (RoleId, AssignmentId),
    FOREIGN KEY (RoleId) REFERENCES Role (RoleId) ON DELETE CASCADE,
    FOREIGN KEY (AssignmentId) REFERENCES Assignment (AssignmentId) ON DELETE CASCADE
);

CREATE TABLE User
(
    UserId    INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100)        NOT NULL,
    LastName  VARCHAR(100)        NOT NULL,
    Email     VARCHAR(100) UNIQUE NOT NULL,
    Phone     VARCHAR(15)         NOT NULL,
    AddressId INT                 NOT NULL,

    FOREIGN KEY (AddressId) REFERENCES Address (AddressId)
);

CREATE TABLE Branch
(
    BranchId   INT PRIMARY KEY AUTO_INCREMENT,
    BranchName VARCHAR(100) NOT NULL,
    AddressId  INT          NOT NULL,

    FOREIGN KEY (AddressId) REFERENCES Address (AddressId)
);

CREATE TABLE MedicalStatus
(
    MedicalStatusId   INT PRIMARY KEY AUTO_INCREMENT,
    CurrentMedication TEXT,
    MedicalHistory    TEXT
);








