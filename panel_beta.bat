@echo off
setlocal

:: Definicje adresów URL i nazw plików
set "url=https://raw.githubusercontent.com/zupekxyz/zupek-panel/refs/heads/main/panel_beta.bat"
set "local_file=%~f0"
set "temp_file=%temp%\update_temp.bat"

:: Pobieranie nowej wersji do pliku tymczasowego
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%url%', '%temp_file%')"

:: Sprawdzenie, czy nowy plik się różni
fc /b "%local_file%" "%temp_file%" >nul
if %errorlevel% equ 1 (
    echo Nowa wersja dostępna. Aktualizacja...
    copy /Y "%temp_file%" "%local_file%" >nul
    echo Aktualizacja zakończona. Uruchamianie ponownie...
    start "" "%local_file%"
    exit /b
) else (
    echo Masz już najnowszą wersję.
)

:: Dalszy kod 

@echo off
title Pc panel / opt

:: Konsola powitalna
color 00
echo    ███████╗██╗   ██╗██████╗ ███████╗██╗  ██╗██╗  ██╗
echo    ╚══███╔╝██║   ██║██╔══██╗██╔════╝██║ ██╔╝██║ ██╔╝
echo      ███╔╝ ██║   ██║██████╔╝█████╗  █████╔╝ █████╔╝ 
echo     ███╔╝  ██║   ██║██╔═══╝ ██╔══╝  ██╔═██╗ ██╔═██╗ 
echo     ███████╗╚██████╔╝██║     ███████╗██║  ██╗██║  ██╗
echo     ╚══════╝ ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
echo.
echo ============================================================
echo                Zaawansowany System Konsoli
echo ============================================================
pause

:: Ustawienia plików
set "plik_logu=log_systemu.txt"
set "folder_backup=backup"
set "katalog_docelowy=nowy_folder"

:: Sprawdzanie folderów
if not exist "%folder_backup%" mkdir "%folder_backup%"
if not exist "%katalog_docelowy%" mkdir "%katalog_docelowy%"

:: Funkcja menu głównego
:MenuGlowna
cls
echo ============================================================
echo                Zaawansowany System Konsoli
echo ============================================================
echo.
echo [?] Ostatni update: 02.11.2024  00:55
echo [-] 0.1 Beta 
echo [+] Dodano Auto update!
echo [+] Dodano sekcje kolorow
echo [+] Dodano sekcje Pingu  
echo.
echo [1] Przegladanie plikow i folderow
echo [2] Tworzenie kopii zapasowej pliku
echo [3] Wyswietlanie dziennika
echo [4] Wyczysc dziennik
echo [5] Ustawienia
echo [6] Czyszczenie niepotrzebnych plików
echo [7] Optymalizacja systemu Windows
echo [8] Ustawienia BCD
echo [9] Registry Tweaks
echo [10] Dodatkowe ustawienia optymalizacyjne
echo [11] Ping
echo [12] Wybor koloru konsoli
echo [13] Tworca
echo [14] Wyjscie
echo.
set /p "wybor= Wybierz opcje (1-13): "
if "%wybor%"=="1" goto :Przegladanie
if "%wybor%"=="2" goto :KopiaZapasowa
if "%wybor%"=="3" goto :WyswietlDziennik
if "%wybor%"=="4" goto :WyczyscDziennik
if "%wybor%"=="5" goto :Ustawienia
if "%wybor%"=="6" goto :CzyszczenieSystemu
if "%wybor%"=="7" goto :OptymalizacjaSystemu
if "%wybor%"=="8" goto :UstawieniaBCD
if "%wybor%"=="9" goto :RegistryTweaks
if "%wybor%"=="10" goto :DodatkoweOptymalizacje
if "%wybor%"=="11" goto :Ping
if "%wybor%"=="12" goto :Wybierzkolor
if "%wybor%"=="13" goto :Tworca
if "%wybor%"=="14" goto :Koniec
goto :MenuGlowna

:: Sekcja przeglądania plików i folderów
:Przegladanie
cls
echo Lista plikow i folderow:
dir /b
echo.
echo Nacisnij dowolny klawisz, aby powrocic do menu...
pause >nul
goto :MenuGlowna

:: Sekcja tworzenia kopii zapasowej
:KopiaZapasowa
cls
set /p "nazwa_pliku=Podaj nazwe pliku do skopiowania: "
if not exist "%nazwa_pliku%" (
    echo Plik nie istnieje!
    pause
    goto :MenuGlowna
)
copy "%nazwa_pliku%" "%folder_backup%\%nazwa_pliku%"
echo Kopia zapasowa pliku %nazwa_pliku% utworzona w folderze %folder_backup%.
echo [%date% %time%] Kopia zapasowa pliku %nazwa_pliku% >> %plik_logu%
echo.
pause
goto :MenuGlowna

