%sumdiag(LL, X).
%LL -lista list
%X -suma element�w na g��wnej przek�tne
%
dl([],0).
dl([_|T], N):-dl(T, N1), N is N1+1.

del_n(0, L, L).
del_n(N, [_|T],R):-N1 is N-1, del_n(N1, T, R).

nth(N,L,X):-N1 is N-1, del_n(N1, L, [X|_]).

sumdiag([[Sum|_]], Sum):-!.
sumdiag(LL, Sum):- dl(LL, N), append(LL1, [L], LL),  sumdiag(LL1, Sum1), nth(N, L, X), Sum is Sum1+X.

%miduniq(LL, Q)LL -lista list
%Q -lista unikalnych �rodkowych element�w list

mymember(X,[X|_]).
mymember(X, [_|T]):-mymember(X,T).

mymid([X], X).
mymid([_|L], X):-append(L1,[_],L), mymid(L1,X).

miduniq([L], []):-dl(L,N), 0 is mod(N,2).
miduniq([L], [X]):-mymid(L,X).
miduniq([L|LL], R):- dl(L,N), 0 is mod(N,2), miduniq(LL,R),!.
miduniq([L|LL], [H|T]):- dl(L,N), 1 is mod(N,2), miduniq(LL, T), mymid(L,H), \+mymember(H,T),!.
miduniq([L|LL], T):- dl(L,N), 1 is mod(N,2), miduniq(LL, T), mymid(L,H), mymember(H,T).

% Przekszta�ca list� tak, �e ka�dy jej element powtarza si� indeks
% elementu razy. stepgrow(La, L)
nofx(0, _, []).
nofx(N, X, [X|T]):-N1 is N-1, nofx(N1, X, T),!.

stepgrow([X],[X]).
stepgrow(L, R):-append(L1, [X], L), stepgrow(L1, R1), dl(L, N), nofx(N, X, NX), append(R1, NX, R).

%Odpowied� na pytanie, czy liczba N jest liczb� doskona��. Odpowied� tylko "Yes" lub "No". perfect(N)

from1toN(1,[1]):-!.
from1toN(N,L):-N1 is N-1, from1toN(N1, L1), append(L1, [N], L),!.


dzielniki(N, [], [1]):-N=1,!;N=2,!.
dzielniki(N, L, []):-X is N/2, floor(X, N1),from1toN(N1, L),!.
dzielniki(N, L, [H|T]):-dzielniki(N, [H|L], T), N mod H =:= 0,!.
dzielniki(N, L, T) :- dzielniki(N, [H|L], T),!, K is mod(N,H), K\=0.

sum([], 0).
sum([H|T], R):-sum(T, R1), R is R1+H.

perfect(1):-!, fail.
perfect(N):-dzielniki(N,[],L), sum(L,N1), N1 \= N, fail, !.
perfect(N):-dzielniki(N, [], L),!, sum(L, N),!.

%%
perfect1(1):-!, fail.
perfect1(N):-perfect1(N, N, 0).
perfect1(_, 0, _).
perfect1(N, Sum, Licz):-Licz2 is Licz + 1, N mod Licz2 =:= 0, !, Sum2 is Sum -Licz2,perfect1(N, Sum2, Licz2).
perfect1(N, Sum, Licz):-Licz2 is Licz + 1, Licz2 =< N,!, perfect1(N, Sum, Licz2).

%Podzia� listy na dwie podlisty w nast�puj�cy spos�b:w pierwszej maj� by� wszystkie wyst�pienia elementu podanego jako parametr, w drugiej reszta,
%podziallisty(X, L, L1, L2)

podziallisty(_, [], [], []).
podziallisty(X, [X|T], [X|R1], R2) :- podziallisty(X, T, R1, R2).
podziallisty(X, [H|T], R1, [H|R2]) :- H \= X, podziallisty( X, T, R1, R2).

%Oblicza sum� element�w macierzy dolnotr�jk�tnej (��cznie z przek�tn�) z podanej macierzy kwadratowej.
%sumtriangle(LL, S)
%

sumtriangle([[S|_]], S).
sumtriangle(LL, Sum) :- append(LL1, [L],LL), sumtriangle(LL1, Sum1),dl(LL,N), append(L1, _, L), dl(L1,N), sum(L1, SumL), Sum is Sum1 + SumL.

%Usuwanie co drugiego elementu z listy.
usunco2([],[]).
usunco2([X],[X]).
usunco2([X,_|T], [X|R1]) :- usunco2(T, R1),!.
%usunco2([_|T], R) :- usunco2(T,R).

% ZADANIE 1
%
% predykat deldiff(Element,List1,List2) usuwa z listy atom�w "List1" wszystkie
% elementy r�ne od "Element" i w efekcie powstaje lista "List2"
% UWAGA: wykorzysta� odci�cie i niejawn� unifikacj�!

deldiff(_, [], []).
deldiff(X, [X|T], [X|R]):-deldiff(X, T, R),!.
deldiff(X, [_|T], R):-deldiff(X,T,R).

