USE animal;

INSERT INTO Address (Line1, Line2, Postcode, Town, County)
VALUES ('Wood Green Animal Shelters', 'London Road, Godmanchester', 'PE292NH', 'Huntingdon', 'Cambridgeshire');
SET @BranchAddressId = LAST_INSERT_ID();

INSERT INTO Branch (BranchName, AddressId)
VALUES ('Wood Green', @BranchAddressId);
SET @BranchId = LAST_INSERT_ID();

DELIMITER $$

CREATE PROCEDURE AddRandomUsers()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE newAddrId INT;

    WHILE i <= 10
        DO
            INSERT INTO Address (Line1, Line2, Postcode, Town, County)
            VALUES (CONCAT('User Street ', i), CONCAT('Apt ', i), CONCAT('AB1', i, 'CD'), 'Town', 'County');

            SET newAddrId = LAST_INSERT_ID();

            INSERT INTO User (FirstName, LastName, Email, Phone, AddressId)
            VALUES (CONCAT('User', i), 'Test', CONCAT('user', i, '@example.com'), CONCAT('07123456', i), newAddrId);

            INSERT INTO PaymentMethod (UserId, PaymentMethodType)
            VALUES (i, ELT(FLOOR(1 + RAND() * 2), 'Direct Debit', 'Card'));

            SET i = i + 1;
        END WHILE;
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE AddThreeCampaigns()
BEGIN
    INSERT INTO Campaign (Description, StartDate, EndDate)
    VALUES ('Winter Animal Care Fund', '2025-11-01', '2025-12-31'),
           ('Spring Adoption Drive', '2026-03-01', '2026-05-31'),
           ('Emergency Vet Fund', '2025-11-15', '2025-12-15');
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE AddRandomAnimals()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE randType VARCHAR(50);
    DECLARE randBreed VARCHAR(50);
    DECLARE randSize ENUM ('Small','Medium','Large');
    DECLARE randDOB DATE;

    WHILE i <= 10
        DO
            SET randType = ELT(FLOOR(1 + RAND() * 3), 'Dog', 'Cat', 'Rabbit');
            SET randBreed =
                    ELT(FLOOR(1 + RAND() * 5), 'Pug', 'French Bulldog', 'English Pointer', 'German Pointer', 'Tabby');
            SET randSize = ELT(FLOOR(1 + RAND() * 3), 'Small', 'Medium', 'Large');
            SET randDOB = DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 3650) DAY);

            INSERT INTO MedicalStatus (CurrentMedication, MedicalHistory)
            VALUES ('None', 'No known medical history');

            SET @NewMedicalStatusId = LAST_INSERT_ID();

            INSERT INTO Animal (BranchId, Name, Type, Breed, DOB, Size, Description, MedicalStatusId)
            VALUES (@BranchId,
                    CONCAT(randType, ' ', i),
                    randType,
                    randBreed,
                    randDOB,
                    randSize,
                    'Randomly generated animal',
                    @NewMedicalStatusId);

            SET i = i + 1;
        END WHILE;
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE AddLinkedDonations()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE randAmount DECIMAL(10, 2);
    DECLARE randCampaignId INT;

    WHILE i <= 10
        DO
            SET randAmount = ROUND(5 + (RAND() * 95), 2);

            SET @userId = i;

            SET @paymentId = i;

            SET randCampaignId = FLOOR(1 + RAND() * 3);

            INSERT INTO Donation (UserId, Amount, PaymentMethodId, DonationDate, CampaignId)
            VALUES (@userId, randAmount, @paymentId, CURDATE(), randCampaignId);

            SET i = i + 1;
        END WHILE;
END $$

DELIMITER ;

CALL AddRandomUsers();
CALL AddThreeCampaigns();
CALL AddRandomAnimals();
CALL AddLinkedDonations();
