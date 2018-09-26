% two 2x5 arrays with random data
a1 = rand(2,5);
a2 = rand(2,5);

% two subplots
subplot(211)
scatter(a1(1,:),a1(2,:))
% Convert axes coordinates to figure coordinates for 1st axes
[xa1 ya1] = ds2nfu(a1(1,:),a1(2,:));


subplot(212)
scatter(a2(1,:),a2(2,:))
% Convert axes coordinates to figure coordinates for 2nd axes
[xa2 ya2] = ds2nfu(a2(1,:),a2(2,:));

% draw the lines
for k=1:numel(xa1)
    annotation('line',[xa1(k) xa2(k)],[ya1(k) ya2(k)],'color','r');
end