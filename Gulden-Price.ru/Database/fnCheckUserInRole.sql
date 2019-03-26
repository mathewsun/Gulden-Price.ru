CREATE FUNCTION dbo.fnCheckUserInRole (
@UserId uniqueidentifier, 
@RoleName nvarchar(256))
RETURNS float
WITH EXECUTE AS CALLER
AS
BEGIN
     DECLARE @Result bit;
     SET @Result =
	(SELECT CASE WHEN EXISTS (
    SELECT *
    FROM [UsersInRoles] ur
	LEFT JOIN [Roles] r
		ON r.RoleId = ur.RoleId
    WHERE 	ur.UserID = @UserId
			AND r.RoleName = @RoleName
)
THEN CAST(1 AS BIT)
ELSE CAST(0 AS BIT) END);
     RETURN(@Result);
END;
GO