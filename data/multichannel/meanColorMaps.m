function meanColorMaps(ztot, data, range, Sc)
FontFS = 22;
L = 11;
levels = linspace(-1,1,L);
colors = lines(length(data.anotation)+1);

set(gcf, 'Position',  [200, 200, 900+400, 500]);
set(gcf, 'DefaultAxesFontSize',22);
for i = 1:length(data.anotation)
    for ii = 1:length(range)
        subplot(length(data.anotation), length(range), ii + (i-1)*length(range))
        normalize = max(abs(ztot(:,:,:,i)),[],'all');
        contourf(squeeze(ztot(ii,:,:,i))/normalize,levels)
        caxis([-1 1])
        colormap(jet(L))
        hold on
        h = scatter([1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4], [1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4],50,'black','square');
        for k = 1:size(Sc,1)
            s = Sc(k,i);
            if any(i == [2 4])
                p = plot(s.centerMassPos(1,ii),s.centerMassPos(2,ii),'m.','MarkerSize',25);
                p2 = plot(s.centerMassPos(1,ii),s.centerMassPos(2,ii),'k+','MarkerSize',7);
            else
                p = plot(s.centerMassNeg(1,ii),s.centerMassNeg(2,ii),'m.','MarkerSize',25);
                p2 = plot(s.centerMassNeg(1,ii),s.centerMassNeg(2,ii),'k+','MarkerSize',7);
            end
        end
        hold off
        axis ij
        set(gca,'xtick',[])
        set(gca,'ytick',[])
        daspect([1 1 1])
        colormap jet
        if i==length(data.anotation)
            xlabel(int2str(range(ii)*1000) + " ms",'FontSize',FontFS)
        end
    end
    if i==length(data.anotation)-1
        title('time relative to fiducial point','FontSize',FontFS)
        legend([h p],{'sensors','center of mass'},'FontSize',FontFS,'Location','NorthOutside','Orientation','horizontal');
        c  = colorbar('FontSize',FontFS,...
          'Ticks',[-1,0,1],...
          'TickLabels',{'min','0','max'});
        c.Label.String = 'average acceleration';
        c.Label.FontSize = FontFS;
        c.Label.Position(1) = c.Label.Position(1) - 0.5;
        c.Label.Position(2) = c.Label.Position(2) - 0.5;
    end
    if i==length(data.anotation)
        ylabel('+','FontSize',15)
    end
    subplot(length(data.anotation), length(range), 1 + (i-1)*length(range))
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
    ylp(1) = ylp(1)-1.0;
    set(ylh, 'Rotation',0, 'Position',ylp, 'VerticalAlignment','middle', 'HorizontalAlignment','center')
end