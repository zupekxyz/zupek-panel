@echo off
setlocal

:: def
set "url=https://raw.githubusercontent.com/zupekxyz/zupek-panel/refs/heads/main/panel_beta.bat"
set "local_file=%~f0"
set "temp_file=%temp%\update_temp.bat"

echo Sprawdzanie aktualizacji...

:: Pobieranie nowej wersji do pliku tymczasowego
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%url%', '%temp_file%')"
if %errorlevel% neq 0 (
    echo Wystąpił problem podczas pobierania pliku. Sprawdź adres URL.
    pause
    exit /b
)

:: Sprawdzenie, czy nowy plik się różni
fc /b "%local_file%" "%temp_file%" >nul
if %errorlevel% equ 1 (
    echo Nowa wersja dostępna. Aktualizacja...
    copy /Y "%temp_file%" "%local_file%" >nul
    echo Aktualizacja zakończona. Uruchamianie ponownie...
    start "" "%local_file%"
    exit /b
) else (
    echo Masz juz najnowsza wersje.
    del "%temp_file%"
)

:: Dalszy kod 

@echo off
title Zupexy Multi panel.

:: Konsola powitalna
color 00
echo [90m    ███████╗██╗   ██╗██████╗ ███████╗██╗  ██╗██╗  ██╗
echo [90m   ╚══███╔╝██║   ██║██╔══██╗██╔════╝██║ ██╔╝██║ ██╔╝
echo [90m     ███╔╝ ██║   ██║██████╔╝█████╗  █████╔╝ █████╔╝ 
echo [90m    ███╔╝  ██║   ██║██╔═══╝ ██╔══╝  ██╔═██╗ ██╔═██╗ 
echo [90m    ███████╗╚██████╔╝██║     ███████╗██║  ██╗██║  ██╗
echo [90m    ╚══════╝ ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
echo.
echo [33m ============================================================
echo [90m               Zaawansowany System Konsoli
echo [33m ============================================================ [90m
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
echo [33m ============================================================
echo [90m [?]        Last update  15.12.2024 15:45
echo [90m [-] version 0.7 Beta
echo [90m [+] added new UI [Beta]
echo [90m [+] added [17] my console
echo [90m [✯] Discord: https://discord.gg/Z2cJ6Vnq3k
echo [33m ============================================================
echo.
echo.
echo [90m   TWEAK / CLEANER / OTHER                                     TOOL / ETC
echo [33m  -------------------------                                   ------------
echo [34m[1] Czyszczenie niepotrzebnych plików                    [7] Przegladanie plikow i folderow
echo [34m[2] Optymalizacja systemu Windows                         [8] Tworzenie kopii zapasowej pliku
echo [34m[3] Ustawienia BCD                                        [9] Wyswietlanie dziennika
echo [34m[4] Registry Tweaks                                       [10] Wyczysc dziennik
echo [34m[5] Dodatkowe ustawienia optymalizacyjne                  [11] Ustawienia
echo [34m[6] Ping                                                  [12] Wybor koloru konsoli
echo.
echo [90m   DISCORD / OTHER                                             INFO / ETC
echo [33m  -----------------                                           ------------
echo [32m[13] Discord URL Webhooks                                   [15] Tworca
echo [32m[14] Napisz wiadomosc przez Webhooks                        [16] wyjscie
echo [32m                                                            [17] Console .py
echo.
set /p "wybor=[90m Type option (1-16): "
if "%wybor%"=="1" goto :CzyszczenieSystemu
if "%wybor%"=="2" goto :OptymalizacjaSystemu
if "%wybor%"=="3" goto :UstawieniaBCD
if "%wybor%"=="4" goto RegistryTweaks
if "%wybor%"=="5" goto :DodatkoweOptymalizacje
if "%wybor%"=="6" goto :Ping
if "%wybor%"=="7" goto :Przegladanie
if "%wybor%"=="8" goto :KopiaZapasowa
if "%wybor%"=="9" goto :WyswietlDziennik
if "%wybor%"=="10" goto :WyczyscDziennik
if "%wybor%"=="11" goto :Ustawienia
if "%wybor%"=="12" goto :Wybierzkolor
if "%wybor%"=="13" goto :Webhook
if "%wybor%"=="14" goto :text
if "%wybor%"=="15" goto :Tworca
if "%wybor%"=="16" goto :Koniec
if "%wybor%"=="17" goto :Console
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
set /p "optymalizacja= Wybierz opcje (1-3): "
if "%optymalizacja%"=="1" (
    echo Optymalizacja połączenia internetowego...
    netsh interface tcp set global autotuning=disabled
    echo Optymalizacja zakonczona.
    pause
    goto :OptymalizacjaSystemu
)
if "%optymalizacja%"=="2" (
    echo Optymalizacja wydajności systemu...
    powercfg -h off
    echo Optymalizacja zakonczona.
    pause
    goto :OptymalizacjaSystemu
)
goto :MenuGlowna

:: Sekcja ustawień BCD
:UstawieniaBCD
cls
echo ============================================================
echo                  Ustawienia BCD
echo ============================================================
echo.
echo [1] BCD Tweaks
echo [2] Przywracanie domyslnych ustawien
echo [3] Powrot do menu glownego
echo.
set /p "ustawieniaBCD= Wybierz opcję (1-3): "
if "%ustawieniaBCD%"=="1" (
    bcdedit /set useplatformtick yes
    bcdedit /set disabledynamictick yes
    bcdedit /set bootstatuspolicy ignore
    bcdedit /set debug on
    bcdedit /set {bootmgr} path \EFI\Microsoft\Boot\bootmgfw.efi
    echo BCD Tweaks zakończone!
    pause
    goto :UstawieniaBCD
)
if "%ustawieniaBCD%"=="2" (
    echo Przywracanie domyślnych ustawień BCD...
    bcdedit /export C:\bcdbackup
    bcdedit /import C:\bcdbackup
    echo Przywracanie zakończone.
    pause
    goto :UstawieniaBCD
)
if "%ustawieniaBCD%"=="3" (
    goto :MenuGlowna
)
goto :MenuGlowna

:: Sekcja modyfikacji rejestru
:RegistryTweaks
cls
echo ============================================================
echo                 Modyfikacje Rejestru
echo ============================================================
echo.
echo [1] Wyłacz animacje systemowe
echo [2] Zmien domyślny czas otwierania okien
echo [3] Dodatkowa optymalizacja
echo [4] Powrot do menu glownego
echo.
set /p "tweaks= Wybierz opcje (1-4): "
if "%tweaks%"=="1" (
    echo Wyłączanie animacji...
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "VisualFXSetting" /t REG_SZ /d "2" /f
    echo Animacje wyłączone.
    pause
    goto :RegistryTweaks
)
if "%tweaks%"=="2" (
    echo Zmienianie czasu otwierania okien...
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f
    echo Czas otwierania okien zmieniony.
    pause
    goto :RegistryTweaks
)
if "%tweaks%"=="3" (
    echo Dodatkowa optymalizacja REG
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
    echo Optymalizacja Skonczona!
    pause
    goto :RegistryTweaks
)
goto :MenuGlowna

:: Sekcja dodatkowych optymalizacji
:DodatkoweOptymalizacje
cls
echo ============================================================
echo            Dodatkowe Ustawienia Optymalizacyjne
echo ============================================================
echo.
echo [1] Optymalizacja startu systemu
echo [2] Zmiana domyślnych programów
echo [3] Powrot do menu glownego
echo.
set /p "dodatkowe= Wybierz opcje (1-3): "
if "%dodatkowe%"=="1" (
    echo Optymalizacja startu systemu...
    msconfig
    echo Optymalizacja zakonczona.
    pause
    goto :DodatkoweOptymalizacje
)
if "%dodatkowe%"=="2" (
    echo Zmienianie domyślnych programów...
    control /name Microsoft.DefaultPrograms
    echo Zmiana domyślnych programów zakonczona.
    pause
    goto :DodatkoweOptymalizacje
)
goto :MenuGlowna

:: Sekcja Ping
:Ping
cls
echo ============================================================
echo                  Pingowanie
echo ============================================================
echo.
set /p "adres=Podaj adres do pingowania: "
ping %adres%
echo.
pause
goto :MenuGlowna

:: Sekcja wyboru koloru konsoli
:Wybierzkolor
cls
echo ============================================================
echo                Wybierz kolor konsoli
echo ============================================================
echo Wybierz kolor tekstu:
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

:: Sekcja webhooks
: Webhook
cls
echo ============================================================
echo                  Webhook ❘ URL
echo ============================================================
echo.
set /p "NEW_WEBHOOK_URL=Podaj nowy URL webhooka: "
set WEBHOOK_URL=%NEW_WEBHOOK_URL%

:: Zapisz nowy URL w historii
echo %WEBHOOK_URL% >> webhook_history.txt
echo Zmieniono URL webhooka na: %WEBHOOK_URL%
pause
goto :MenuGlowna

:: Sekcja textu 
: text
cls
echo ============================================================
echo                        TEXT
echo ============================================================
echo.
echo Wpisz wiadomoc a nastepnie wyslij enter by ja wyslac
echo Wpisz "exit", aby powrocic do Menu glownego
echo.
setlocal enabledelayedexpansion

:WiadomoscLoop
set /p "MESSAGE=Twoja wiadomość: "
if "%MESSAGE%"=="exit" goto :MenuGlowna

:: Zamień " na \" aby poprawnie wysłać JSON
set MESSAGE_JSON={\"content\":\"%MESSAGE%\"}

:: Wyślij wiadomość za pomocą curl
curl -H "Content-Type: application/json" -X POST -d "%MESSAGE_JSON%" %WEBHOOK_URL%

echo Wiadomość wysłana: %MESSAGE%
goto WiadomoscLoop

:: Sekcja twórcy
:Tworca
cls
echo ============================================================
echo                  Tworca
echo ============================================================
echo.
echo [*] Stworzone przez: zupek
echo [*] Bio: guns.lol/zupek
echo [*] Data wydania: ???
echo [*] Wersja: 0.5 Beta
echo [*] Discord: https://discord.gg/Z2cJ6Vnq3k
echo.
pause
goto :MenuGlowna

:: Sekcja końca
:Koniec
echo Dziekujemy za skorzystanie z systemu Beta! 
pause
exit


:: CONSOLE
:Console
echo ============================================================
echo                 Console .py
echo ============================================================
echo.
echo [?] czy chcesz zainstalować konsole .py
echo [1] TAK
echo [2] Nie
set /p "dodatkowe= Wybierz opcje (1-2): "
if "%dodatkowe%"=="1" (
start https://github.com/zupekxyz/console-/tree/main
)
goto :MenuGlowna
