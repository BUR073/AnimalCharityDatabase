Use animal;
# Sample data for at least 10 animals, 10 donors, and 3 campaigns.
# Create Addresses

INSERT INTO Address (Line1, Line2, Postcode, Town, County)
VALUES ('Address1', 'Address1', 'CBW3ESD', 'Cambridge', 'Cambridgeshire'),
       ('Address2', 'Address2', 'CBW3ESG', 'Cambridge', 'Cambridgeshire'),
       ('Address3', 'Address3', 'CBW3ES3', 'Cambridge', 'Cambridgeshire'),
       ('Address4', 'Address4', 'CBW3ES4', 'Cambridge', 'Cambridgeshire'),
       ('Address5', 'Address5', 'CBW3ES4', 'Cambridge', 'Cambridgeshire'),
       ('Address6', 'Address6', 'CBW3ES1', 'Cambridge', 'Cambridgeshire'),
       ('Address7', 'Address7', 'CBW3ES2', 'Cambridge', 'Cambridgeshire'),
       ('Address8', 'Address8', 'CBW3ES3', 'Cambridge', 'Cambridgeshire'),
       ('Address9', 'Address9', 'CBW3ES7', 'Cambridge', 'Cambridgeshire'),
       ('Address10', 'Address10', 'CBW3ES8', 'Cambridge', 'Cambridgeshire'),
       ('Branch1', 'Branch1', 'CBW3ED8', 'Cambridge', 'Cambridgeshire');

SET @Address1 = LAST_INSERT_ID();
SET @Address2 = @Address1 + 1;
SET @Address3 = @Address1 + 2;
SET @Address4 = @Address1 + 3;
SET @Address5 = @Address1 + 4;
SET @Address6 = @Address1 + 5;
SET @Address7 = @Address1 + 6;
SET @Address8 = @Address1 + 7;
SET @Address9 = @Address1 + 8;
SET @Address10 = @Address1 + 9;
SET @BranchAddress = @Address1 + 10;


# Create 10 Users
INSERT INTO User (FirstName, LastName, Email, Phone, AddressId)
VALUES ('Dave', 'Bloggs', 'dave.bloggs@example.com', '03674489173', @Address1),
       ('Joe', 'Bloggs', 'joe.bloggs@example.com', '07366487265', @Address2),
       ('Sam', 'Bloggs', 'sam.bloggs@example.com', '07788112233', @Address3),
       ('Lisa', 'Bloggs', 'lisa.bloggs@example.com', '01234567890', @Address4),
       ('Chris', 'Bloggs', 'chris.bloggs@example.com', '09876543210', @Address5),
       ('Emily', 'Bloggs', 'emily.bloggs@example.com', '07111222333', @Address6),
       ('Alex', 'Bloggs', 'alex.bloggs@example.com', '07444555666', @Address7),
       ('Sarah', 'Bloggs', 'sarah.bloggs@example.com', '01617778888', @Address8),
       ('Mike', 'Bloggs', 'mike.bloggs@example.com', '01704990011', @Address9),
       ('Karen', 'Bloggs', 'karen.bloggs@example.com', '07999888777', @Address10),
       ('David', 'Bloggs', 'david.bloggs@example.com', '07712345678', @Address9),
       ('Olivia', 'Bloggs', 'olivia.bloggs@example.com', '01319876543', @Address8),
       ('George', 'Bloggs', 'george.bloggs@example.com', '07900112233', @Address7),
       ('Hannah', 'Bloggs', 'hannah.bloggs@example.com', '02075551212', @Address6),
       ('Liam', 'Bloggs', 'liam.bloggs@example.com', '07888999000', @Address5);

SET @User1 = LAST_INSERT_ID();
SET @User2 = @User1 + 1;
SET @User3 = @User1 + 2;
SET @User4 = @User1 + 3;
SET @User5 = @User1 + 4;
SET @User6 = @User1 + 5;
SET @User7 = @User1 + 6;
SET @User8 = @User1 + 7;
SET @User9 = @User1 + 8;
SET @User10 = @User1 + 9;
SET @Volunteer1 = @User1 + 10;
SET @Volunteer2 = @User1 + 11;
SET @Volunteer3 = @User1 + 12;
SET @Volunteer4 = @User1 + 13;
SET @Volunteer5 = @User1 + 14;


# Create a branch
INSERT INTO Branch (BranchName, AddressId)
VALUES ('Wood Green', @BranchAddress);

