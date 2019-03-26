CREATE FUNCTION dbo.fnGetAllUsers ()
RETURNS table
AS
RETURN 
(
     SELECT u.[UserId]
		  ,u.[UserName]
		  ,u.[LastActivityDate]
		  ,u.[Phone]
		  ,u.[Pwd]
		  ,m.Email
		  ,m.CreateDate
		  ,m.IsLockedOut
		  ,CAST(dbo.fnCheckUserInRole(u.[UserId], 'Vendor') as bit) as IsVendor
	FROM [dbo].[Users] u
	LEFT JOIN [dbo].[Memberships] m
		ON u.UserId = m.UserId
	GROUP BY 
			u.[UserId]
			,u.[UserName]
			,u.[LastActivityDate]
			,u.[Phone]
			,u.[Pwd]
			,m.Email
			,m.CreateDate
			,m.IsLockedOut
			,CAST(dbo.fnCheckUserInRole(u.[UserId], 'Vendor') as bit)
);
GO