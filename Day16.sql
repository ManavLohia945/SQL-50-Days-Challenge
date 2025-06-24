CREATE TABLE Employees7 (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    department VARCHAR(255),
    managerId INT
);

INSERT INTO Employees7 (id, name, department, managerId) VALUES
(101, 'John', 'A', NULL),
(102, 'Dan', 'A', 101),
(103, 'James', 'A', 101),
(104, 'Amy', 'A', 101),
(105, 'Anne', 'A', 101),
(106, 'Ron', 'B', 101),
(107, 'Michael', 'C', NULL),
(108, 'Sarah', 'C', 107),
(109, 'Emily', 'C', 107),
(110, 'Brian', 'C', 107);

SELECT e2.name as manager_name, COUNT(e1.managerid)
FROM Employees7 as e1
JOIN Employees7 as e2
ON e2.id = e1.managerid
WHERE e1.managerid IS NOT NULL
GROUP BY 1
HAVING(COUNT(e1.managerid)>=5)
















