CREATE FUNCTION dbo.fnGetAllProductsCount (
	@filter nvarchar(max)
)
RETURNS int
AS
BEGIN
DECLARE @Result int;
     SET @Result =
	(
		SELECT 	Count(p.[Id])
		FROM 	[dbo].Products p
		WHERE 	@Filter IS NULL OR p.[Name] LIKE '%'+@filter+'%');
     RETURN(@Result);
END;
GO