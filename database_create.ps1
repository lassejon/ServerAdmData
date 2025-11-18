Import-Module SqlServer

$serverInstance = "localhost"
$databaseName   = "TestDB"

$sql = @"
IF DB_ID('$databaseName') IS NULL
BEGIN
    CREATE DATABASE [$databaseName];
END
"@

try {
    Invoke-Sqlcmd `
        -ServerInstance $serverInstance `
        -Database "master" `
        -Query $sql `
        -TrustServerCertificate

    Write-Host "Database '$databaseName' er oprettet (eller fandtes allerede)."
}
catch {
    Write-Host "FEJL ved oprettelse af database: $($_.Exception.Message)"
}
