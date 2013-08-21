% X  = dataset (matrix: number of instances X dimension of input space)
% Xs = control points index on dataset (list of index)
% Ys = projection of control points on visual space (matrix: number of
%      instances X dimension of visual space)
function Y = plmp(X,Xs,Ys)
  [n,d] = size(X); % n = #dataset, d = dim input space
  [a,p] = size(Ys); % a = #Ys, p = dim visual space
  k = size(Xs,2); % #Xs
  
  if (a ~= k)
    display('PLMP ERROR: Number of control points on Xs and Ys must be the same');
    return
  end

  Phi = zeros(d,p);
  L = X(Xs,:)';

  for j = 1:p
    Phi(:,j) = Ys(:,j)' * L' * inv(L*L')
  end

  Y = zeros(n,p);
  for i = 1:n
    Y(i,:) = X(i,:) * Phi;
  end
