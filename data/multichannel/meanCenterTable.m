function Tab = meanCenterTable(Sc)


    for filenr = 1:size(Sc,1)
        for i = 1:size(Sc,2)
            switch i
                case 1
                    c1x(filenr,:) = Sc(filenr,i).centerMassNeg(1,:)*40-80;
                    c1y(filenr,:) = (-Sc(filenr,i).centerMassNeg(2,:)+3)*40;
                case 2
                    c2x(filenr,:) = Sc(filenr,i).centerMassPos(1,:)*40-80;
                    c2y(filenr,:) = (-Sc(filenr,i).centerMassPos(2,:)+3)*40;
                case 3
                    c3x(filenr,:) = Sc(filenr,i).centerMassNeg(1,:)*40-80;
                    c3y(filenr,:) = (-Sc(filenr,i).centerMassNeg(2,:)+3)*40;
                case 4
                    c4x(filenr,:) = Sc(filenr,i).centerMassPos(1,:)*40-80;
                    c4y(filenr,:) = (-Sc(filenr,i).centerMassPos(2,:)+3)*40;
            end
        end
    end

    clear T
    for i = 1:size(c1x,2)
        T(1,i) = int2str(mean(c1x(:,i))) + "(" + int2str(std(c1x(:,i))) + ")";
        T(2,i) = int2str(mean(c1y(:,i))) + "(" + int2str(std(c1y(:,i))) + ")";
        T(3,i) = int2str(mean(c2x(:,i))) + "(" + int2str(std(c2x(:,i))) + ")";
        T(4,i) = int2str(mean(c2y(:,i))) + "(" + int2str(std(c2y(:,i))) + ")";
        T(5,i) = int2str(mean(c3x(:,i))) + "(" + int2str(std(c3x(:,i))) + ")";
        T(6,i) = int2str(mean(c3y(:,i))) + "(" + int2str(std(c3y(:,i))) + ")";
        T(7,i) = int2str(mean(c4x(:,i))) + "(" + int2str(std(c4x(:,i))) + ")";
        T(8,i) = int2str(mean(c4y(:,i))) + "(" + int2str(std(c4y(:,i))) + ")";
    end
    
    names = ["AOvalley", "AOvalley", "AOhill", "AOhill",...
             "ACvalley", "ACvalley", "AChill", "AChill"].';
    axis = ["x", "y", "x", "y", "x", "y", "x", "y"].';
    Tab = table(names, axis,...
        T(:,1),T(:,2),T(:,3),T(:,4),...
        T(:,5),T(:,6),T(:,7),T(:,8),T(:,9),...
          'VariableNames',{'fiducial_point','axis',...
          'neg8ms','neg6ms','neg4ms','neg2ms','zero','pos2ms','pos4ms','pos6ms','pos8ms'});
    Tab.Properties.Description = 'Average coordinates of center of mass in the 4 by 4 sensor grid, read as coordinate mean(SD). All coordinates are in mm and relative to the Xiphoid Process at (0 mm, 0 mm). X-axis is distance in the transversal plane, with positive as left side, and Y-axis is distance in the sagittal plane, with positive above the Xiphoid Process.';