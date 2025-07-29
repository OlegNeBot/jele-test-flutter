# jele_test_flutter

Тестовое задание с использованием пуш-уведомлений с firebase.

***

### Функциональность приложения:
1. Вывод _firebase token_ на экране;
2. Уведомления:
    * Обработка полученных уведомлений с firebase;
    * Вывод уведомлений:
        * Когда приложение закрыто (terminated);
        * Когда приложение свернуто (background);
        * При открытом приложении (foreground).

### Использованные пакеты:
* ```firebase_core``` и ```firebase_messaging``` - уведомления с firebase;
* ```flutter_local_notifications``` - для работы с foreground-уведомлениями.
