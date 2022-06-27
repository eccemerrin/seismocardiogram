function Sc = trackCenterOfMass(scg, data, range)
    z(:,1,:) = scg(:,1:4);
    z(:,2,:) = scg(:,5:8);
    z(:,3,:) = scg(:,9:12);
    z(:,4,:) = scg(:,13:16);
    
    for i = 1:length(data.anotation)
        t = round(data.FS*(data.anotation(i)+range));

        %% Detect highest hill or vally
        x = 1:1:4; % Columns
        y = 1:1:4; % Rows.
        [T,X,Y] = ndgrid(t, x, y);
        F = griddedInterpolant(T,X,Y,z(t,:,:),'cubic');
        nx = x(1):0.1:x(end);
        ny = y(1):0.1:y(end);
        [tq,xq,yq] = ndgrid(t, nx, ny);
        zq = F(tq,xq,yq);

        %% Center of Mass
        for ii = 1:length(t)
            Sc(1,i).centerMassPos(:,ii) = centerOfMass(squeeze(zq(ii,:,:)));
            Sc(1,i).centerMassNeg(:,ii) = centerOfMass(-squeeze(zq(ii,:,:)));
        end
    end