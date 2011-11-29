[d r t] = registration(stats,[],[]);

r2 = r;

[d r t] = registration(stats,r2,[]);

r3 = r;

[d r t] = registration(stats,r3,[]);

t2 = t;

[d t] = tracked(stats,t2);