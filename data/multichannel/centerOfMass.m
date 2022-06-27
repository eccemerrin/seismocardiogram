function center = centerOfMass(A)
    
    %sortA = sort(A(:));
    %I = find(cumsum(sortA)/sum(A(:))>0.15);
    %A = A - sortA(I(1));
    %A = A - sortA(floor(end*0.10));
    A = A - max(A(:))+(max(A(:))-min(A(:)))*0.15;
    A(A<0) = 0;

    x = linspace(1,4,size(A, 2)); % Columns.
    y = linspace(1,4,size(A, 1)); % Rows.
    [X, Y] = meshgrid(x, y);
    meanA = mean(A(:));
    center(1) = mean(A(:) .* X(:)) / meanA;
    center(2) = mean(A(:) .* Y(:)) / meanA;
end