# Create 10 medical statuses
INSERT INTO MedicalStatus (CurrentMedication, MedicalHistory)
VALUES ('N/A', 'N/A'),
       ('Bravecto (flea/tick)', 'Routine vaccinations, last dental cleaning 6 months ago.'),
       ('Rimadyl 50mg (twice daily)', 'Chronic arthritis in hips and elbows, diagnosed 2 years ago.'),
       ('Insulin (2 units/day)', 'Type I Diabetes Mellitus (DM), diagnosed 6 months ago. Requires strict diet.'),
       ('Clavamox (antibiotic)', 'Recent ear infection (Otitis Externa), follow-up required in 1 week.'),
       ('Vetmedin 5mg (twice daily)', 'Congestive Heart Failure (CHF), ongoing monitoring of fluid retention.'),
       ('Benadryl (as needed)', 'Seasonal allergies, mild dermatitis history.'),
       ('Metacam (once daily)', 'Acute back pain episode, restricted activity for 10 days.'),
       ('Thyroxine 0.1mg', 'Hypothyroidism, blood work re-check due next month.'),
       ('Droncit (dewormer)', 'Routine deworming, no significant history.');

SET @Medic1 = LAST_INSERT_ID();
SET @Medic2 = @Medic1 + 1;
SET @Medic3 = @Medic1 + 2;
SET @Medic4 = @Medic1 + 3;
SET @Medic5 = @Medic1 + 4;
SET @Medic6 = @Medic1 + 5;
SET @Medic7 = @Medic1 + 6;
SET @Medic8 = @Medic1 + 7;
SET @Medic9 = @Medic1 + 8;
SET @Medic10 = @Medic1 + 9;

# Create 10 adoption progress
INSERT INTO AdoptionProgress (AdoptionStatus, Notes, StatusUpdateAt)
VALUES ('In Branch', 'Initial health check complete. Scheduled for first vaccinations.', '2025-10-01'),
       ('In Branch', 'Ready to be viewed by the public.', '2025-10-05'),
       ('Adoption In progress', 'Application received from the Bloggs family.', '2025-10-15'),
       ('Adoption In progress', 'Applicant screening passed. Reference checks initiated.', '2025-10-17'),
       ('Awaiting Home visit', 'All checks complete. Home visit scheduled for 2025-10-25.', '2025-10-20'),
       ('Awaiting Home visit', 'Home visit completed and approved by coordinator.', '2025-10-25'),
       ('In Branch', 'Adoption fee processed and contract signed.', '2025-10-27'),
       ('Adoption In progress', 'Potential adopter met the animal and bonded well. Pending application review.',
        '2025-11-01'),
       ('In Branch', 'Has some minor behavioral issues that require an experienced owner.', '2025-11-05'),
       ('In Branch', 'Final follow-up call scheduled in two weeks.', '2025-11-15');

SET @ProgressId1 = LAST_INSERT_ID();
SET @ProgressId2 = @ProgressId1 + 1;
SET @ProgressId3 = @ProgressId1 + 2;
SET @ProgressId4 = @ProgressId1 + 3;
SET @ProgressId5 = @ProgressId1 + 4;
SET @ProgressId6 = @ProgressId1 + 5;
SET @ProgressId7 = @ProgressId1 + 6;
SET @ProgressId8 = @ProgressId1 + 7;
SET @ProgressId9 = @ProgressId1 + 8;
SET @ProgressId10 = @ProgressId1 + 9;

# Create some adoption progress history
INSERT INTO AdoptionProgressHistory (AdoptionProgressId, AdoptionStatus, StatusUpdateAt, Notes)
VALUES (@ProgressId3, 'In Branch', '2025-09-01', 'Animal first arrived at the branch.'),
       (@ProgressId3, 'Adoption In progress', '2025-10-15', 'Application received from the Bloggs family.'),
       (@ProgressId3, 'Awaiting Home visit', '2025-10-20', 'Scheduled for home visit.'),
       (@ProgressId3, 'Adopted', '2025-10-27', 'Adoption fee processed and contract signed, animal left with family.'),
       (@ProgressId5, 'In Branch', '2025-09-10', 'Animal ready for viewing.'),
       (@ProgressId5, 'Adoption In progress', '2025-10-15', 'Initial interest shown by applicant.'),
       (@ProgressId5, 'Awaiting Home visit', '2025-10-25', 'Home visit completed and approved.'),
       (@ProgressId5, 'Adopted', '2025-11-05', 'Finalised adoption. Pick-up arranged.'),
       (@ProgressId7, 'In Branch', '2025-09-20', 'Vaccination booster given.'),
       (@ProgressId7, 'Adoption In progress', '2025-10-01', 'Application received (fast-tracked).'),
       (@ProgressId7, 'Adopted', '2025-10-10', 'Quick adoption due to immediate match and prior checks.');

