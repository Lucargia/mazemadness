@echo off
setlocal enabledelayedexpansion
for /f "delims=" %%I in ("%0") do set FN=%%~sI


if /i not "%1"=="-MaxRun" (
start /MAX CMD /C %FN% -MaxRun
exit /b
)


for /f "delims=" %%I in ("%0") do set ThisDir=%%~spI

cd !ThisDir!

title Lucargia's Maze Madness

for /l %%I in (1,1,36) do for /l %%J in (1,1,36) do set displayline%%I=!displayline%%I!#Dgrid%%J-%%I#
for /l %%I in (1,1,36) do for /l %%J in (1,1,36) do set Bdisplayline%%I=!Bdisplayline%%I!#BDgrid%%J-%%I#

:TitleScreen
echo Welcome to Lucargia's Maze Madness
echo.
echo.
echo Enter the number of your desired activity.
echo.
echo 1. Play Maze Madness
echo 2. Play Visible Mazes
echo 3. Maze Draw Mode
echo 4. Instructions
echo 5. Exit
echo.
set choice=
set /p Choice=
call :choice!choice! 2>nul
if "%ExitTime%"=="1" (
set exittime=
exit /b
)
cls
goto TitleScreen




:choice5
set exitTime=1
exit /b




:choice4
echo What would you like instructions on?
echo Enter the number of your choice.
echo.
echo 1. Maze Madness.
echo 2. Maze Drawing.
echo.
echo 3. Back to main menu
echo.
set instructionchoice=
set /p instructionchoice=
if /i !instructionchoice!==1 (
echo The aim of the game is simple, complete all six levels by getting to an
echo exit. Exits look like this [].
echo Navigate the maze using W, A, S and D. W is up, A is left, S is down and D
echo is right. Once you've enetered a direction, keep tapping enter to move in
echo that direction, without having to press they key each time.
echo The maze is hidden from view, you can only see the location of your character.
echo Pressing # reveals the maze for five seconds. Memorise as much of the maze as
echo possible in these five seconds, you only get three reveals per maze.
echo After each level you complete, the next is unlocked and you can play this level
echo whenever you want.
echo.
pause
exit /b
)

if /i !instructionchoice!==2 (
echo.
echo Maze draw mode is the best way to create your own custom, playable mazes.
echo.
echo Navigate around the drawing area using the W, A, S and D keys. W is up,
echo A is left, S is down and D is right.
echo.
echo Press G for ghost mode, this allows you to move about the drawing area
echo without drawing, as if you are taking your pen off the paper.
echo.
echo Press P to choose a new pointer. You can choose any two characters to be
echo your new pointer, as long as they are not special characters.
for /f "delims=" %%I in ("(Special characters are ^ & < > and |)") do echo %%I
echo Set your pointer to [] to create an exit.
echo.
echo Press R for eraser mode, eraser mode draws blanks instead of your pointer.
echo.
echo Press # to exit and save your map. You can edit it again later by choosing
echo draw mode and choosing Y when asked 'Continue Previous Work?'.
echo Beware, the player always begins at the point 2,2. This is one row down
echo and one column from the left.
echo.
pause
exit /b
)
goto choice4




:choice3
set Drawmode=1
set Pointer=00


echo Continue Previous Work? [Y/N]
set yesno=
set /p YesNo=
if /i "!YesNo:~0,1!"=="Y" (
call :CustomMap
for /l %%I in (1,1,36) do for /l %%J in (1,1,36) do set wgrid%%I-%%J=EMPTY
goto DrawMode_Xval
)

echo.
echo Loading Blank Map...
echo.
call :BlankMap


:DrawMode_XVal
echo.
echo Enter your starting X value (1-36)
set /p manX=
if /i !manx! gtr 36 goto DrawMode_XVal
if /i !manx! lss 1 goto DrawMode_XVal

:DrawMode_YVal
echo.
echo Enter your starting Y value (1-36)
set /p manY=
if /i !manY! gtr 36 goto DrawMode_YVal
if /i !manY! lss 1 goto DrawMode_YVal

set oldDchar=!dgrid%manX%-%manY%!
set dgrid%manX%-%manY%=00

goto DrawMode_Begin_Game








:choice2
cls
set Pointer=00
set Drawmode=0
call :CustomMap
goto Begin_game







:choice1
cls

