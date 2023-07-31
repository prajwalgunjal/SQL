Create database AddressBook;

use AddressBook
--drop database AddressBook
--delete from Contacts where Id =2

Create table Contacts 
(
	Id int primary key Identity(1,1),
	FirstName varchar(50),
	LastName varchar(50),
	PhoneNumber1 varchar(50),
	Email varchar(50),
	City varchar(50),
	PinCode varchar(50),
	Country varchar(50),
	Sstate varchar(50)
)

Create table PhoneNumber
(
	PhoneID int Identity(1,1) primary key,
	Id int foreign key references Contacts(Id),
	PhoneNumber2 varchar(50)
)


------------------------------------------------DISPLAY------------------------------------------------------------------------------
CREATE PROCEDURE GetAllContact
AS
BEGIN
	SELECT * From Contacts AS c JOIN PhoneNumber As p ON c.Id = p.Id
END


EXECUTE GetAllContact

-------------------------------------------------ADDCONTACT-----------------------------------------------------------------------------
CREATE PROCEDURE AddContact
	@FirstName VARCHAR(50),
	@LastName VARCHAR(50),
	@PhoneNumber1 VARCHAR(50),
	@PhoneNumber2 varchar(50),
	@Email VARCHAR(50),
	@City VARCHAR(50),
	@PinCode VARCHAR(50),
	@Country VARCHAR(50),
	@Sstate VARCHAR(50)
AS
BEGIN
	DECLARE @Id int
	INSERT INTO Contacts VALUES(@FirstName,@LastName,@PhoneNumber1,@Email,@City,@PinCode,@Country,@Sstate)
	SET @Id = SCOPE_IDENTITY()
	INSERT INTO PhoneNumber VALUES(@Id,@PhoneNumber2)
END
------------------------------------------------Dsiplay by id------------------------------------------------------------------------------
CREATE PROCEDURE GetAllContactByID
@Id int
AS
BEGIN
	SELECT * From Contacts AS c JOIN PhoneNumber As p ON c.Id = p.Id where c.Id = @Id
END


EXECUTE GetAllContact
------------------------------------------------------Delete BY id------------------------------------------------------------------------
Alter PROCEDURE DeleteContactById
@Id int
AS
BEGIN 
	BEGIN TRANSACTION
	BEGIN TRY
	DELETE FROM PhoneNumber WHERE Id = @Id
		DELETE FROM Contacts WHERE Id = @Id
			
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH 
		ROLLBACK TRANSACTION
	END CATCH 
END
EXECUTE DeleteContactById




------------------------------------------------------Update by id----------------------------------------------------------------------------------------------
CREATE PROCEDURE UpdateByID
	@Email VARCHAR(50),
@Id int
AS
BEGIN 
	BEGIN TRANSACTION
	BEGIN TRY
		UPDATE Contacts SET Email = @Email WHERE Id = @Id
		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH 
		ROLLBACK TRANSACTION
	END CATCH 
END


--------------------------------------------------------------------------------------------------------------------------------------------------------

select * from Contacts
select * from PhoneNumber

insert into Contacts values('Prajwal','Gunjal','9881640062','prajwal@gmail.com','Pune','411034','India','maharashtra')
insert into PhoneNumber values (1,'9763145640')
SELECT * From Contacts AS c JOIN PhoneNumber As p ON c.Id = p.Id 

UPDATE Contacts SET Email = 'Pra@gmail.coooooo' WHERE FirstName = 'Prajwal'