# Create 10 animals
INSERT INTO Animal (BranchId, Name, Type, Breed, DOB, Size, Description, MedicalStatusId, AdoptionProgressId)
VALUES (1, 'Rocky', 'Dog', 'Labrador Retriever', '2023-01-15', 'Large', 'N/A', @Medic1, @ProgressId1),
       (1, 'Daisy', 'Dog', 'Beagle', '2024-05-20', 'Medium', 'N/A', @Medic2, @ProgressId2),
       (1, 'Charlie', 'Dog', 'German Shepherd', '2022-11-01', 'Large', 'N/A', @Medic3, @ProgressId3),
       (1, 'Luna', 'Dog', 'French Bulldog', '2024-03-10', 'Small', 'N/A', @Medic4, @ProgressId4),
       (1, 'Max', 'Dog', 'Golden Retriever', '2021-07-25', 'Large', 'N/A', @Medic5, @ProgressId5),
       (1, 'Bella', 'Dog', 'Cocker Spaniel', '2023-09-08', 'Medium', 'N/A', @Medic6, @ProgressId6),
       (1, 'Toby', 'Dog', 'Poodle (Toy)', '2024-01-20', 'Small', 'N/A', @Medic7, @ProgressId7),
       (1, 'Zoe', 'Dog', 'Boxer', '2022-04-12', 'Large', 'N/A', @Medic8, @ProgressId8),
       (1, 'Finn', 'Dog', 'Siberian Husky', '2023-06-30', 'Large', 'N/A', @Medic9, @ProgressId9),
       (1, 'Kiki', 'Dog', 'Dachshund', '2024-02-05', 'Small', 'N/A', @Medic10, @ProgressId10);

# Create 3 campaigns
INSERT INTO Campaign (Name, Description, StartDate, EndDate)
VALUES ('Summer Adoption Drive 2026',
        'Promoting adoptions during the peak summer months. Fee discounts for senior pets.', '2026-06-01',
        '2026-08-31'),
       ('Medical Fundraiser',
        'Urgent campaign to raise funds for large unexpected medical costs (e.g., major surgery).', '2025-11-25',
        '2025-12-31'),
       ('Sponsor a Pet',
        'Ongoing campaign encouraging monthly sponsorship for long-term residents and special needs animals.',
        '2025-01-01', '2025-05-05');

SET @Campaign1 = LAST_INSERT_ID();
SET @Campaign2 = @Campaign1 + 1;
SET @Campaign3 = @Campaign1 + 2;

# Create 10 payment methods
INSERT INTO PaymentMethod (UserId, PaymentMethodType)
VALUES (@User1, 'Direct Debit'),
       (@User2, 'Card'),
       (@User3, 'Direct Debit'),
       (@User4, 'Card'),
       (@User5, 'Direct Debit'),
       (@User6, 'Card'),
       (@User7, 'Direct Debit'),
       (@User8, 'Card'),
       (@User9, 'Direct Debit'),
       (@User10, 'Card');

SET @PMethod1 = LAST_INSERT_ID();
SET @PMethod2 = @PMethod1 + 1;
SET @PMethod3 = @PMethod1 + 2;
SET @PMethod4 = @PMethod1 + 3;
SET @PMethod5 = @PMethod1 + 4;
SET @PMethod6 = @PMethod1 + 5;
SET @PMethod7 = @PMethod1 + 6;
SET @PMethod8 = @PMethod1 + 7;
SET @PMethod9 = @PMethod1 + 8;
SET @PMethod10 = @PMethod1 + 9;

INSERT INTO DirectDebitDetails (PaymentMethodId, SortCode, AccountNumber, AccountHolderName)
VALUES (@PMethod1, '20-10-10', '9876543210', 'Dave Bloggs'),
       (@PMethod3, '30-20-20', '1234567890', 'Sam Bloggs'),
       (@PMethod5, '40-30-30', '1122334455', 'Chris Bloggs'),
       (@PMethod7, '50-40-40', '6677889900', 'Alex Bloggs'),
       (@PMethod9, '60-50-50', '5432109876', 'Mike Bloggs');

INSERT INTO CardDetails (PaymentMethodId, CardNumber, ExpDate, SecurityCode, BillingAddressId)
VALUES (@PMethod2, '4123456789012345', '2027-12-01', '123', @Address1),
       (@PMethod4, '5123456789012345', '2026-06-01', '456', @Address2),
       (@PMethod6, '4444555566667777', '2028-01-01', '789', @Address3),
       (@PMethod8, '5555444433332222', '2025-10-01', '012', @Address4),
       (@PMethod10, '6011777788889999', '2029-03-01', '345', @Address5);

