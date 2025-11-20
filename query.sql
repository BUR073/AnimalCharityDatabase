use animal;

# List all animals currently in care, with their medical status - WORKS
SELECT a.Name AS AnimalName,
       a.Type,
       a.Breed,
       b.BranchName,
       a.AdoptionStatus,
       ms.CurrentMedication,
       ms.MedicalHistory
FROM Animal a
         JOIN
     AdoptionProgress ap ON a.AdoptionProgressId = ap.AdoptionProgressId
         JOIN
     Branch b ON a.BranchId = b.BranchId
         LEFT JOIN
     MedicalStatus ms ON a.MedicalStatusId = ms.MedicalStatusId
WHERE ap.AdoptionStatus <> 'Adopted';

# Identify top donors by contribution - WORKS
SELECT u.FirstName,
       u.LastName,
       u.Email,
       SUM(d.Amount) AS TotalDonated
FROM User u
         JOIN
     Donation d ON u.UserId = d.UserId
GROUP BY u.UserId, u.FirstName, u.LastName, u.Email
ORDER BY TotalDonated DESC;


# Show volunteer who is the most active - WORKS
SELECT u.FirstName,
       u.LastName,
       COUNT(ra.AssignmentId) AS TotalAssignments
FROM User u
         JOIN
     Role r ON u.UserId = r.UserId
         JOIN
     RoleAssignments ra ON r.RoleId = ra.RoleId
WHERE r.RoleType = 'Volunteer'
  AND r.IsActive = TRUE
GROUP BY u.UserId, u.FirstName, u.LastName
ORDER BY TotalAssignments DESC
LIMIT 1;


# Show total donations received in a given campaign or month
#     TODO: Update these so that you can choose campaign/month rather than show them all
# Campaign
SELECT c.Name              AS CampaignName,
       COUNT(d.DonationId) AS TotalDonationsCount,
       SUM(d.Amount)       AS TotalAmountReceived
FROM Donation d
         JOIN
     Campaign c ON d.CampaignId = c.CampaignId
GROUP BY c.CampaignId, c.Name
ORDER BY TotalAmountReceived DESC;

# Month
SELECT DATE_FORMAT(DonationDate, '%Y-%m') AS DonationMonth,
       COUNT(DonationId)                  AS TotalDonationsCount,
       SUM(Amount)                        AS TotalAmountReceived
FROM Donation
GROUP BY DonationMonth
ORDER BY DonationMonth DESC;

# Track the number of animals rehomed in a specific year - DOES NOT WORK
# TODO: make it work
SELECT COUNT(AnimalId)         AS AnimalsRehomedCount,
       YEAR(ap.StatusUpdateAt) AS RehomingYear
FROM Animal a
         JOIN
     AdoptionProgress ap ON a.AdoptionProgressId = ap.AdoptionProgressId
WHERE ap.AdoptionStatus = 'Adopted'
  AND YEAR(ap.StatusUpdateAt) = 2024
GROUP BY RehomingYear;