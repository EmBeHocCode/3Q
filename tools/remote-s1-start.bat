@echo off
color 1f
title= S1
D:\3QVuongGia\Java\jdk1.8.0_121\bin\java -Xms1048m -Xmn512m -Xss256k -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=./oom.hprof -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:MaxGCPauseMillis=50 -XX:GCPauseIntervalMillis=200 -XX:SurvivorRatio=6 -Xloggc:logs/gc.log -classpath "./;../Jar/lib/*;./config;../Jar/framework/*;./app/gameserver/*" com.playmore.net.netty.context.SpringContextLoader
pause
