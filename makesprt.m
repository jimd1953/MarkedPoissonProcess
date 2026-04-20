%***********************************************************
function [sprtinfo] = makesprt(K,J,sprtinfo,gridinfo) %    *
%***********************************************************
ddeqinfo       = struct                        ;
ddeqinfo.taps  = sprtinfo.taps                 ;
ddeqinfo.c     = sprtinfo.c                    ;
ddeqinfo.K     = K                             ;
ddeqinfo.J     = J                             ;
ddeqinfo.alpha = sprtinfo.rate0/sprtinfo.c     ;
ddeqinfo.p     = sprtinfo.pmfs(1,:)            ;
ddeqinfo       = solvedde(ddeqinfo,gridinfo)   ; 
sprtinfo.V0    = ddeqinfo.V                    ;
sprtinfo.Z0    = ddeqinfo.Z                    ;
sprtinfo.DV0   = ddeqinfo.DV                   ;
sprtinfo.DZ0   = ddeqinfo.DZ                   ;
ddeqinfo.alpha = sprtinfo.rate1/sprtinfo.c     ;
ddeqinfo.p     = sprtinfo.pmfs(2,:)            ;
ddeqinfo       = solvedde(ddeqinfo,gridinfo)   ;
sprtinfo.V1    = ddeqinfo.V                    ;
sprtinfo.Z1    = ddeqinfo.Z                    ;
sprtinfo.DV1   = ddeqinfo.DV                   ;
sprtinfo.DZ1   = ddeqinfo.DZ                   ;
sprtinfo.K     = K                             ;
sprtinfo.J     = J                             ;
%***********************************************
end %