#!/usr/bin/env swipl -s
male(tick_duck).
male(trick_duck).
male(track_duck).
male(donald_duck).
male(gustav_gans).
male(dussel_duck).
male(wastel_duck).
male(franz).
male(dagobert_duck).
male(degenhard_duck).
male(general_dolo_gans).
male(diebert_duck).
male(jakob_duck).
male(diethelm_duck).
male(david_duck).
male(gruben_gustel_duck).

female(della_duck).
female(mathilda_duck).
female(dortel_duck).
female(dankrade_duck).
female(minchen_duck).

% eltern(). X eltern-teil von Y
eltern(della_duck, tick_duck).
eltern(della_duck, trick_duck).
eltern(della_duck, track_duck).

eltern(degenhard_duck, della_duck).
eltern(dortel_duck, della_duck).

eltern(diebert_duck, mathilda_duck).
eltern(diebert_duck, dagobert_duck).
eltern(diebert_duck, dortel_duck).
eltern(dankrade_duck, mathilda_duck).
eltern(dankrade_duck, dagobert_duck).
eltern(dankrade_duck, dortel_duck).

eltern(gruben_gustel_duck, diebert_duck).
eltern(gruben_gustel_duck, jakob_duck).
eltern(gruben_gustel_duck, diethelm_duck).
eltern(minchen_duck, diebert_duck).
eltern(minchen_duck, jakob_duck).
eltern(minchen_duck, diethelm_duck).

% vater().   X vater von Y -> eltern & male
vater(X,Y) :- eltern(X,Y), male(X).
% mutter().  X mutter von Y -> eltern & female
mutter(X,Y) :- eltern(X,Y), female(X).
% opa().     X opa von Y -> X vater von Z, Z eltern von Y
opa(X,Y) :- vater(X,Z), eltern(Z,Y).
% oma().     X oma von Y -> X mutter von Z, Z eltern von Y
oma(X,Y) :- mutter(X,Z), eltern(Z,Y).
% vorfahre(). X vorfahre von Y -> X eltern von Y ; X eltern von Z, Z eltern von Y
vorfahre(X,Y) :- eltern(X,Y).
vorfahre(X,Y) :- eltern(X,Z), eltern(Z,Y).

% geschwister X geschwister von Y, Z eltern von X, Z eltern von Y, X != Y
geschwister(X,Y) :- eltern(Z,X), eltern(Z,Y), X\=Y.
% burder().   X bruder von Y -> X ist male, geschwister(X,Y)
bruder(X,Y) :- male(X), geschwister(X,Y).
% schwester(). X schwster von Y -> X ist female, geschwister(X,Y)
schwester(X,Y) :- female(X), geschwister(X,Y).
% onkel().     X onkel von Y -> X bruder Z, Z eltern Y
onkel(X,Y) :- bruder(X,Z), eltern(Z,Y).
% tante().     X tante von Y -> X schwester Z, Z eltern Y
tante(X,Y) :- schwester(X,Z), eltern(Z,Y).

% Grossonkel   X grossonkel Y -> X onkel Z, Z eltern Y
grossonkel(X,Y) :- onkel(X,Z), eltern(Z,Y).
% Grosstante   X grosstante Y -> X tante Z, Z eltern Y
grosstante(X,Y) :- tante(X,Z), eltern(Z,Y).

% cousin_grad  X cousin Y -> Z eltern von X, Z geschwister von A, A eltern von Y
cousin_grad(X,Y) :- eltern(Z,X), geschwister(Z,A), eltern(A,Y).
% Cousin       X cousin Y -> X cousin_grad Y, X is male
cousin(X,Y) :- cousin_grad(X,Y), male(X).
% Cousine      X cousine Y -> x cousin_grad Y, X is female
cousine(X,Y) :- cousin_grad(X,Y), female(X).

% Schwager / Schwägerin
