# Code by Sai Avinash Sattiraju 



# 1 Solution
select CompanyName, ContactName
from Customers Where ContactName regexp 'Horst Kloss';
# Comment: I just used the regular expression to find Horst Kloss.             

# 2 Solution
select OrderID, OrderDate,ShippedDate, (-right(left(OrderDate,10),2)+ right(left(ShippedDate,10),2)) as duration_to_ship
from Orders
order by duration_to_ship desc
LIMIT 5;
# Comment: I am limiting to 5 as we need the highest shipping time after order is placed. I could have limited it to 1
# but, there are multiple equal longest ship times.

#3 Solution
select count(*), P.CategoryID
from Orders O
	join OrderDetails D
		on O.OrderID = D.OrderID
    join Products P
		on P.ProductID = D.ProductID
group by P.CategoryID;


# Comment - Straight forward problem - I needed to do a simple join and then count after a group by on category.


#4 Solution

select EmployeeID,FirstName, LastName, orders 
from   (select count(*) as orders,O.EmployeeID,E.FirstName,E.LastName
	from Employees E
		join Orders O
			on O.EmployeeID = E.EmployeeID
		group by O.EmployeeID) B
where B.orders  > (select avg(orders) as 'average' from
	(select count(*) as 'orders'
	from Employees E
		join Orders O
			on O.EmployeeID = E.EmployeeID
		group by O.EmployeeID) orderstab)  ;
        
        
# Comment: I am basically doing three subqueries. The first subquery is to extract the required colums from employees
# and orders. It calculates the number of orders served by each employyee. The secont subquery calculates the average 
# based on another subquery which caclulates orders serviced by different employees.         