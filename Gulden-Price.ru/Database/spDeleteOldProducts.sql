CREATE PROCEDURE  [dbo].[spDeleteOldProducts]
(
	@UserID uniqueidentifier,
    @RecordCount INT OUTPUT
)
AS
BEGIN
	delete from Products
	where UserID = @UserID
	AND WhenDate < DATEADD(day, -1, GETDATE())
	
	SET @RecordCount = @@ROWCOUNT

	RETURN
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[spDeleteOldProducts] TO PUBLIC
    AS [dbo];