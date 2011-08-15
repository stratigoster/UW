% function Tposition = target(t, target_number)
%
% This is the target function for the pursuit
% problem. It is really two different targets.
% A particular target is selected by setting the 
% input argument "target_number" to 1 or 2.
%
function Tposition = target(t, target_number)

    Tposition = zeros(2,1);
    
    if target_number == 1  % target flies at unit speed on straight line
        Tposition(1) = t/sqrt(2) + 5;
        Tposition(2) = t/sqrt(2);
    elseif target_number == 2
        %
        % Place your code here.
        %
        Tposition(1) = 1 - 2*abs(mod(t,2)-1);
        Tposition(2) = 1+t;
    else
        disp('target_number not set');
    end
