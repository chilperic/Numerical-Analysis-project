% Partie A
k=2;N=20;a=0.3;

x=zeros(1,N+1); % x represente le maillage des x(i+1/2)
x(1)=0;x(2)=a;x(N+1)=1;
for i=3:N
    x(i)=x(i-1)+(1-x(i-1))*rand(1);
end
d=zeros(1,N); % d represente les |k(i)|=x(i+1/2)-x(i-1/2)
for i=1:N
    d(i)=x(i+1)-x(i);
end
x_mil=zeros(1,N+2); % x_mil represente le maillage des x(i)
x_mil(1)=0;x_mil(N+2)=1;
for i=2:N+1
x_mil(i)=x(i-1)+(x(i)-x(i-1))*rand(1);
end
f=zeros(N,1);
for i=1:N
    f(i)=sqrt(1+(x_mil(i+1))^2);
end

h=zeros(1,N+1); % h represente hg+hd
for i=1:N+1
    h(i)=x_mil(i+1)-x_mil(i);
end
hd=zeros(1,N);
for i=1:N+1
    hd(i)=x_mil(i+1)-x(i);
end
hg=zeros(1,N);
for i=1:N+1
    hg(i)=x(i)-x_mil(i);
end
K=zeros(1,N+1);
for i=1:N+1
    K(i)=(k*k*h(i))/(k*hg(i)+k*hd(i));
end
b=zeros(1,N+1);
for i=1:N+1
    b(i)=K(i)/h(i);
end
c=zeros(1,N);
c(1)=k/h(1);
for i=1:N+1
    c(i+1)=K(i)/h(i);
end
alpha=(k*hg(1))/k*h(1);
% Remplissage de la matrice A

A=zeros(N);
for i=1:N-1
    A(i,i)=b(i)+c(i);
    A(i,i+1)=-b(i);
    A(i+1,i)=-c(i);
end
A(N,N)=b(N)+c(N);

% Remplissage de la matrice B

B=zeros(N,1);
B(1)=d(1)*f(1)-alpha;
B(2)=d(2)*f(2)+alpha;
for i=3:N
    B(i)=d(i)*f(i);
end

% Resolution de AV=B
V=A\B;
U=[0,V',0];

scatter(x_mil,U,'r','LineWidth', 10);
hold on 
plot(x_mil,U,'g','LineWidth', 6)

% Turn on the grid
grid on

% Add title and axis labels
title('Solutions du Probleme avec saut de flux')
xlabel('Points x ')
ylabel('Fonction u(x) solutions du probleme (P)')
hold off

saveas(gcf,'projetA.png')