set h5lf325hdk=#0
set h2da39d3h5=DG]
set h0pr3sk3jh4d=[6
set hlp12j23g4=;~@


set SaveLine1=%h5lf325hdk%%h5lf325hdk%%hlp12j23g4%%h2da39d3h5%%h0pr3sk3jh4d%%h5lf325hdk%%h2da39d3h5%
set SaveLine2=%hlp12j23g4%%h2da39d3h5%%h0pr3sk3jh4d%%h0pr3sk3jh4d%%h0pr3sk3jh4d%%hlp12j23g4%%hlp12j23g4%
set SaveLine3=%h5lf325hdk%%hlp12j23g4%%hlp12j23g4%%h2da39d3h5%%h5lf325hdk%%hlp12j23g4%%h0pr3sk3jh4d%
set SaveLine4=%h2da39d3h5%%h0pr3sk3jh4d%%h5lf325hdk%%hlp12j23g4%%hlp12j23g4%%hlp12j23g4%
set SaveLine5=%hlp12j23g4%%h5lf325hdk%%h0pr3sk3jh4d%%hlp12j23g4%%hlp12j23g4%%h2da39d3h5%
set SaveLine6=%h0pr3sk3jh4d%%h0pr3sk3jh4d%%h5lf325hdk%%hlp12j23g4%%h2da39d3h5%%hlp12j23g4%%hlp12j23g4%



echo Checking Game Status...
echo.
echo.
set Block2=::
set Block3=::
set Block4=::
set Block5=::
set Block6=::

set CurrentLevel=1

if exist Maze_Madness_Save (

type Maze_Madness_Save | find /i "!SaveLine1!" >nul
if /i !errorlevel! equ 0 set block2=& set Currentlevel=2

type Maze_Madness_Save | find /i "!SaveLine2!" >nul
if /i !errorlevel! equ 0 set block3=& set Currentlevel=3

type Maze_Madness_Save | find /i "!SaveLine3!" >nul
if /i !errorlevel! equ 0 set block4=& set Currentlevel=4

type Maze_Madness_Save | find /i "!SaveLine4!" >nul
if /i !errorlevel! equ 0 set block5=& set Currentlevel=5

type Maze_Madness_Save | find /i "!SaveLine5!" >nul
if /i !errorlevel! equ 0 set block6=& set Currentlevel=6

)



::for %%I in (Maze_Madness_Save) do set filesize=%%~zI
::if /i !filesize! gtr 115 del Maze_Madness_Save&& for /l %%I in (1,1,%CurrentLevel%) do echo !saveline%currentlevel%!>> Maze_Madness_Save



set Pointer=00
set Drawmode=0

:BlindTitle
cls

echo Maze Madness!
echo .............
echo.
echo.
echo.
echo ########################
echo # Enter PLAY to start. #
echo ########################

echo.
echo.
echo.
echo.
echo.
echo If you just want to replay single levels, enter the number of
echo the unlocked level you want to play:
echo.
echo (type CUSTOM to load a custom map)
echo.
echo.
echo 1. Blind Level 1
%block2%echo 2. Blind Level 2
%block3%echo 3. Blind Level 3
%block4%echo 4. Blind Level 4
%block5%echo 5. Blind Level 5
%block6%echo 6. Blind Level 6

set mapchoice=
set /p mapchoice=



if /i !mapchoice!==Play (
goto Blind_Long_Game
)

if /i "%mapchoice:~-1%"=="1" (
set mapchoice=Map_Blind_1
call :MapChosen
goto Blind_Game
)

%block2% if /i "%mapchoice:~-1%"=="2" (
%block2% set mapchoice=Map_Blind_2
%block2% call :MapChosen
%block2% goto Blind_Game
%block2% )

%block3% if /i "%mapchoice:~-1%"=="3" (
%block3% set mapchoice=Map_Blind_3
%block3% call :MapChosen
%block3% goto Blind_Game
%block3% )

%block4% if /i "%mapchoice:~-1%"=="4" (
%block4% set mapchoice=Map_Blind_4
%block4% call :MapChosen
%block4% goto Blind_Game
%block4% )

%block5% if /i "%mapchoice:~-1%"=="5" (
%block5% set mapchoice=Map_Blind_5
%block5% call :MapChosen
%block5% goto Blind_Game
%block5% )

%block6% if /i "%mapchoice:~-1%"=="6" (
%block6% set mapchoice=Map_Blind_6
%block6% call :MapChosen
%block6% goto Blind_Game
%block6% )


if /i "%mapchoice%"=="Custom" (
call :CustomMap
goto Blind_Game
)

goto BlindTitle






:CustomMap
cls
echo Enter the path of your custom map file.
set MapPath=
set /p MapPath=
if not defined MapPath goto CustomMap
for /f "delims=" %%I in ("!MapPath!") do set mappath="%%~sI"
echo.
echo Loading Map...
echo.
call :MapRetrieve %MapPath%
if "%mapdone%"=="1" (
set mapdone=
exit /b
)
goto CustomMap


:MapChosen
echo.
echo Loading Map...
echo.
call :MapRetrieve %Mapchoice%
if "%mapdone%"=="1" (
set mapdone=
exit /b
)
goto Choice1


:DrawMode_Begin_Game

set BlankMode=OFF
set EraseMode=OFF
goto drawloop



:Begin_Game

set manX=2
set manY=2
set oldDchar=%dgrid2-2%
set dgrid2-2=%pointer%


::for /l %%I in (1,1,36) do echo !displayline%%I!

goto gameloop










::~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DRAW LOOP



:DrawLoop
cls
echo Press N to start again. Press P to choose a new pointer. When finished press #.
echo Press R to use the eraser. Press G to move without drawing.
echo.
echo Erase Mode: %EraseMode%. Ghost Mode: %BlankMode%
echo.
call :Display

if /i "!EraseMode!"=="ON" set OldDChar=  
set /p movement=

if /i !movement!==N (
  echo.
	echo Loading Blank Map...
	call :BlankMap
	set OldDchar=!Dgrid%manx%-%many%!
	set Dgrid%manx%-%many%=%pointer%
	goto DrawLoop
)

if /i !movement!==R (
if /i !BlankMode!==ON Set BlankMode=OFF
if /i !EraseMode!==ON Set EraseMode=OFF&& set drawmode=1&& goto DrawLoop
set EraseMode=ON
set drawmode=0
)

if /i !movement!==G (

if /i !EraseMode!==ON (Set EraseMode=OFF) else (set OldDchar=!pointer!)

if /i !BlankMode!==ON set dgrid%manx%-%Many%=!pointer!&& set DrawMode=1&& Set BlankMode=OFF&& goto DrawLoop

set BlankMode=ON
set DrawMode=0
)

if /i !movement!==P (
set newpointer=
set /p Newpointer=Enter the new two character pointer you want to use: 
if defined NewPointer if NOT "Newpointer:~1"=="" set NewPointer=!NewPointer:~0,2!&& set pointer=!NewPointer!
set dgrid%manx%-%Many%=!pointer!
)


if /i !movement!==# (goto save?)


call :Move!movement:~0,1! 2>nul



if /i "%finishedmap%"=="1" (
set finishedmap=
goto Save?
)

goto drawloop












::~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GAME LOOP


:GameLoop
cls
call :Display
set /p movement=


call :Move!movement:~0,1! 2>nul
if /i "%finishedmap%"=="1" (
set finishedmap=
exit /b
)

goto gameloop



:MoveA
set /a tempX=%ManX% - 1

if /i "!wgrid%TempX%-%ManY%!"=="WIN" (
goto WIN
)


if /i NOT "!wgrid%TempX%-%ManY%!"=="EMPTY" (
set InfoMessage=You can't move there
exit /b
)


if /i not "%drawmode%"=="1" set dgrid%manX%-%manY%=%OldDChar%
set ManX=%TempX%
set OldDChar=!dgrid%manX%-%manY%!
set dgrid%manX%-%manY%=%pointer%

exit /b












::~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Blind long game


:Blind_Long_Game
set mapchoice=Map_Blind_%CurrentLevel%
call :MapChosen
call :Blind_Game
Cls

if /i !Currentlevel!==6 (
echo Well done! You've completed all the levels!
echo You can now play any of the levels whenever you want.
echo.
pause
exit /b
) else (
echo Starting next level...
echo.
pause
set /a Currentlevel= %CurrentLevel% + 1
goto Blind_Long_Game
)











::~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ BLIND LOOP





:Blind_Game

call :blankmap -blind

set reveals=3

set manX=2
set manY=2

set oldDchar=%dgrid2-2%
set dgrid2-2=%pointer%

set BOldDChar=%dgrid2-2%
set Bdgrid2-2=%pointer%



goto Blind_Loop








:Blind_Loop

cls
echo Press # to use one of your reveals.
echo Reveals left=%reveals%
call :BDisplay


set /p movement=


if /i !movement!==# if /i %REVEALS% gtr 0 (
cls
call :display
call :waitfive
set /a reveals= %reveals% - 1
goto Blind_Loop
)


