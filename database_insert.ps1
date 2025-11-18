Import-Module SqlServer

$serverInstance = "localhost"
$databaseName   = "TestDB"

$sql = @"
IF OBJECT_ID('dbo.Person', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Person
    (
        ID        INT IDENTITY(1,1) PRIMARY KEY,
        FirstName NVARCHAR(50),
        LastName  NVARCHAR(50),
        Age       INT
    );
END;

INSERT INTO dbo.Person (FirstName, LastName, Age)
VALUES
    ('Anna',  'Jensen', 25),
    ('Peter', 'Nielsen', 32),
    ('Lars',  'Hansen', 41);
"@

try {
    Invoke-Sqlcmd `
        -ServerInstance $serverInstance `
        -Database $databaseName `
        -Query $sql `
        -TrustServerCertificate

    Write-Host "Tabel 'Person' er oprettet (hvis den ikke fandtes) og data er indsat."
}
catch {
    Write-Host "FEJL ved oprettelse/insert i Person: $($_.Exception.Message)"
}
