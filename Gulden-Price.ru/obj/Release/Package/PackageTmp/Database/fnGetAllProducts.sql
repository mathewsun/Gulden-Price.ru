ALTER FUNCTION dbo.fnGetAllProducts (
	@filter nvarchar(max),
	@sort varchar(20) = 'Name',
	@dir varchar(20) = 'asc',
	@size int = 10,
	@page_num int = 0
)
RETURNS @rtnTable TABLE
(
    -- columns returned by the function
    Id int NOT NULL,
    Name nvarchar(MAX) NOT NULL,
	Price float NOT NULL,
	UserID UNIQUEIDENTIFIER NOT NULL,
	WhenDate datetime NOT NULL,
	UserName nvarchar(50) NOT NULL,
	Phone nvarchar(MAX),
	VendorName nvarchar(MAX)
)
AS
BEGIN

;
	
DECLARE @first_row  int = @page_num * @size + 1
DECLARE @end_row  int = @first_row + @size - 1	

;

WITH up AS
		(
			SELECT	p.[Id]
					,p.[Name]
					,p.[Price]
					,p.[UserID]
					,p.[WhenDate]
					,u.[UserName]
					,u.[Phone]
					,u.[VendorName]
					, ROW_NUMBER() OVER (ORDER BY
									case when @sort = 'name' and @dir = 'asc' 
										then p.Name end asc, 
									case when @sort = 'name' and @dir = 'desc' 
										then p.Name end desc,
									
									case when @sort = 'price' and @dir = 'asc' 
										then p.Price end asc, 
									case when @sort = 'price' and @dir = 'desc' 
										then p.Price end desc,
										
									case when @sort = 'vendor' and @dir = 'asc' 
										then u.UserName end asc, 
									case when @sort = 'vendor' and @dir = 'desc' 
										then u.UserName end desc
								) as row_num
			FROM [dbo].Products p
			LEFT JOIN [dbo].[Users] u
				ON u.UserId = p.UserId
			WHERE @Filter IS NULL OR p.[Name] LIKE '%'+@filter+'%'
		)

insert into @rtnTable
SELECT	[Id]
		,[Name]
		,[Price]
		,[UserID]
		,[WhenDate]
		,[UserName]
		,[Phone]
		,[VendorName] 
FROM up
WHERE row_num >= @first_row and row_num <= @end_row

return
END