:: Sekcja wyświetlania dziennika
:WyswietlDziennik
cls
if not exist "%plik_logu%" (
    echo Dziennik jest pusty.
) else (
    type %plik_logu%
)
echo.
pause
goto :MenuGlowna

:: Sekcja czyszczenia dziennika
:WyczyscDziennik
cls
echo Czy na pewno chcesz wyczyscic dziennik? (T/N)
set /p "potwierdzenie="
if /i "!potwierdzenie!"=="T" del "%plik_logu%" & echo Dziennik wyczyszczony.
echo.
pause
goto :MenuGlowna

:: Sekcja ustawień
:Ustawienia
cls
echo ============================================================
echo                  Ustawienia Systemu
echo ============================================================
echo.
echo [1] Zmien nazwe folderu backupu (obecny: %folder_backup%)
echo [2] Zmien katalog docelowy (obecny: %katalog_docelowy%)
echo [3] Powrot do menu glownego
echo.
set /p "ustawienie= Wybierz opcje (1-3): "
if "%ustawienie%"=="1" (
    set /p "nowy_backup=Podaj nowa nazwe folderu backupu: "
    set "folder_backup=%nowy_backup%"
    echo Nazwa folderu backupu ustawiona na: %folder_backup%
    pause
    goto :Ustawienia
)
if "%ustawienie%"=="2" (
    set /p "nowy_katalog=Podaj nowa nazwe katalogu docelowego: "
    set "katalog_docelowy=%nowy_katalog%"
    echo Katalog docelowy ustawiony na: %katalog_docelowy%
    pause
    goto :Ustawienia
)
goto :MenuGlowna

:: Sekcja czyszczenia systemu
:CzyszczenieSystemu
cls
echo ============================================================
echo             Czyszczenie Niepotrzebnych Plikow
echo ============================================================
echo.
echo [1] Usun pliki tymczasowe (%temp%)
echo [2] Usun pliki logow systemowych (*.log)
echo [3] Wyczysc cache przegladarki (Chrome)
echo [4] Powrot do menu glownego
echo.
set /p "czyszczenie= Wybierz opcje (1-4): "
if "%czyszczenie%"=="1" (
    echo Czyszczenie plikow tymczasowych...
    del /q /s "%temp%\*.*"
    echo Czyszczenie zakonczone.
    pause
    goto :CzyszczenieSystemu
)
if "%czyszczenie%"=="2" (
    echo Czyszczenie plikow logow...
    for /r C:\ %%G in (*.log) do del "%%G" /q
    echo Czyszczenie zakonczone.
    pause
    goto :CzyszczenieSystemu
)
if "%czyszczenie%"=="3" (
    echo Czyszczenie cache Chrome...
    if exist "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache" (
        del /q /s "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*.*"
        echo Cache Chrome wyczyszczony.
    ) else (
        echo Chrome nie jest zainstalowany lub brak dostepu do cache.
    )
    pause
    goto :CzyszczenieSystemu
)
goto :MenuGlowna

:: Sekcja optymalizacji systemu Windows
:OptymalizacjaSystemu
cls
echo ============================================================
echo             Optymalizacja Systemu Windows
echo ============================================================
echo.
echo [1] Optymalizacja połączenia internetowego
echo [2] Optymalizacja wydajności systemu
echo [3] Powrot do menu glownego
echo.
set /p "opcje= Wybierz opcje (1-3): "
if "%opcje%"=="1" (
    echo Optymalizacja polaczenia internetowego...
    echo.
    echo Ustawienia zakonczone.
    pause
    goto :DodatkoweOptymalizacje
)
if "%opcje%"=="2" (
    echo Optymalizacja wydajnosci systemu...
    echo.
    echo Ustawienia zakonczone.
    pause
    goto :DodatkoweOptymalizacje
)
goto :MenuGlowna

:: Sekcja ustawień BCD
:UstawieniaBCD
cls
echo ============================================================
echo             Ustawienia BCD
echo ============================================================
bcdedit /set useplatformtick yes
bcdedit /set disabledynamictick yes
bcdedit /set bootstatuspolicy ignore
bcdedit /set debug on
echo.
echo Ustawienia BCD zakonczone.
pause
goto :MenuGlowna

