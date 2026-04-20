%***********************************************************
function sprtinfo = makebmpp(tau,rate0,p0,p1) %            *
%----------------------------------------------------------*
%                                                          *
%           Binary Marked Poisson Process (BMPP)           *
%                                                          *
%  INPUT                                                   *
%  -----                                                   *
%  tau   = fractional rate increase                        *
%  rate0 = null state Poisson rate                         *
%  p0    = null state p.m.f.                               *
%  p1    = alternate state p.m.f.                          *
%                                                          *
%  OUTPUT                                                  *
%  ------                                                  *
%  rate1 = Poisson rate        - alternate hypothesis      *
%  c     = log-likelihood ratio speed                      *
%  taps  = mixed delays for the GMPP model                 *
%  tap1  = first delay                                     *
%  dtap  = distance between delays                         *
%  pmfs  = [p0; p1]                                        *
%                                                          *
%***********************************************************
%
%***************************************
rate1 = rate0*(1+tau)                  ;
tap1  = 1+log(p1(1)/p0(1))/log(1+tau)  ;
tap2  = 1+log(p1(2)/p0(2))/log(1+tau)  ;
dtap  = tap2-tap1                      ;
taps  = [tap1,tap2]                    ;
pmfs  = [p0;p1]                        ;
c     = rate0*tau/log(1+tau)           ;
sprtinfo       = struct                ;
sprtinfo.tau   = tau                   ;
sprtinfo.rate0 = rate0                 ;
sprtinfo.rate1 = rate1                 ;
sprtinfo.c     = c                     ;
sprtinfo.taps  = taps                  ;
sprtinfo.tap1  = tap1                  ;
sprtinfo.dtap  = dtap                  ;
sprtinfo.pmfs  = pmfs                  ;
%***************************************
end %