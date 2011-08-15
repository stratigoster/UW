% handle promises
interpret([a, d | T], [promise(P)|R]) :- !,
  getPromise(T,P,R).

% Recursively reduce the tail of the list until it is no longer reducible
% and then do the same with the tail of the tail of the list. At this point
% it is safe to call r1 to perform the application
interpret([a | X], RESULT) :- !,
  interpret(X, [R|RS]),
  interpret(RS, RR),
  r1([a, R | RR], RESULT).

% Terminate if head is anything other than a
interpret(X, X) :- !.

% Rules for applying primitive operators
r1([a, k, X | T], [k(X) | T]) :- !.
r1([a, k(X), _ | T], [X | T]) :- !.
r1([a, s, X | T], [s(X) | T]) :- !.
r1([a, s(X), Y | T], [s(X,Y) | T]) :- !.
r1([a, s(X,Y), Z | T], R) :- ! , interpret([a, a, X, Z, a, Y, Z | T], R).
r1([a, i, X | T], [X | T]) :- !.
r1([a, v, _ | T], [v | T]) :- !.
r1([a, dot(X) | T], T) :- ! , put(X).
r1([a, r | T], T) :- ! , nl.
r1([a, promise(P) | T], R) :- !,
  append(P,T,PT),
  interpret([a | PT],R).

% returns the promise as P, and the rest of the expression in R
getPromise([a | X], [a|PPPP], RRS) :- !,
  getPromise(X, PP, RS),
  getPromise(RS, PPP, RRS),
  append(PP, PPP, PPPP).

getPromise([X|T], [X], T) :- !.

interpretFromText(S, R) :- !,
  convert(S, SS),
  interpret(SS, RR),
  remove_closure(RR,RRR),
  convert(RRRR,RRR),
  string_to_list(R, RRRR).

% convert(X,Y) converts a list X of numbers to their character equivalent, with the result stored in Y
convert([],[]) :- !.
convert([46,X|T], [dot(X)|R]) :- ! , convert(T,R).
convert([96|T], [a|R]) :- ! , convert(T,R).
convert([97|T], [a|R]) :- ! , convert(T,R).
convert([100|T], [d|R]) :- ! , convert(T,R).
convert([105|T], [i|R]) :- ! , convert(T,R).
convert([107|T], [k|R]) :- ! , convert(T,R).
convert([114|T], [r|R]) :- ! , convert(T,R).
convert([115|T], [s|R]) :- ! , convert(T,R).
convert([118|T], [v|R]) :- ! , convert(T,R).
convert([X|T], [X|R]) :- ! , convert(T,R).

remove_closure([],[]) :- !.

remove_closure([s(A,B)|T],R) :- !,
  remove_closure([A],AA),
  remove_closure([B],BB),
  remove_closure(T,TT),
  append(AA,BB,AB),
  append(AB,TT,ABT),
  append("``s",ABT,R).

remove_closure([s(A)|T],R) :- !,
  remove_closure([A],AA),
  remove_closure(T,TT),
  append(AA,TT,AATT),
  append("`s",AATT,R).

remove_closure([k(A)|T],R) :- !,
  remove_closure([A],AA),
  remove_closure(T,TT),
  append(AA,TT,AT),
  append("`k",AT,R).

remove_closure(A,A) :- !.

% convert lambda expression X into an unlambda expression R
unlambdafy(X,R) :-
  u2(X,R2),
  c2(R2,R3),
  convert(R3,R4),
  string_to_list(R,R4).

% this does all the unlambdafication
u2(var(X),[X]) :- !.
u2(func(d),[d]) :- !.
u2(func(i),[i]) :- !.
u2(func(r),[r]) :- !.
u2(func(v),[v]) :- !.
u2(func(dot(X)),[.,X]) :- !.
u2(app(M,N),R) :- !,
  u2(M,M2),
  c2(M2,M3),
  convert(M3,M4),
  u2(N,N2),
  c2(N2,N3),
  convert(N3,N4),
  append([a|M4], N4, R).
u2(abs(var(X),E),R) :- !,
  u2(E,R2),
  c2(R2,R3),
  convert(R3,R4),
  remove_X(X,R4,R).

remove_X(_,[],[]) :- !.

% [x](M,N) = S ([x]M) ([x]N)
remove_X(X,[a|T],ess(R1,R2)) :- !,
  getPromise(T,M,N),
  c2(M,M2),
  convert(M2,M3),
  c2(N,N2),
  convert(N2,N3),
  remove_X(X,M3,R1),
  remove_X(X,N3,R2).

% [x]y = I    if x=y
% [x]y = K y  otherwise
% [x]f = K f
% [x]I = K I
% [x]K = K K
% [x]S = K S
remove_X(X,[X],"i") :- !.
remove_X(_,[A],kay([A])) :- !.

reduce(L,R) :- 
  unlambdafy(L,UL),
  convert(UL,RR),
  interpret(RR,R), !.

reduce(L,R) :- 
  unlambdafy(L,UL),
  string_to_list(UL,LL),
  convert(LL,RR),
  interpret(RR,R), !.

reduce(L,R) :- 
  unlambdafy(L,UL),
  interpret(UL,R), !.

% might need to apply c2 
reduce(L,R) :- 
  unlambdafy(L,UL),
  convert(UL,RR),
  interpret(RR,R2),
  c2(R2,R), !.

reduce(L,R) :- 
  unlambdafy(L,UL),
  string_to_list(UL,LL),
  convert(LL,RR),
  interpret(RR,R2),
  c2(R2,R), !.

reduce(L,R) :- 
  unlambdafy(L,UL),
  interpret(UL,R2),
  c2(R2,R), !.

% remove all this ess/kay stuff, and put in the appropriate amount of a's
c2(ess(A),R) :- !,
  c2(A,AA),
  append("as",AA,R).

c2(ess(A,B),R) :- !,
  c2(A,AA),
  c2(B,BB),
  append("aas",AA,R1),
  append(R1,BB,R).

c2(ess(A,B,C),R) :- !,
  c2(A,AA),
  c2(B,BB),
  c2(C,CC),
  append("aaas",AA,R1),
  append(R1,BB,R2),
  append(R2,CC,R).

c2(kay(A),R) :- !,
  c2(A,AA),
  append("ak",AA,R).

c2(kay(A,B),R) :- !,
  c2(A,AA),
  c2(B,BB),
  append("aak",AA,R1),
  append(R1,BB,R).

c2(A,A) :- !.
