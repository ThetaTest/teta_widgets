# Che cos'è l'intrinsicStates

Vengono definiti Intrinsic States tutti gli stati (variabili, attributi) di una classe che rimaranno sempre fissi per un grosso numero di oggetti.

## Esempio

Stiamo programmando un videogioco in cui c'è un enorme numero di nemici, divisi in classi.
La classe del nemico è possibile rappresentarla così:

class Enemy {
    String name;
    dynamic model; 
    dynamic texture;

    double x, y;

    void move(x, y) {}

    void attack() {}
}

Tutte i nemici di una determinata classe hanno name, model e texture identici, quindi il nostro obiettivo è staccarli dalla classe Enemy per istanziare le 3 variabili una sola volta per tutti gli oggetti:

class IntrinsicStates {
    String name;
    dynamic model;
    dynamic texture;
}

class Enemy {
    IntrinsicStates state;

    double x, y;
    ecc...
}

In questo modo seguendo il modello FlyWeight con ulteriori modifiche potremo istanziare un solo oggetto di IntrinsicStates valido per tutti i nemici di quel tipo.

Per saperne di più sul modello FlyWeight consiglio la lettura di 
https://dart.academy/structural-design-patterns-for-dart-and-flutter-flyweight/

## Risultato

Risparmiamo spazio in memoria perchè non andiamo a ripetere più variabili per tutti i nodi, che potrebbero arrivare ad essere centinaia in una pagina di Teta.