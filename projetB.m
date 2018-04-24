% Partie B
N=20;k=2;
x=zeros(1,N+1); % x represente le maillage des x(i+1/2)
x(1)=0;x(N+1)=1;
for i=2:N
    x(i)=x(i-1)+(1-x(i-1))*rand(1);
end
x_mil=zeros(1,N+2); % x_mil represente le maillage des x(i)
x_mil(1)=0;x_mil(N+2)=1;
for i=2:N+1
x_mil(i)=x(i-1)+(x(i)-x(i-1))*rand(1);
end

d=zeros(1,N); % d represente les |k(i)|=x(i+1/2)-x(i-1/2)
for i=1:N
    d(i)=x(i+1)-x(i);
end

h=zeros(1,N+1); % h represente hg+hd
for i=1:N+1
    h(i)=x_mil(i+1)-x_mil(i);
end
a=zeros(1,N);% a(i)=k(i+1/2)/h(i+1/2)
for i=1:N
    a(i)=2/h(i+1);
end
b=zeros(1,N+1); % b(i)=k(i-1/2)/h(i-1/2)
b(1)=0;
for i=1:N
    b(i+1)=a(i);
end
f=zeros(N,1);
for i=1:N
    f(i)=1+(x_mil(i+1))^2;
end

% remplissage de la matrice A
A=zeros(N);
for i=1:N-1
   A(i,i)=a(i)+b(i);
   A(i,i+1)=-a(i);
   A(i+1,i)=-b(i);
end
A(N,N)=a(N)+b(N);

% remplissage de la matrice B
B=zeros(N,1);
for i=1:N
  B(i)=d(i)*f(i);
end

% resolution du systeme AU_1=B
U_1=A\B;
U=[0,U_1',0];
% solution exacte
U_exact=zeros(N+2,1);
for i=1:N+2
    U_exact(i)=-(1/2)*((1/12)*(x_mil(i))^4+(1/2)*(x_mil(i))^2-(7/12)*x_mil(i));
end

% erreur en norme inf
e=zeros(N+2,1);
for i=1:N+2
    e(i)=abs(U(i)-U_exact(i));
end
e_max=max(e);

% erreur en norme 1,hf
c=zeros(N,1);
for i=1:N
    c(i)=(e(i+1)-e(i))/sqrt(h(i));
end
e_h=norm(c);