% ZADANIE 2
%
% Predykat allafter(List1, Element, List2) podaje list� "List2" wszystkich
% element�w z listy atom�w "List1", kt�re znajduj� si� za atomem "Element"
% UWAGA: nie wykorzystywa� predykatu concat/append!

%allafter(_, [], []).
allafter(X, [X|T], T):-!.
allafter(X, [_|T], R):-allafter(X, T, R).

% ZADANIE 3
%
% Predykat occur(X,L,N) jest spe�niony, gdy symbol X wyst�puje N razy na li�cie L

occur(_, [], 0).
occur(X, [X|T], N) :- occur(X, T, N1), N is N1+1,!.
occur(X, [_|T], N) :- occur(X, T, N).

% ZADANIE 4
%
% Predykat adduplist(L,K) tworzy list� K z listy liczb L
% poprzez sumowanie przyrostowo kolejnych jej element�w
% np. adduplist([1,4,2,7,12],K) daje wynik K=[1,5,7,14,26]
% UWAGA: �atwiej rozwi�za� definiuj�c pomocniczy predykat!
%
adduplist([N], [N]):-!.
adduplist(L, K) :- append(L1, [LastL], L), adduplist(L1, K1), append(_, [LastK1], K1), LastK is LastL+LastK1, append(K1, [LastK], K).
% ZADANIE 5
%
% Predykat adjacent(X,Y,L) jest spe�niony, gdy elementy X i Y s� obok siebie na li�cie
% UWAGA: nie wykorzystywa� predykatu concat/append!

adjacent(X,Y,[X,Y|_]):-!.
adjacent(X,Y,[Y,X|_]):-!.
adjacent(X,Y, [_|T]) :- adjacent(X,Y,T).

% ZADANIE 6
%
% Predykat sumpair(L1,L2) generuje list� liczb L2 sumuj�c parami liczby z listy L1
% np. sumpair([1,3,2,5,8,9],Z). daje Z=[4,7,17], bo 1+3=4, 2+5=7, 8+9=17
% Je�li L1 jest nieparzystej d�ugo�ci, to L2 na ko�cu powinno mie� jej ostatni element.
% Je�eli L1 jest pusta, to L2 te� jest pusta.
% UWAGA: zrobi� to z jednym predykatem!
%

sumpair([],[]).
sumpair([X], [X]).
sumpair([X,Y|T], [N|R]) :- sumpair(T, R), N is X+Y.

% ZADANIE 7
%
% Generowanie listy kolejnych liczb ca�kowitych od zadanego N a� do warto�ci -1,
% przy czym liczby parzyste maj� by� dodatnie, a nieparzyste - ujemne
% predykat altersign(L,N), gdzie L lista wynikowa, N- warto�� pocz�tkowa
% % UWAGA: rozwi�za� to w dw�ch wariantach:
% % pierwszy, gdy lista wynikowa jest posortowana malej�co co do warto�ci
% % bezwgl�dnych np. ?-altersign(7,L). L=[-7,6,-5,4,-3,2,-1]
% % drugi, gdy lista wynikowa posortowana jest rosn�co (nieco trudniej!)
%

altersign(-1, [-1]):-!.
altersign(N, [N|R]):-0 is mod(N,2), N1 is N-1, altersign(N1,R),!.
altersign(N, [N1|R]):- N2 is N-1, N1 is -N, altersign(N2,R).

altersign2(N, L):-altersign(N, L1), reverse(L, L1).

% ZADANIE 8
%
% Generowanie listy g��w wszystkich list s�adowych listy wej�ciowej
% predykat heads(LList,HList) gdzie LList to lista list, za� HList to lista ich g��w
% ?-heads([[b,c],[f,g,h],[i,j,k,l]],Hs). Hs=[b,f,i]
% Je�li jakakolwiek z list sk�adowych listy wej�ciowej jest pusta, predykat nie jest
%spe�niony.

heads([], []).
heads([[H|_]|T], [H|R]) :- heads(T, R).


% ZADANIE 9
%
% Predykat prepend(E,L1,L2) dodaje do ka�dej listy sk�adowej listy L1 element E na jej
%pocz�tku
% w wyniku czego otrzymujemy list� L2
% ?-prepend(a,[[b,c],[f,g,h],[i,j,k,l]],L2). L2=[[a,b,c],[a,f,g,h],[a,i,j,k,l]]
% Je�eli L1 jest pusta, to L2 te� powinna by� pusta.
%
prepend(X, [L], [[X|L]]).
prepend(X, [L|LL], [[X|L]|R]):-prepend(X, LL, R).


podzial([],_,[]).
podzial(X,Y,Z):-pom(X,Y,A,B),append([A],C,Z),podzial(B,Y,C),!.

pom([],_,[],[]).
pom([H|T],H,[],T).
pom([H|T],X,[H|T2],Y):-pom(T,X,T2,Y),!.
