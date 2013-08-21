iris = load('../data/iris.data');
[x,idx] = unique(iris(:,1:4), 'rows');
t = iris(idx,5);
n = size(x,1);

% centralizacao no input space
for i = 1:size(x,2)
  x(:,i) = x(:,i) - sum(x(:,i))/size(x,1);
end

% escolha dos pontos de controle
choice_size = ceil(sqrt(n)); % quantidade de pontos de controle
random_choice = unique( randi(n,1,choice_size) );
xs = random_choice; %x(random_choice,:);
ty = t(random_choice);

tic
[ys,z] = force(x(xs,:),20);
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
% o = pontos de controle no visual space
% * = projecao dos pontos de controle
% . = projecao
clf;
hold on;
plot(ys(ty == 1,1), ys(ty == 1,2), 'ro', 'MarkerSize', 15);
plot(ys(ty == 2,1), ys(ty == 2,2), 'bo', 'MarkerSize', 15);
plot(ys(ty == 3,1), ys(ty == 3,2), 'go', 'MarkerSize', 15);
plot(y(t == 1,1), y(t == 1,2), 'r.', ...
     y(t == 2,1), y(t == 2,2), 'b.', ...
     y(t == 3,1), y(t == 3,2), 'g.');
plot(y(random_choice(t(random_choice) == 1),1), y(random_choice(t(random_choice) == 1),2), 'r*', ...
     y(random_choice(t(random_choice) == 2),1), y(random_choice(t(random_choice) == 2),2), 'b*', ...
     y(random_choice(t(random_choice) == 3),1), y(random_choice(t(random_choice) == 3),2), 'g*');
hold off;

%saveas(gcf,'figura.png');
%exit

