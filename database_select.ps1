Import-Module SqlServer

$serverInstance = "localhost"
$databaseName   = "TestDB"
$outputFile     = ".\result.csv"

$query = "SELECT ID, FirstName, LastName, Age FROM dbo.Person;"

try {
    $rows = Invoke-Sqlcmd `
        -ServerInstance $serverInstance `
        -Database $databaseName `
        -Query $query `
        -TrustServerCertificate

    $rows | Export-Csv -Path $outputFile -NoTypeInformation -Encoding UTF8

    Write-Host "Data fra dbo.Person er gemt i filen '$outputFile'."

    Import-Csv .\result.csv | Format-Table -AutoSize
}
catch {
    Write-Host "FEJL ved SELECT/Export: $($_.Exception.Message)"
}
