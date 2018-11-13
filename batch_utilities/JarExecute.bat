cd c:\ThinApplet
IF %1 == jdk18 "C:\Program Files\Java\jdk1.8.0_45\bin\java.exe" -jar %2
IF %1 == jre15 "C:\Program Files\Java\jre1.5.0_21\bin\java.exe" -jar %2
IF %1 == jre16 "C:\Program Files\Java\jre1.6.0_16\bin\java.exe" -jar %2
IF %1 == jre6 "C:\Program Files\Java\jre6\bin\java.exe" -jar %2
IF %1 == jre7 "C:\Program Files\Java\jre7\bin\java.exe" -jar %2