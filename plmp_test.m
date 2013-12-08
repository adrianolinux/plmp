x = load('iris.data');
t = x(:,end);
x = x(:,1:end-1);
n = size(x,1);

% escolha dos pontos de controle
choice_size = ceil(sqrt(n)); % quantidade de pontos de controle
random_choice = randperm(n);
random_choice = random_choice(1:choice_size);
xs = x(random_choice,:);
ts = t(random_choice);

tic
ys = force(xs);
display('Posicionamento dos pontos de controle: ');
toc

% centralizacao no espaco visual
for i = 1:size(ys,2)
  ys(:,i) = ys(:,i) - sum(ys(:,i))/size(ys,1);
end

tic
y = plmp(x,xs,ys);
display('Projecao: ');
toc

% plot results
figure(1);
clf;
hold on;
color = [0,0,0; 1,0,0; 0,1,0;, 0,0,1];
h = scatter(y(:,1), y(:,2), 25, color(t,:), 'filled');
set(h,'markeredgecolor','k');
plot(ys(ts == 1,1), ys(ts == 1,2), 'ko', ...
     ys(ts == 2,1), ys(ts == 2,2), 'ro', ...
     ys(ts == 3,1), ys(ts == 3,2), 'go', 'markersize', 15);
legend('Projected data', 'Control points projection');
hold off;

%saveas(gcf,'figura.png');

