CREATE PROCEDURE TP_01()

SELECT Customers.First_name,Customers.Last_name
FROM Customers
JOIN Agent ON Customers.Agent_Number = Agent.idAgent
WHERE Agent.Agency IN ('Srini''s Industry');

/**Find the Customer first and last name whose agent works at Srini's Industry**/

CREATE PROCEDURE TP_02()

SELECT Street_Address, City, State
FROM Location
LEFT JOIN Reservation ON Reservation.DropOff_IDLocation = Location.idLocation
WHERE NOT EXISTS ( SELECT * FROM Reservation WHERE Reservation.DropOff_IDLocation = Location.idLocation)
UNION
SELECT Street_Address, City, State
FROM Location
RIGHT JOIN Reservation ON Reservation.DropOff_IDLocation = Location.idLocation
WHERE NOT EXISTS ( SELECT * FROM Reservation WHERE Reservation.DropOff_IDLocation = Location.idLocation);

/**Find the Address, City, and State of Locations that don't have a reservation**/

/**CREATE PROCEDURE TP_03()**/
SELECT categoryName
FROM Vehicles
JOIN Vehicle_Category ON Vehicle_Category.idCategory = Vehicles.idCategory
WHERE Car_Color = 'Maroon'
GROUP BY categoryName;
/**Find the names of different categories of Vehicles that are the color 'Maroon'**/

/**CREATE PROCEDURE TP_04()**/
SELECT First_Name,Last_Name,Rental_Price
FROM Agent
JOIN Reservation ON Agent.idAgent = Reservation.Agent
JOIN Invoice ON Invoice.idReservation = Reservation.idReservation
WHERE Rental_Price > (SELECT AVG(Rental_Price) FROM Invoice)
ORDER BY Rental_Price DESC;
/**Report the Name and Rental Price of Agents that have an invoice greater than the average rental price of invoices.
Sort by rental prices**/

/**CREATE PROCEDURE TP_05()**/
SELECT Agent.First_Name,Agent.Last_Name,Agency,Insurance.Name,COUNT(Customers.idCustomers)
FROM Agent
JOIN Customers ON Agent.idAgent = Customers.Agent_Number
JOIN Reservation ON Reservation.Agent = Agent.idAgent
JOIN Insurance ON Insurance.idInsurance = Reservation.Insurance_ID
WHERE Insurance.Name = (SELECT Insurance.Name FROM Insurance WHERE Insurance.Name = 'Geico')
GROUP BY Agent.First_Name,Agent.Last_Name,Agency,Agent.PhoneNumber,Insurance.Name
HAVING PhoneNumber REGEXP '706';
/**Report the Name, Agency, and the number of Customers that an Agent has that deal with a 'Geico'
Insurance Account, with the exception that their phone number has a 706 area code.**/

/**CREATE PROCEDURE TP_06()**/
SELECT Promotion.Name, Vehicles.Brand,Vehicles.Model,Vehicles.Year_Model
FROM Promotion
JOIN Reservation ON Promotion.ID_Reservation = Reservation.idReservation
JOIN Vehicles ON Reservation.Vehicle_ID = Vehicles.Vehicle_ID
WHERE Promotion.Discount > (SELECT AVG(Discount) FROM Promotion,Reservation 
							WHERE Promotion.ID_Reservation = Reservation.idReservation)
ORDER BY Year_Model DESC;
/** Display the Vehicle Brand, model, year it was modeled
associated with the name of a promotional deal that is going on with it, as long as the
discount is greater than the average of all discounts associated with that promotion**/

/**CREATE PROCEDURE TP_07()**/
SELECT First_name,Last_name,PhoneNumber
FROM Reservation
JOIN Invoice ON Invoice.idReservation = Reservation.idReservation
JOIN Customers ON Customers.idCustomers = Reservation.ID_Customers
WHERE Service_Tax < 2;
/** Display the Name and Phone Number of Customers who have to pay a service Tax less than $2 on the rental 
purchase**/


# Find the names, IDs, Price, and coverage descriptions of insurance companies where the price is less than 30.
/**CREATE PROCEDURE TP_08()**/
SELECT Name, Description, Insurance_ID, Price
FROM Reservation
JOIN Insurance ON Reservation.Insurance_ID = Insurance.idInsurance
JOIN Invoice ON Reservation.idReservation = Invoice.idReservation
GROUP BY Insurance_ID
HAVING Price <=30;

/**CREATE PROCEDURE TP_09()**/
#Identify the name of the customer who had the "AndyDeal" promotion
SELECT idReservation, First_name, Last_name, DOB, Driving_License_No 
FROM Reservation
JOIN Customers ON Reservation.ID_Customers = Customers.idCustomers
JOIN Promotion ON Reservation.idReservation = Promotion.ID_Reservation
WHERE Discount = 32;

/**CREATE PROCEDURE TP_10()**/
#How many agents are in each insurance agency?
SELECT COUNT(idAgent) AS '# of Agents', Agency
FROM Agent
GROUP BY Agency
HAVING COUNT(idAgent);

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