# Create 10 donations
INSERT INTO RecurringDonation (UserId, PaymentMethodId, AmountPerPayment, StartDate, FreqInDays, NextPaymentDate,
                               IsActive)
VALUES (@User1, @PMethod1, 10.00, '2025-10-01', 30, '2025-11-01', TRUE),
       (@User2, @PMethod2, 25.00, '2025-09-15', 30, '2025-10-15', TRUE),
       (@User3, @PMethod3, 5.00, '2024-12-01', 90, '2025-03-01', TRUE),
       (@User4, @PMethod4, 50.00, '2025-08-01', 30, '2025-09-01', TRUE),
       (@User5, @PMethod5, 15.00, '2025-11-01', 30, '2025-12-01', FALSE);

SET @RecurringDonation1 = LAST_INSERT_ID();
SET @RecurringDonation2 = @RecurringDonation1 + 1;
SET @RecurringDonation3 = @RecurringDonation1 + 2;
SET @RecurringDonation4 = @RecurringDonation1 + 3;
SET @RecurringDonation5 = @RecurringDonation1 + 4;

INSERT INTO Donation (UserId, Amount, DonationDate, PaymentMethodId, CampaignId, RecurringDonationId)
VALUES (@User1, 10.00, '2025-10-01', @PMethod1, NULL, @RecurringDonation1),
       (@User2, 25.00, '2025-09-15', @PMethod2, NULL, @RecurringDonation2),
       (@User3, 5.00, '2024-12-01', @PMethod3, NULL, @RecurringDonation3),
       (@User4, 50.00, '2025-10-01', @PMethod4, NULL, @RecurringDonation4),
       (@User5, 15.00, '2025-11-01', @PMethod5, NULL, @RecurringDonation5),
       (@User6, 100.00, '2025-12-10', @PMethod6, @Campaign2, NULL),
       (@User7, 20.00, '2026-07-20', @PMethod7, @Campaign1, NULL),
       (@User8, 500.00, '2025-10-25', @PMethod8, NULL, NULL),
       (@User9, 5.00, '2025-12-01', @PMethod9, NULL, NULL),
       (@User10, 30.00, '2025-02-15', @PMethod10, @Campaign3, NULL);

# Create 10 assignments
INSERT INTO Assignment (AnimalId, AdoptionFormId, CampaignId)
VALUES (1, NULL, NULL),
       (2, NULL, @Campaign1),
       (3, NULL, NULL),
       (4, NULL, @Campaign2),
       (5, NULL, NULL),
       (6, NULL, @Campaign3),
       (7, NULL, NULL),
       (8, NULL, @Campaign1),
       (9, NULL, NULL),
       (10, NULL, @Campaign2);

SET @Assignment1 = LAST_INSERT_ID();
SET @Assignment2 = @Assignment1 + 1;
SET @Assignment3 = @Assignment1 + 2;
SET @Assignment4 = @Assignment1 + 3;
SET @Assignment5 = @Assignment1 + 4;
SET @Assignment6 = @Assignment1 + 5;
SET @Assignment7 = @Assignment1 + 6;
SET @Assignment8 = @Assignment1 + 7;
SET @Assignment9 = @Assignment1 + 8;
SET @Assignment10 = @Assignment1 + 9;

INSERT INTO Role (UserId, Salary, RoleType, IsActive)
VALUES (@Volunteer1, NULL, 'Volunteer', TRUE),
       (@Volunteer2, NULL, 'Volunteer', TRUE),
       (@Volunteer3, NULL, 'Volunteer', TRUE),
       (@Volunteer4, NULL, 'Volunteer', TRUE),
       (@Volunteer5, NULL, 'Volunteer', TRUE);

SET @Role1 = LAST_INSERT_ID();
SET @Role2 = @Role1 + 1;
SET @Role3 = @Role1 + 2;
SET @Role4 = @Role1 + 3;
SET @Role5 = @Role1 + 4;


INSERT INTO RoleAssignments (RoleId, AssignmentId)
VALUES (@Role1, @Assignment1),
       (@Role1, @Assignment2),
       (@Role2, @Assignment3),
       (@Role3, @Assignment4),
       (@Role3, @Assignment5),
       (@Role3, @Assignment6),
       (@Role4, @Assignment7),
       (@Role4, @Assignment8),
       (@Role5, @Assignment9),
       (@Role5, @Assignment10);
