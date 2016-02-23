setlocal EnableDelayedExpansion
set A=C:\ProgramData\chocolatey;C:\php;C:\PharaohTools;C:\Program Files\git\cmd
set pathToInsert=%A%
rem Check if pathToInsert is not already in system path
if "!path:%pathToInsert%=!" equ "%path%" (
echo "Adding path"
   setx PATH "%PATH%;%A%"  
timeout 5
)else (
echo "Path is already added"
)
