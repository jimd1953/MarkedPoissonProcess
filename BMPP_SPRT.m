%***********************************************************
%                                                          *
%    SPRT between Binary Marked Poisson Processes (BMPP)   *
%                                                          *
% The correct printout for:                                *
%                                                          *
%  tau rate0   p0  p1  ntaps nsubs   K   J   rmin rmax     *
%  --- -----  --- ---  ----- -----  --- ---  ---- ----     *
%  0.1  1.0    a   b     2     50    -4   4   -20   20     *
%                                                          *
% is                                                       *
%                                                          *
%  K  J   tau     V0     V1     Z0     Z1   logTd  logTf   *
% -- --  ----  -----  -----  -----  -----  ------ ------   *
% -4  4  0.10 0.3601 0.5674 6.2137 6.0276 -0.0765 0.6631   *
%                                                          *
%***********************************************************
%
%***************************************
%                                      *
%      log-likelihood ratio grid       *
%                                      *
rmin=-20; rmax=20; nsubs=50            ;
gridinfo = makegrid(rmin,rmax,nsubs)   ;
%***************************************
%
%***********************************************
%                                              *
%     BMPP parameters and SPRT boundaries      *
%                                              *
tau      = 0.1                                 ;
rate0    = 1.0                                 ;
p0       = [0.366, 0.634]                      ;
p1       = [0.302, 0.698]                      ;
K        = -4                                  ;
J        =  4                                  ;
sprtinfo = makebmpp(tau,rate0,p0,p1)           ;
sprtinfo = makesprt(K,J,sprtinfo,gridinfo)     ;
%***********************************************
%
%***********************************
%                                  *
%              print               *
%                                  *
i     = gridinfo.izero             ;
v0    = sprtinfo.V0(i)             ;
z0    = sprtinfo.Z0(i)             ;
dv0   = sprtinfo.DV0(i)            ;
dz0   = sprtinfo.DZ0(i)            ;
v1    = sprtinfo.V1(i)             ;
z1    = sprtinfo.Z1(i)             ;
dv1   = sprtinfo.DV1(i)            ;
dz1   = sprtinfo.DZ1(i)            ;
fmt   = '%9d%9d%9.4f'              ;
gmt   = '%9.4f%9.4f%9.4f'          ;
hmt   = strcat(fmt,gmt,gmt)        ;
fmt   = strcat(hmt,'\n')           ;
ltf   = log10(rate0*dz0/dv0)       ;
ltd   = log10(rate0*dz1/dv1)       ;
flist = [v0,v1,z0,z1,ltd,ltf]      ;
fprintf(1,'\n')                    ;
fprintf(1,fmt,K,J,tau,flist)       ;
fprintf(1,'\n')                    ;
%***********************************