:: Sekcja zmiany rejestru
:RegistryTweaks
cls
echo ============================================================
echo             Ustawienia Rejestru
echo ============================================================
echo.
echo Zmieniam ustawienia rejestru...
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "ConvertibleSlateMode" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "56" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\usbxhci\Parameters" /v "ThreadPriority" /t REG_DWORD /d "31" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "ThreadPriority" /t REG_DWORD /d "31" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "ThreadPriority" /t REG_DWORD /d "31" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NDIS\Parameters" /v "ThreadPriority" /t REG_DWORD /d "31" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "LocalPriority" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "HostsPriority" /t REG_DWORD /d "5" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "DnsPriority" /t REG_DWORD /d "6" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "NetbtPriority" /t REG_DWORD /d "7" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100" /v "Attributes" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100" /v "Affinity" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100" /v "Background Only" /t REG_SZ /d "False" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100" /v "Clock Rate" /t REG_DWORD /d "10000" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100" /v "GPU Priority" /t REG_DWORD /d "8" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100" /v "Priority" /t REG_DWORD /d "6" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100" /v "Scheduling Category" /t REG_SZ /d "High" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100" /v "SFIO Priority" /t REG_SZ /d "High" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100" /v "BackgroundPriority" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100" /v "Latency Sensitive" /t REG_SZ /d "True" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "1000" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "2000" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d "1000" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "2000" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "ClearPageFileAtShutdown" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "NonPagedPoolQuota" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "NonPagedPoolSize" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PagedPoolQuota" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PagedPoolSize" /t REG_DWORD /d "192" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SecondLevelDataCache" /t REG_DWORD /d "1024" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SessionPoolSize" /t REG_DWORD /d "192" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SessionViewSize" /t REG_DWORD /d "192" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SystemPages" /t REG_DWORD /d "4294967295" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PhysicalAddressExtension" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettings" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IoPageLockLimit" /t REG_DWORD /d "16710656" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PoolUsageMaximum" /t REG_DWORD /d "96" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\XboxNetApiSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\XboxGipSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\XblAuthManager" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLua" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_SZ /d "00000000" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowSharedUserAppData" /v "value" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowStore" /v "value" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "DisableTaskOffload" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Spooler" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PrintNotify" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BackgroundAppGlobalToggle" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\LanmanServer\Parameters" /v "autodisconnect" /t REG_DWORD /d "4294967295" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\LanmanServer\Parameters" /v "Size" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\LanmanServer\Parameters" /v "EnableOplocks" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\LanmanServer\Parameters" /v "IRPStackSize" /t REG_DWORD /d "32" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\LanmanServer\Parameters" /v "SharingViolationDelay" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\LanmanServer\Parameters" /v "SharingViolationRetries" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d "1" /f

echo.
echo Ustawienia rejestru zostaly zmienione.
pause
goto :MenuGlowna

:: Sekcja dodatkowych ustawień optymalizacyjnych
:DodatkoweOptymalizacje
cls
echo ============================================================
echo        Dodatkowe Ustawienia Optymalizacyjne
echo ============================================================
echo Wyłączenie efektów wizualnych...
reg add "HKCU\Control Panel\Desktop" /v "DragFullWindows" /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Desktop" /v "FontSmoothing" /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f
echo Zoptymalizowano ustawienia wizualne.
echo.
echo Optymalizacja zarządzania energią...
powercfg -change -monitor-timeout-ac 0
powercfg -change -disk-timeout-ac 0
powercfg -change -standby-timeout-ac 0
powercfg -change -hibernate-timeout-ac 0
echo Ustawienia energii zostały zoptymalizowane.
echo.
echo Dodatkowe optymalizacje systemowe zakończone.
pause
goto :MenuGlowna

:: Sekcja Pingu
:Ping
cls
echo ============================================================
echo                  Ping
echo ============================================================
echo [1] Ping Google
echo [2] Ping Cloudfare
echo [3] Powrot do menu glownego
echo.
set /p "Ping= Wybierz opcje (1-3): "
if "%Ping%"=="1" (
echo    Sprawdzanie pingu...
    ping 8.8.8.8 
echo    Sprawdzanie pingu zakończone
    pause
    goto :Ping
)
if "%Ping%"=="2" (
echo    Sprawdzanie pingu...
    ping 1.1.1.1
echo    Sprawdzanie pingu zakończone
    pause
    goto :Ping
)
goto :MenuGlowna

:: Sekcja wyboru koloru konsoli
:WybierzKolor
cls
echo ============================================================
echo                 Wybor Koloru Konsoli
echo ============================================================
echo Wybierz kolor tekstu na czarnym tle:
echo.
echo 0 = Czarny      8 = Szary
echo 1 = Niebieski   9 = Jasny Niebieski
echo 2 = Zielony     A = Jasny Zielony
echo 3 = Turkusowy   B = Jasny Turkusowy
echo 4 = Czerwony    C = Jasny Czerwony
echo 5 = Fioletowy   D = Jasny Fioletowy
echo 6 = Zolty       E = Jasny zolty
echo 7 = Bialy       F = Jasna Bialy
echo.
set /p "kolor= Wybierz kolor (0-F): "
color 0%kolor%
echo Kolor zmieniony! Nacisnij dowolny klawisz, aby powrocic do menu...
pause >nul
goto :MenuGlowna

:: Sekcja twórcy
:Tworca
cls
echo ============================================================
echo                  Tworca
echo ============================================================
echo Autor: zupekk
echo Wersja: 0.1 Beta
echo Bio: guns.lol/zupek
echo.
pause
goto :MenuGlowna

:: Sekcja zakończenia
:Koniec
echo Dziekuje za korzystanie z systemu. Do widzenia!
pause
exit