set bdgrid%manX%-%manY%=  

call :Move!movement:~0,1! 2>nul

if /i "%finishedmap%"=="1" (
set finishedmap=
if /i %currentlevel% leq %mapchoice:~10,1% echo !Saveline%CurrentLevel%!>> Maze_Madness_Save
exit /b
)

set bdgrid%manX%-%manY%=!pointer!

goto Blind_Loop








:Waitfive
set /a CheckTime=%time:~7,1% + 5
if /i !checktime! geq 10 set /a Checktime= %checktime% - 10

:Fiveloop
if /i %checktime% equ %time:~7,1% (exit /b) else (goto Fiveloop)

















::~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Movements




:MoveA
set /a tempX=%ManX% - 1

if /i "!wgrid%TempX%-%ManY%!"=="WIN" (
goto WIN
)

if /i NOT "!wgrid%TempX%-%ManY%!"=="EMPTY" (
set InfoMessage=You can't move there
exit /b
)


if /i not "%drawmode%"=="1" set dgrid%manX%-%manY%=%OldDChar%
set ManX=%TempX%
set OldDChar=!dgrid%manX%-%manY%!
set dgrid%manX%-%manY%=%pointer%

exit /b









:MoveD
set /a tempX=%ManX% + 1

if /i "!wgrid%TempX%-%ManY%!"=="WIN" (
goto WIN
)

