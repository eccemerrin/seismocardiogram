function rawScgPlot(time, scg1, scg2, scg3, ecg2, ecg3, data)
%parameters for figure and panel size
    plotheight=12;
    plotwidth=13;
    subplotsx=4;
    if data.good_ecg ~= 0 % good ecg
        subplotsy=5;
    else
        subplotsy=4; % missing ecg
    end
    leftedge=1.2;
    rightedge=1.4;   
    topedge=1;
    bottomedge=1.5;
    spacex=0.2;
    spacey=0.2;
    fontsize=5;
    sub_pos=subplot_pos(plotwidth,plotheight,leftedge,rightedge,bottomedge,topedge,subplotsx,subplotsy,spacex,spacey);

    
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperSize', [plotwidth plotheight]);
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [0 0 plotwidth plotheight]);
    set(gcf, 'Position',  [200, 200, 900+400, 700]);
    set(gcf, 'DefaultAxesFontSize',22);

    %loop to create axes
    LineWidth = 2.75;
    for i=1:subplotsx
        for ii=1:subplotsy
            ax=axes('position',sub_pos{i,ii},...
                'XGrid','on','XMinorGrid','on',...
                'YGrid','on','YMinorGrid','on',...
                'FontSize',fontsize,'Box','on','Layer','top');
            if data.good_ecg ~= 0 % good ecg
                if ii>1
                    k = ii-1+(4-i)*4;
                    plot1 = plot(time,scg1(:,k)-mean(scg1(:,k)),'Color',[1 0 0],'LineWidth',LineWidth);
                    plot1.Color(4) = 0.6;
                    hold on
                    plot1 = plot(time,scg2(:,k)-mean(scg2(:,k)),'Color',[0 1 0],'LineWidth',LineWidth);
                    plot1.Color(4) = 0.6;
                    plot1 = plot(time,scg3(:,k)-mean(scg3(:,k)),'Color',[0 0 1],'LineWidth',LineWidth);
                    plot1.Color(4) = 0.6;
                    hold off
                end
                if ii==1
                    if data.good_ecg == 2
                        plot(time,(ecg2-mean(ecg2)),'k','LineWidth',LineWidth);
                    elseif data.good_ecg == 3
                        plot(time,(ecg3-mean(ecg3)),'k','LineWidth',LineWidth);
                    else

                    end
                end
            else
                k = ii+(4-i)*4;
                plot1 = plot(time,scg1(:,k)-mean(scg1(:,k)),'Color',[1 0 0],'LineWidth',LineWidth);
                plot1.Color(4) = 0.6;
                hold on
                plot1 = plot(time,scg2(:,k)-mean(scg2(:,k)),'Color',[0 1 0],'LineWidth',LineWidth);
                plot1.Color(4) = 0.6;
                plot1 = plot(time,scg3(:,k)-mean(scg3(:,k)),'Color',[0 0 1],'LineWidth',LineWidth);
                plot1.Color(4) = 0.6;
                hold off
            end
            if ii==1
                xlabel('time in ms')
            end
            if ii==subplotsy
                title("SCG(#," + int2str(i) + ")")
                if i==subplotsx
                    h=legend('X','Y','Z','Location','NorthEastOutside');
                    set(gca,'position',sub_pos{i,ii})
                end
            end
            if ii>1
                set(ax,'xticklabel',[])
            end
            if i>1
                set(ax,'yticklabel',[])
            end
            if i==1
                ylabel({'acceleration', 'in mg'})
                if data.good_ecg ~= 0 && ii==1
                    ylabel({'amplitude', 'in mV'})
                end
                ylh = get(gca,'ylabel');
                gyl = get(ylh);
                ylp = get(ylh, 'Position');
                ylp(1) = ylp(1)-100;
                set(ylh, 'Rotation',0, 'Position',ylp, 'VerticalAlignment','middle', 'HorizontalAlignment','center')
            end
            xlim([time(1) time(end)])
            set(ax,'xtick',0:150:(time(end)+2))
            if data.good_ecg ~= 0 && ii==1
                set(ax,'ytick',-2:0.5:2)
                ylimit = ylim;
                ylim(ylimit*1.1)
                ax.YAxis.MinorTickValues = -2:0.25:2;
            else
                %ylim([min(min(scg3-mean(scg3)))-shift max(max(scg1-mean(scg1)))+shift])
                ylim([min([min(scg1-mean(scg1)), min(scg2-mean(scg2)), min(scg3-mean(scg3))])...
                      max([max(scg1-mean(scg1)), max(scg2-mean(scg2)), max(scg3-mean(scg3))])]*1.1)
                set(ax,'ytick',-45:15:45)
                ax.YAxis.MinorTickValues = -45:5:45;
            end
            grid on
            grid minor
            %ax = gca
            ax.GridLineStyle = '-';
            ax.GridColor = 'k';
            ax.GridAlpha = 0.7; % maximum line opacity
            ax.MinorGridAlpha = 0.7;
            ax.MinorGridColor = 'k';
            ax.XAxis.MinorTickValues = 0:50:time(end);
        end
    end