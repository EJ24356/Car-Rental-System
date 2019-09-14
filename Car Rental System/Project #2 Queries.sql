#Customer wants Nissan vehicle with a milage less than average of total milage
SELECT *
FROM Vehicles
WHERE Mileage < (SELECT AVG(Mileage) FROM Vehicles) AND Brand REGEXP 'Nissan';

#Identify the agent assigned in the reservation with the insurance name, description, and where the rental price is $95.03
SELECT Agent, (SELECT Name, Description FROM Insurance)
FROM Reservation
JOIN Insurance ON Reservation.Insurance_ID = Insurance.idInsurance
JOIN Invoice ON Reservation.idReservation = Invoice.idReservation
WHERE Rental_Price = 95.03;

# Find the names, IDs, and coverage descriptions of insurance companies where the price is less than 30.
SELECT Name, Description, Insurance_ID, Price
FROM Reservation
JOIN Insurance ON Reservation.Insurance_ID = Insurance.idInsurance
JOIN Invoice ON Reservation.idReservation = Invoice.idReservation
GROUP BY Insurance_ID
HAVING Price <=30;

#Identify the name of the customer who had the "AndyDeal" promotion
SELECT idReservation, First_name, Last_name, DOB, Driving_License_No 
FROM Reservation
JOIN Customers ON Reservation.ID_Customers = Customers.idCustomers
JOIN Promotion ON Reservation.idReservation = Promotion.ID_Reservation
WHERE Discount = 32;

#How many agents are in each insurance agency?
SELECT COUNT(idAgent) AS '# of Agents', Agency
FROM Agent
GROUP BY Agency
HAVING COUNT(idAgent);


