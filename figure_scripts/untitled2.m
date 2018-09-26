clf
h = axes;
plot(h,rand(10,1));
pos = get(h,'Position');
new_h = axes('Position',pos);
linkaxes([h new_h],'y');
pos(3) = eps; %Edited here
set(new_h,'Position',pos,'XTick',[],'XTickLabel',[]);
set(h,'Visible','off');