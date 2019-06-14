@ECHO off
FOR %%c in (Z,Y,X,W,V,U,T,S,R,Q,P,O,N,M,L,K,J,I,H,G,F,E,D,C) do (
    IF  exist %%c: (
        ：：MD %%c:\Redtek
        GOTO :EOF
    )
)
pause