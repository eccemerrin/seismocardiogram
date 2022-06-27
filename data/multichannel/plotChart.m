function plotChart(data, time, scg, ecg2, ecg3, range)
FontFS = 22;

plot(time,scg(:,data.xip),'k','LineWidth',2);
hold on
if data.good_ecg == 2
    plot(time,(ecg2-mean(ecg2))*10-20,'k--','LineWidth',2);
elseif data.good_ecg == 3
    plot(time,(ecg3-mean(ecg3))*10-20,'k--','LineWidth',2);
else
    % Missing ECG
end
a = ylim;

% Plot the four fiducial points
colors = lines(length(data.anotation)+1);
for i = 1:length(data.anotation)
    plot(time(floor(data.FS*data.anotation(i)))*[1 1],50*[-1 1],'-.','Color',colors(i,:),'LineWidth',2)
end
grid minor
grid on
ax = gca;
ax.GridLineStyle = '-';
ax.GridColor = 'k';
ax.GridAlpha = 0.7; % maximum line opacity
ax.MinorGridAlpha = 0.7;
ax.MinorGridColor = 'k';
for i = 1:length(data.anotation)
    rectangle('Position',...
          [(range(1)+data.anotation(i))*1000-2 -100 (abs(diff(range([1 end]))))*1000 200],...
          'FaceColor',[colors(i,:) 0.5],'EdgeColor','none')
    switch i
        case 1
            txt = 'AO_{valley}';
            shift = -95;
        case 2
            txt = 'AO_{hill}';
            shift = 10;
        case 3
            txt = 'AC_{valley}';
            shift = -95;
        case 4
            txt = 'AC_{hill}';
            shift = 10;
    end
    text(data.anotation(i)*1000+shift,...
        ceil(max(scg(:,data.xip))/5)*5,...
        txt,'FontSize',FontFS,'Color',colors(i,:))
end
hold off
% Create legend for Chart
if data.good_ecg == 2
    legend({'SCG(3,2)','ECG II'},'FontSize',FontFS,'Location','NorthEast');
elseif data.good_ecg == 3
    legend({'SCG(3,2)','ECG III'},'FontSize',FontFS,'Location','NorthEast');
else
    legend({'SCG(3,2)'},'FontSize',FontFS-1,'Location','NorthEast');
end

% Set and move Y label
ylabel({'acceleration', 'in mg'},'FontSize',FontFS)
ylh = get(gca,'ylabel');
ylp = get(ylh, 'Position');
ylp(1) = ylp(1)-15;
set(ylh, 'Rotation',90, 'Position',ylp, 'VerticalAlignment','middle', 'HorizontalAlignment','center')
% Set and move X label
xlabel("\Leftarrow time in ms",'FontSize',FontFS)
ylh = get(gca,'xlabel');
gyl = get(ylh);
ylp = [625 -31.0 0];
set(ylh, 'Rotation',0, 'Position',ylp, 'VerticalAlignment','middle', 'HorizontalAlignment','left')
% Set axis limits for chart
ax = gca;
ax.FontSize = FontFS;
xlim([time(1) time(end)])
ylim([a(1) ceil(max(scg(:,data.xip))/5)*5+5])
% Insert colorbar
c  = colorbar('FontSize',FontFS,...
          'Ticks',[-1,0,1],...
          'TickLabels',{'min','0','max'});
L=11;
colormap(jet(L))
c.Label.String = 'acceleration';
c.Label.FontSize = FontFS;
c.Label.Position(1) = c.Label.Position(1) - 0.5;
c.Label.Position(2) = c.Label.Position(2) - 0.5;
caxis([-1 1])
% Insert xlabel for colormaps
title('time relative to fiducial point','FontSize',FontFS)