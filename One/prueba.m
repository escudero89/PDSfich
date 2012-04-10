aaa=1;

[t1,y1] = m_sin(0, 2, 1000, 10, 0);
[t,y] = m_sin(0, 2, 9, 10, 0);

plot(t1,y1,'g');
hold on;
stem(t,y);
hold off;