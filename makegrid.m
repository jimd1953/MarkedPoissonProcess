%***********************************************
function gridinfo = makegrid(rmin,rmax,nsubs) %*
%----------------------------------------------*
%                                              *
%     make the log-likelihood ratio grid       *
%                                              *
%  INPUT                                       *
%  -----                                       *
%  rmin  = minimum point (integer)             *
%  rmax  = maximum point (integer)             *
%  nsubs = # bins per unit interval            *
%                                              *
%  OUTPUT                                      *
%  ------                                      *
%  rdel  = gridpoint spacing                   *
%  rsize = # gridpoints                        *
%  rgrid = gridpoint locations                 *
%  rcent = centerpoint locations               *
%  izero = index of point where rgrid=0        *
%                                              *
%***********************************************
%
%***************************************
rdel  = 1/nsubs                        ;
rgrid = rmin:rdel:rmax                 ;
rsize = numel(rgrid)                   ;
rcent = rgrid(1:end-1)+rgrid(2:end)    ;
rcent = rcent/2                        ;
izero = find(rgrid==0)                 ;
if isempty(izero) %                    ;
    err = 'FATAL GRID ERROR: '         ;
    err = strcat(err,'izero empty\n')  ;
    fprintf(1,err)                     ;
    return                             ;
end %                                  ;
gridinfo.nsubs = nsubs                 ;
gridinfo.rmin  = rmin                  ;
gridinfo.rmax  = rmax                  ;
gridinfo.rdel  = rdel                  ;
gridinfo.rsize = rsize                 ;
gridinfo.rgrid = rgrid                 ;
gridinfo.rcent = rcent                 ;
gridinfo.izero = izero                 ;
%***************************************
end %