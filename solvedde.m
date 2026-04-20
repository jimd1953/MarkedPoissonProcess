%***********************************************************
function ddeqinfo = solvedde(ddeqinfo,gridinfo) %          *
%..........................................................*
%                                                          *
% Solve a generally mixed differential-difference equation *
% using a 2nd order finite difference method.              *
%                                                          *
%***********************************************************
%
%***********************************
%                                  *
%              input               *
%                                  *
taps  = ddeqinfo.taps              ;
alpha = ddeqinfo.alpha             ;
p     = ddeqinfo.p                 ;
c     = ddeqinfo.c                 ;
K     = ddeqinfo.K                 ;
J     = ddeqinfo.J                 ;
nsubs = gridinfo.nsubs             ;
rsize = gridinfo.rsize             ;
rdel  = gridinfo.rdel              ;
izero = gridinfo.izero             ;
%***********************************
%
%***********************************
%                                  *
%           preparation            *
%                                  *
iK    = round(izero+K*nsubs)       ;
iJ    = round(izero+J*nsubs)       ;
ntaps = numel(taps)                ;
lags  = round(nsubs*taps)          ;
Z     = zeros(1,rsize  )           ;
V     = zeros(1,rsize  )           ;
DV    = zeros(1,rsize-1)           ;
DZ    = zeros(1,rsize-1)           ;
N     = iJ-iK+1                    ;
h     = alpha*rdel/2               ;
hm    = h-1                        ;
hp    = h+1                        ;
V(iJ+1:end) = 1                    ;
%***********************************
%
%***********************************
%                                  *
% form system matrix B             *
%                                  *
B      = zeros(N)                  ;
B(1,1) = 0                         ;
for i = 2:N %                      ;
    B(i,i-1) = hm                  ;
    B(i,i  ) = hp                  ;
end %                              ;
for itap = 1:ntaps %               ;
    lag = lags(itap)               ;
    if lag<0 %                     ;
        m  = -lag                  ;
        a  = p(itap)               ;
        ha = h*a                   ;
        if m+2<=N %                ;
            for i = m+2:N %        ;
                j = i-m-1:i-m      ;
                B(i,j) = B(i,j)-ha ;
            end %                  ;
        end %                      ;
    else %                         ;
        n  =  lag                  ;
        b  = p(itap)               ;
        hb = h*b                   ;
        if n+2<=N %                ;
            for i = 2:N-n %        ;
                j = i+n-1:i+n      ;
                B(i,j) = B(i,j)-hb ;
            end %                  ;
        end %                      ;
    end %                          ;
end %                              ;
B = B(2:end,2:end)                 ;
B = B/hp                           ;
%***********************************
%
%***********************************
r = iK:iJ                          ;
s = iK:iJ-1                        ;
q = zeros(N,1)                     ;
for itap = 1:ntaps %               ;
    lag = lags(itap)               ;
    if lag>0 %                     ;
        n    = lag                 ;
        b    = p(itap)             ;
        hb   = h*b                 ;
        i    = max(1,N-n+1):N      ;
        q(i) = q(i)+2*hb           ;
    end %                          ;
end %                              ;
q     = q(2:end)                   ;
q     = q/(h+1)                    ;
v     = (B\q)                      ;
V(r)  = [0;v]                      ;
q     = ones(N,1)*rdel/c           ;
q     = q(2:end)                   ;
q     = q/(h+1)                    ;
z     = (B\q)                      ;
Z(r)  = [0;z]                      ;
DV(s) = (V(s+1)-V(s))/rdel         ;
DZ(s) = (Z(s+1)-Z(s))/rdel         ;
%***********************************
%
%***********************************
%                                  *
%             output               *
%                                  *
ddeqinfo.V    = V                  ;
ddeqinfo.Z    = Z                  ;
ddeqinfo.DV   = DV                 ;
ddeqinfo.DZ   = DZ                 ;
ddeqinfo.lags = lags               ;
%***********************************
end %