if /i NOT "!wgrid%TempX%-%ManY%!"=="EMPTY" (
set InfoMessage=You can't move there
exit /b
)


if /i not "%drawmode%"=="1" set dgrid%manX%-%manY%=%OldDChar%
set ManX=%TempX%
set OldDChar=!dgrid%manX%-%manY%!
set dgrid%manX%-%manY%=%pointer%

exit /b






:MoveW
set /a tempY=%ManY% - 1


if /i "!wgrid%ManX%-%TempY%!"=="WIN" (
goto WIN
)


if /i NOT "!wgrid%ManX%-%TempY%!"=="EMPTY" (
set InfoMessage=You can't move there
exit /b
)


if /i not "%drawmode%"=="1" set dgrid%manX%-%manY%=%OldDChar%
set ManY=%TempY%
set OldDChar=!dgrid%manX%-%manY%!
set dgrid%manX%-%manY%=%pointer%

exit /b






:MoveS
set /a tempY=%ManY% + 1

if /i "!wgrid%ManX%-%TempY%!"=="WIN" (
goto WIN
)

if /i NOT "!wgrid%ManX%-%TempY%!"=="EMPTY" (
set InfoMessage=You can't move there
exit /b
)


if /i not "%drawmode%"=="1" set dgrid%manX%-%manY%=%OldDChar%
set ManY=%TempY%
set OldDChar=!dgrid%manX%-%manY%!
set dgrid%manX%-%manY%=%pointer%

exit /b














::~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ BLIND DISPLAY


:BDisplay

echo.%Bdisplayline1:#=!%
echo.%Bdisplayline2:#=!%
echo.%Bdisplayline3:#=!%
echo.%Bdisplayline4:#=!%
echo.%Bdisplayline5:#=!%
echo.%Bdisplayline6:#=!%
echo.%Bdisplayline7:#=!%
echo.%Bdisplayline8:#=!%
echo.%Bdisplayline9:#=!%
echo.%Bdisplayline10:#=!%
echo.%Bdisplayline11:#=!%
echo.%Bdisplayline12:#=!%
echo.%Bdisplayline13:#=!%
echo.%Bdisplayline14:#=!%
echo.%Bdisplayline15:#=!%
echo.%Bdisplayline16:#=!%
echo.%Bdisplayline17:#=!%
echo.%Bdisplayline18:#=!%
echo.%Bdisplayline19:#=!%
echo.%Bdisplayline20:#=!%
echo.%Bdisplayline21:#=!%
echo.%Bdisplayline22:#=!%
echo.%Bdisplayline23:#=!%
echo.%Bdisplayline24:#=!%
echo.%Bdisplayline25:#=!%
echo.%Bdisplayline26:#=!%
echo.%Bdisplayline27:#=!%
echo.%Bdisplayline28:#=!%
echo.%Bdisplayline29:#=!%
echo.%Bdisplayline30:#=!%
echo.%Bdisplayline31:#=!%
echo.%Bdisplayline32:#=!%
echo.%Bdisplayline33:#=!%
echo.%Bdisplayline34:#=!%
echo.%Bdisplayline35:#=!%
echo.%Bdisplayline36:#=!%
echo.
echo.%InfoMessage%
set InfoMessage=
exit /b

























