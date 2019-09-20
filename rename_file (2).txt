#Move Verafin Files From Director to Utility Drive
#By: Trace Watkins
#Date: 6/10/2019


#check to see if there are files in Director folder
if( (Get-ChildItem "T:\Applications\csv reports" | Measure-Object).Count -eq 0)
{
 echo "Folder is empty"
} 

#if files present, move them to the utility drive
else {

#get names of all files in utility drive
$all = Get-ChildItem "T:\Applications\csv reports" -Recurse

#rename files according 
foreach ($name in $all)
{

#get content from first part of document to retrieve date
$date = Get-Date -UFormat "%Y%m%d"
$new_name = $name.Name -replace ".csv","$date.csv"
echo $new_name

#move file and rename
Move-Item -path "T:\Applications\csv reports\move\$name" -destination "T:\Applications\csv reports\moved\$new_name"
}

}