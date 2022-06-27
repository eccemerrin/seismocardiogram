function ztot = sumColorMaps(ztot, scg, data, range)
    z(:,1,:) = scg(:,1:4);
    z(:,2,:) = scg(:,5:8);
    z(:,3,:) = scg(:,9:12);
    z(:,4,:) = scg(:,13:16);
    for i = 1:length(data.anotation)
        t = floor(data.FS*(data.anotation(i)+range));
        normalize = max(abs(z(t(1):t(end),:,:)),[],'all');
        ztot(:,:,:,i) = ztot(:,:,:,i) + z(t,:,:)/normalize;
    end