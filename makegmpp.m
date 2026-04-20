%***********************************************************
function sprtinfo = makegmpp(tau,rate0,q0,q1,ntaps) %      *
%----------------------------------------------------------*
%                                                          *
%         Geometric Marked Poisson Process (GMPP)          *
%                                                          *
%  INPUT                                                   *
%  -----                                                   *
%  tau   = fractional rate increase                        *
%  rate0 = Poisson rate        - null hypothesis           *
%  q0    = success probability - null hypothesis           *
%  q1    = success probability - alternate hypothesis      *
%  ntaps = # of taps                                       *
%                                                          *
%  OUTPUT                                                  *
%  ------                                                  *
%  rate1 = Poisson rate        - alternate hypothesis      *
%  c     = log-likelihood ratio speed                      *
%  taps  = mixed delays for the GMPP model                 *
%  tap1  = first delay                                     *
%  dtap  = distance between delays                         *
%  pmfs  = [p0; p1]                                        *
%  errs  = errors induced by truncating # geometric terms  *           
%                                                          *
%***********************************************************
%
%***************************************
rate1 = rate0*(1+tau)                  ;
bq0   = 1-q0                           ;
bq1   = 1-q1                           ;
tap1  = 1+log(q1/q0)/log(1+tau)        ;
dtap  = log(bq1/bq0)/log(1+tau)        ;
taps  = tap1 + (0:ntaps-1)*dtap        ;
p0    = q0*exp((0:ntaps-1)*log(bq0))   ;
p1    = q1*exp((0:ntaps-1)*log(bq1))   ;
err0  = log10(1-sum(p0))               ;
err1  = log10(1-sum(p1))               ;
p0    = p0/sum(p0)                     ;
p1    = p1/sum(p1)                     ;
pmfs  = [p0;p1]                        ;
c     = rate0*tau/log(1+tau)           ;
sprtinfo       = struct                ;
sprtinfo.tau   = tau                   ;
sprtinfo.rate0 = rate0                 ;
sprtinfo.rate1 = rate1                 ;
sprtinfo.q0    = q0                    ;
sprtinfo.q1    = q1                    ;
sprtinfo.c     = c                     ;
sprtinfo.ntaps = ntaps                 ;
sprtinfo.taps  = taps                  ;
sprtinfo.tap1  = tap1                  ;
sprtinfo.dtap  = dtap                  ;
sprtinfo.pmfs  = pmfs                  ;
sprtinfo.errs  = [err0,err1]           ;
%***************************************
end %