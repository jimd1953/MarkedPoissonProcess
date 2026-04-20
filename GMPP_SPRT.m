%***********************************************************
%                                                          *
%  SPRT between Geometric Marked Poisson Processes (GMPP)  *
%                                                          *
% The correct printout for:                                *
%                                                          *
%  tau rate0   q0  q1  ntaps nsubs   K   J   rmin rmax     *
%  --- -----  --- ---  ----- -----  --- ---  ---- ----     *
%  0.1  1.0   0.1 0.2    64    10    -8   8   -20   20     *
%                                                          *
% is                                                       *
%                                                          *
%  K  J   tau     V0     V1     Z0     Z1  logTd  logTf    *
% -- --  ----  -----  -----  -----  ----- -----  ------    *
% -8  8  0.10 0.2980 0.8295 2.5651 2.6652 0.9672 0.2706    *
%                                                          *
%***********************************************************
%
%
%***************************************
%                                      *
%      log-likelihood ratio grid       *
%                                      *
rmin=-20; rmax=20; nsubs=10            ;
gridinfo = makegrid(rmin,rmax,nsubs)   ;
%***************************************
%
%***********************************************
%                                              *
%     GMPP parameters and SPRT boundaries      *
%                                              *
tau      = 0.1                                 ;
rate0    = 1.00                                ;
q0       = .1                                  ;
q1       = .2                                  ;
ntaps    = 64                                  ;
K        = -8                                  ;
J        =  8                                  ;
sprtinfo = makegmpp(tau,rate0,q0,q1,ntaps)     ;
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