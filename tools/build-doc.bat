@echo off
REM build reference
echo Building reference
cmd /c jsdoc -c jsdoc_conf.json
xcopy /Y ..\docs\Duik.html ..\docs\index.html
echo Reference built
REM add CSS
xcopy /Y jsdoc.css ..\docs