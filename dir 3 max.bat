@echo off
set /p directory=Chemin absolu répertoire source 
for /f "delims=" %%a in ('dir /b /a:d "%directory%\"') do (
    	icacls "%directory%\%%a"
	for /f "delims=" %%b in ('dir /b /a:d "%directory%\%%a\"') do (
		icacls "%directory%\%%a\%%b"
       		for /f "delims=" %%c in ('dir /b /a:d "%directory%\%%a\%%b\"') do (				
          		icacls "%directory%\%%a\%%b\%%c"
		)
	)
)

