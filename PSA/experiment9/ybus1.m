function Y = ybus1(zdata)
    nl = zdata(:,1); % from bus
    nr = zdata(:,2); % to bus
    R = zdata(:,3); % line resistance per unit
    X = zdata(:,4); % line reactance per unit
    nbr = length(zdata(:,1)); 
    nbus = max(max(nl), max(nr)); % number of buses in the system
    
    Z = R + 1i*X;  % branch impedance
    y = ones(nbr,1)./Z; % branch admittance
    Y = zeros(nbus,nbus); % initialize Y to zero

    % Formation of the off-diagonal elements
    for k = 1:nbr
        if nl(k) > 0 && nr(k) > 0
            Y(nl(k),nr(k)) = Y(nl(k),nr(k)) - y(k);
            Y(nr(k),nl(k)) = Y(nl(k),nr(k)); % Symmetric assignment
        end
    end

    % Formation of the diagonal elements
    for n = 1:nbus
        for k = 1:nbr
            if nl(k) == n || nr(k) == n
                Y(n,n) = Y(n,n) + y(k);
            end
        end
    end
end
