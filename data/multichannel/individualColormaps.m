function individualColormaps(scg, data, range, Sc)
    FontFS = 22;    
    L=11;
    colors = lines(length(data.anotation)+1);
    % 3D matrix for z axis SCG colormaps
    z(:,1,:) = scg(:,1:4);
    z(:,2,:) = scg(:,5:8);
    z(:,3,:) = scg(:,9:12);
    z(:,4,:) = scg(:,13:16);
    
    for i = 1:length(data.anotation)
        t = round(data.FS*(data.anotation(i)+range));
        
        %%
        for ii = 1:length(t)
            subplot(2+length(data.anotation),length(range),ii+length(range)*2+(i-1)*length(range))
            levels = linspace(-1,1,L);
            contourf(squeeze(z(t(ii),:,:))/max(abs(z(t,:,:)),[],'all'),levels)
            hold on
            h = scatter([1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4], [1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4],50,'black','square');
            if any(i == [2 4]) % For valleys
                p1 = plot(Sc(i).centerMassPos(1,ii),Sc(i).centerMassPos(2,ii),'m.','MarkerSize',25);
                p2 = plot(Sc(i).centerMassPos(1,ii),Sc(i).centerMassPos(2,ii),'k+','MarkerSize',7);
            else % For hills
                p1 = plot(Sc(i).centerMassNeg(1,ii),Sc(i).centerMassNeg(2,ii),'m.','MarkerSize',25);
                p2 = plot(Sc(i).centerMassNeg(1,ii),Sc(i).centerMassNeg(2,ii),'k+','MarkerSize',7);
            end
            hold off
            axis ij
            caxis([-1 1])
            set(gca,'xtick',[])
            set(gca,'ytick',[])
            daspect([1 1 1])
            colormap jet
            if i==length(data.anotation)
                xlabel(int2str(range(ii)*1000) + " ms",'FontSize',FontFS)
                if ii==length(t)-1
                    legend([h p1],{'sensors','center of mass'},'FontSize',FontFS,'Location','NorthOutside','Orientation','horizontal');
                end
                if ii==length(t)
                    ylabel('+','FontSize',15)
                end
            end
        end
        subplot(2+length(data.anotation),length(range),1+length(range)*2+(i-1)*length(range))
        switch i
            case 1
                ylabel('AO_{valley}','FontSize',FontFS,'Color',colors(i,:))
            case 2
                ylabel('AO_{hill}','FontSize',FontFS,'Color',colors(i,:))
            case 3
                ylabel('AC_{valley}','FontSize',FontFS,'Color',colors(i,:))
            case 4
                ylabel('AC_{hill}','FontSize',FontFS,'Color',colors(i,:))
        end
        ylh = get(gca,'ylabel');
        gyl = get(ylh);
        ylp = get(ylh, 'Position');
        ylp(1) = ylp(1)-1.5;
        set(ylh, 'Rotation',0, 'Position',ylp, 'VerticalAlignment','middle', 'HorizontalAlignment','center')
    end