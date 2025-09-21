@echo off

:: Smyèka pro získání sériového èísla z BIOSu
for /f "skip=1 tokens=*" %%i in ('wmic bios get serialnumber') do (
    set "SerialNumber=%%i"
    goto :found
)
:found

:: Odstranìní pøípadných mezer na konci
set SerialNumber=%SerialNumber: =%

:: NOVÝ KROK: Zkrácení sériového èísla na prvních 6 znakù
set "ShortSerial=%SerialNumber:~0,6%"

:: Pøejmenování poèítaèe s použitím zkráceného èísla
wmic computersystem where name="%COMPUTERNAME%" call rename name="B9-PII-B2%ShortSerial%"

:: Vynucený restart
shutdown /r /t 5

exit /b 0