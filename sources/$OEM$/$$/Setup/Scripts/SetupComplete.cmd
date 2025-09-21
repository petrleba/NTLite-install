@echo off

:: Smy�ka pro z�sk�n� s�riov�ho ��sla z BIOSu
for /f "skip=1 tokens=*" %%i in ('wmic bios get serialnumber') do (
    set "SerialNumber=%%i"
    goto :found
)
:found

:: Odstran�n� p��padn�ch mezer na konci
set SerialNumber=%SerialNumber: =%

:: NOV� KROK: Zkr�cen� s�riov�ho ��sla na prvn�ch 6 znak�
set "ShortSerial=%SerialNumber:~0,6%"

:: P�ejmenov�n� po��ta�e s pou�it�m zkr�cen�ho ��sla
wmic computersystem where name="%COMPUTERNAME%" call rename name="B9-PII-B2%ShortSerial%"

:: Vynucen� restart
shutdown /r /t 5

exit /b 0