::~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DISPLAY


:Display

echo.%displayline1:#=!%%savepath%
echo.%displayline2:#=!%%savepath%
echo.%displayline3:#=!%%savepath%
echo.%displayline4:#=!%%savepath%
echo.%displayline5:#=!%%savepath%
echo.%displayline6:#=!%%savepath%
echo.%displayline7:#=!%%savepath%
echo.%displayline8:#=!%%savepath%
echo.%displayline9:#=!%%savepath%
echo.%displayline10:#=!%%savepath%
echo.%displayline11:#=!%%savepath%
echo.%displayline12:#=!%%savepath%
echo.%displayline13:#=!%%savepath%
echo.%displayline14:#=!%%savepath%
echo.%displayline15:#=!%%savepath%
echo.%displayline16:#=!%%savepath%
echo.%displayline17:#=!%%savepath%
echo.%displayline18:#=!%%savepath%
echo.%displayline19:#=!%%savepath%
echo.%displayline20:#=!%%savepath%
echo.%displayline21:#=!%%savepath%
echo.%displayline22:#=!%%savepath%
echo.%displayline23:#=!%%savepath%
echo.%displayline24:#=!%%savepath%
echo.%displayline25:#=!%%savepath%
echo.%displayline26:#=!%%savepath%
echo.%displayline27:#=!%%savepath%
echo.%displayline28:#=!%%savepath%
echo.%displayline29:#=!%%savepath%
echo.%displayline30:#=!%%savepath%
echo.%displayline31:#=!%%savepath%
echo.%displayline32:#=!%%savepath%
echo.%displayline33:#=!%%savepath%
echo.%displayline34:#=!%%savepath%
echo.%displayline35:#=!%%savepath%
echo.%displayline36:#=!%%savepath%
echo.
echo.%InfoMessage%
set InfoMessage=
exit /b













::~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ BLANK MAP

:BlankMap

set b=

if /i "%1"=="-blind" set b=B

for /l %%I in (1,1,36) do for /l %%J in (1,1,36) do (
set %b%DGrid%%I-%%J=  
set %b%WGrid%%I-%%J=EMPTY
)
if not defined b set DGrid36-36=[]
if not defined b set WGrid36-36=WIN
exit /b















::~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MAP RETRIEVE


:MapRetrieve

for /f "delims=" %%I in ("%1") do set MapPath=%%~sI

::call :blankmap

if not exist %MapPath% (
	if not exist %MapPath%.txt (
		echo Map Not Found...
		echo.
		pause
		exit /b
	) else (
		set MapPath=%MapPath%.txt
	)
)


set counterb=1
set counterc=0


for /f "delims=" %%I in (%MapPath%) do set DATA=%%I&&  set /a counterC= !counterC! + 1&& call :Analyse
set MapDone=1
exit /b


:Analyse
set countera=0
set counterB=1

:loop

if /i "!data:~%countera%,2!"=="" (exit /b)

set dgrid%counterB%-%counterC%=!data:~%countera%,2!


if /i "!dgrid%counterB%-%counterC%!"=="  " (
set wgrid%counterB%-%CounterC%=EMPTY
) else set wgrid%counterB%-%CounterC%=

if /i "!dgrid%counterB%-%counterC%!"=="[]" (
set dgrid%counterB%-%counterC%=[]
set wgrid%counterB%-%CounterC%=WIN
)

set /a countera= %countera% + 2
set /a counterb= %counterb% + 1

goto loop






::~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ WIN



:Win
cls
echo Level Complete :)
pause
set FinishedMap=1
exit /b







::~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Save?
:Save?
echo.
echo Enter the path you'd like to save your drawing to. (Leave blank to discard)
set SavePath=
set /p SavePath=
if not defined savepath exit /b
if /i D!savepath!==D    exit /b
for /f "delims=" %%I in ("!savepath!") do set savepath="%%~sI"

:Saveyesno
if exist !savepath! (
echo File exists. Overwrite? [Y/N]
set YesNo=
set /p YesNo=
if /i !yesno!==N goto Save?
if /i NOT !yesno!==Y goto SaveYesNo
del !SavePath!
)

echo Saving...
for /f "delims=" %%I in (">>%savepath%") do set SavePath=%%I
call :display
echo Drawing Saved.
set savepath=
echo.
pause
exit /b
