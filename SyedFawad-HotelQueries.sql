USE Hotel;
-- 1. Write a query that returns a list of reservations that end in July 2023, including the name of the guest, the room number(s), and the reservation dates.
Select 
	g.`Name`,
    r.RoomNum,
    r.StartDate,
    r.EndDate
FROM Reservation r
INNER JOIN Guest g
	ON r.GuestID = g.GuestID
WHERE EndDate > "2023-06-30" AND EndDate < "2023-08-01";

/*Name	RoomNum	StartDate	EndDate
Syed Fawad	205	6/28/2023	7/2/2023
Walter Holaway	204	7/13/2023	7/14/2023
Wilfred Vise	401	7/18/2023	7/21/2023
Bettyann Seery	303	7/28/2023	7/29/2023*/

-- 2.Write a query that returns a list of all reservations for rooms with a jacuzzi, displaying the guest's name, the room number, and the dates of the reservation.
Select 
	g.`Name`,
    r.RoomNum,
    r.StartDate,
    r.EndDate
FROM Reservation r
INNER JOIN Guest g
	ON r.GuestID = g.GuestID
INNER JOIN Room room
	ON r.RoomNum = room.RoomNum
WHERE room.Amenity2 = "Jacuzzi" OR room.Amenity3 = "Jacuzzi";

/*Name	RoomNum	StartDate	EndDate
Karie Yang	201	3/6/2023	3/7/2023
Bettyann Seery	203	2/5/2023	2/10/2023
Karie Yang	203	9/13/2023	9/15/2023
Syed Fawad	205	6/28/2023	7/2/2023
Wilfred Vise	207	4/23/2023	4/24/2023
Walter Holaway	301	4/9/2023	4/13/2023
Mack Simmer	301	11/22/2023	11/25/2023
Bettyann Seery	303	7/28/2023	7/29/2023
Duane Cullison	305	2/23/2023	2/24/2023
Bettyann Seery	305	8/30/2023	9/1/2023
Syed Fawad	307	3/17/2023	3/20/2023
*/

-- 3.Write a query that returns all the rooms reserved for a specific guest, including the guest's name, the room(s) reserved, the starting date of the reservation, and how many people were included in the reservation. (Choose a guest's name from the existing data.)
Select 
	g.`Name`,
    r.RoomNum,
    r.StartDate,
    r.EndDate,
    (r.adults + r.children) AS TotalPeople
FROM Reservation r
INNER JOIN Guest g
	ON r.GuestID = g.GuestID
WHERE r.GuestID = 2;

/*Name	RoomNum	StartDate	EndDate	TotalPeople
Mack Simmer	308	2/2/2023	4/2/2023	1
Mack Simmer	208	9/16/2023	9/17/2023	2
Mack Simmer	206	11/22/2023	11/25/2023	2
Mack Simmer	301	11/22/2023	11/25/2023	4
*/

-- 4. Write a query that returns a list of rooms, reservation ID, and per-room cost for each reservation. The results should include all rooms, whether or not there is a reservation associated with the room.
SELECT
	r.ReservationID,
    room.RoomNum,
    room.BasePrice,
    r.TotalCost
FROM Room room
LEFT JOIN Reservation r
	ON R.RoomNum = room.RoomNum;

/*ReservationID	RoomNum	BasePrice	TotalCost
4	201	199.99	199.99
7	202	174.99	349.98
2	203	199.99	999.95
21	203	199.99	399.98
16	204	174.99	184.99
15	205	174.99	699.96
12	206	149.99	599.96
23	206	149.99	449.97
10	207	174.99	174.99
13	208	149.99	599.96
20	208	149.99	149.99
9	301	199.99	799.96
24	301	199.99	599.97
6	302	174.99	924.95
25	302	174.99	699.96
18	303	199.99	199.99
14	304	174.99	184.99
3	305	174.99	349.98
19	305	174.99	349.98
NULL	306	149.99	NULL
5	307	174.99	524.97
1	308	149.99	299.98
11	401	399.99	1199.97
17	401	399.99	1259.97
22	401	399.99	1199.97
NULL	402	399.99	NULL
*/

-- 5. Write a query that returns all the rooms accommodating at least three guests and that are reserved on any date in April 2023.
Select 
    RoomNum,
    StartDate,
    EndDate,
    (adults + children) AS TotalPeople
FROM Reservation
WHERE (adults + children) >= 3 
AND (Month(StartDate) = 4 OR MONTH(EndDate) = 4);

-- RoomNum	StartDate	EndDate	TotalPeople

-- 6. Write a query that returns a list of all guest names and the number of reservations per guest, sorted starting with the guest with the most reservations and then by the guest's last name.
Select 
	SUBSTRING_INDEX(Guest.`Name`, ' ', -1) AS LastName,
	COUNT(Reservation.GuestID) AS TotalReservations
FROM Reservation
INNER JOIN Guest
	ON Reservation.GuestID = Guest.GuestID
GROUP BY LastName
ORDER BY TotalReservations DESC;

/*LastName	TotalReservations
Simmer	4
Seery	3
Fawad	2
Cullison	2
Yang	2
Lipton	2
Holaway	2
Vise	2
Tilton	2
Tison	2
Luechtefeld	1
*/

-- 7. Write a query that displays the name, address, and phone number of a guest based on their phone number. (Choose a phone number from the existing data.)
SELECT `Name`, Address, Phone
FROM Guest
WHERE Phone = "(478) 277-9632";

/*Name	Address	Phone
Bettyann Seery	750 Wintergreen Dr.	(478) 277-9632 */