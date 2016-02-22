
@echo off
setlocal EnableDelayedExpansion
set A=C:\ProgramData\chocolatey;C:\php;C:\Program Files\git\cmd
set pathToInsert=%A%
rem Check if pathToInsert is not already in system path
if "!path:%pathToInsert%=!" equ "%path%" (
   setx PATH "%PATH%;%A%"  
timeout 30
)else (
echo "Path is already added"
)
