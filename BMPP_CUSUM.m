%***********************************************************
%                                                          *
%  CUSUM for quickest detection of a change in a binary    *
%  marked Poisson process (BMPP)                           *
%                                                          *
%***********************************************************
%
%***************************************
%                                      *
%      log-likelihood ratio grid       *
%                                      *
rmin=-80; rmax=80; nsubs=100           ;
gridinfo = makegrid(rmin,rmax,nsubs)   ;
%***************************************
%***********************************************************
%                                                          *
%           BMPP parameters and SPRT boundaries            *
%                                                          *
rate0 = 1.00           ; % prechange arrival rate          *
p0    = [0.555, 0.445] ; % prechange distribution          *
p1    = [0.175, 0.825] ; % postchange    "                 *
ntaps = 2              ; % number of taps                  *
K     = 0              ; % lower SPRT boundary             *
JMIN  = 2              ; % range of upper SPRT boundaries  *
JMAX  = 16             ; %    ...                          *
JVALS = JMIN:JMAX      ; %    ...                          *
dtau  = 1/8            ; % range of rate1/rate0 (tau)      *
taus  = 2.^(-2:dtau:4) ; %    ...                          *
ntaus = numel(taus)    ; %    ...                          *
%***********************************************************
%
%***********************************************************
%                                                          *
%                 CUSUM performance chart                  *
%                                                          *
chart = zeros(JMAX,ntaus,2)                                ;
for J = JVALS %                                            ;
    for itau = 1:ntaus %                                   ;
        tau      = taus(itau)                              ;
        sprtinfo = makebmpp(tau,rate0,p0,p1)               ;
        sprtinfo = makesprt(K,J,sprtinfo,gridinfo)         ;
        i        = gridinfo.izero                          ;
        dv0      = sprtinfo.DV0(i)                         ;
        dz0      = sprtinfo.DZ0(i)                         ;
        dv1      = sprtinfo.DV1(i)                         ;
        dz1      = sprtinfo.DZ1(i)                         ;
        ltf      = log10(rate0*dz0/dv0)                    ;
        ltd      = log10(rate0*dz1/dv1)                    ;
        fmt      = '%9.4f%9.4f%9.4f%9.4f\n'                ;
        fprintf(1,fmt,J,tau,ltd,ltf)                       ;
        chart(J,itau,:) = [ltd,ltf]                        ;
    end %                                                  ;
end %                                                      ;
%***********************************************************