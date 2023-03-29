
use CarWorkshop
go

-- i assume that all data is retrieved on app start to cache, 
-- and all these queries return the minimum data for extraction from cache.

--drop procedure GetCarsHandledCount
--drop procedure GetCarsHandledCountByType
--drop procedure GetTopUsedPartsWithCost
--drop procedure GetEmployeesHours

go

create or alter procedure GetCarsHandledCount
@dateTime datetime = null 
as

set @dateTime = CAST(IIF(@dateTime IS NULL, GETDATE(), @dateTime) as DATE)

select		count(cs.CarLicenseNumber)
from		CarService cs
where		CAST(cs.StartTime AS DATE) = @dateTime
group by	CAST(cs.StartTime AS DATE)


go


create or alter procedure GetCarsHandledCountByType
@from datetime = null,
@to datetime = null
as

set @from = CAST(IIF(@from IS NULL, DATEADD(DAY, -30, GETDATE()), @from) as DATE)
set @to = CAST(IIF(@to IS NULL, GETDATE(), @to) as DATE)

select		c.TypeId, count(cs.CarLicenseNumber) [Count]
from		CarService cs
join		Cars c on c.LicenseNumber = cs.CarLicenseNumber
where		cs.StartTime between @from and @to
group by	c.TypeId
order by	count(cs.CarLicenseNumber) desc


go

create or alter procedure GetTopUsedPartsWithCost
@from datetime = null,
@to datetime = null,
@top int = 10
as

set @from = CAST(IIF(@from IS NULL, DATEADD(DAY, -30, GETDATE()), @from) as DATE)
set @to = CAST(IIF(@to IS NULL, GETDATE(), @to) as DATE)

select			top (@top) pu.PartNumber Part,
				count(pu.PartNumber) [Count],
				cp.Price PerUnit
into			#temp1
from			PartsUsed pu
join			CarParts cp on cp.Number = pu.PartNumber
join			CarService cs on cs.Id = pu.ServiceId
where			cs.StartTime between @from and @to
group by		pu.PartNumber, cp.Price
order by		count(pu.PartNumber) desc

select		t.Part,
			t.[Count],
			t.[Count] * t.PerUnit Cost
from		#temp1 t

drop table #temp1

go


create or alter procedure GetEmployeesHours
@from datetime = null,
@to datetime = null
as

set @from = CAST(IIF(@from IS NULL, DATEADD(DAY, -30, GETDATE()), @from) as DATE)
set @to = CAST(IIF(@to IS NULL, GETDATE(), @to) as DATE)

-- i assume that if a worker was assigned to a car service, then he worked the entire working hours in that date.

select		e.Id, w.WorkingHours PerDay
into		#temp2
from		Employees e
join		CarService cs on cs.AssignedEmployeeId = e.Id
join		Workshops w on w.ManagerId = e.SupervisorId
where		cast(cs.StartTime as date) between @from and @to
group by	cast(cs.StartTime as date), e.Id, w.WorkingHours

select		t.Id,
			(count(t.Id) * t.PerDay) [Hours]
from		#temp2 t
group by	t.Id, t.PerDay

drop table #temp2




