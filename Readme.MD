# Торговый автомат для продажи воды в розлив

disclaimer:
исходники гарантировано собираются на Visual Studio 2017 с апдейтами на декабрь 2018г., но содержат ошибки, препятствующие нормальному функционированию. Ошибок немного, критическая всего одна. Исправлений здесь не будет по следующим причинам: 1. мне лень и за деньги тоже лень; 2. среднестатистический барыга не сможет заюзать в виде готового решения и будет вынужден поддержать индустрию разработки ПО.

Аппаратное обеспечение:
- Raspberry Pi 3 + HDMI дисплей 800х480, ATTiny85, ATMEGA1284, монетоприемник: Currenza C2 Blue MDB, купюроприемник: ICT A7/V7 MDB, касса: "Казначей ФА" (https://казначей.онлайн/).
- датчики: DS18B20 - 2 шт в герметичном корпусе, DHT22 - 1шт.
- датчик уровня воды fyd-sr04 с выносным УЗ излучателем (алиэкспресс).
- импульсный датчик потока жидкости DN20 flow meter 3/4 (алиэкспресс)
- ОС и другое ПО: клиент - MS Windows IoT Core, сервер - MS Windows Server 2016 (IIS + ASP.Net + .Net 4.6.1), MS SQL Server 2012
- Платформа и средства разработки: .NET Core c#, c++ @ Visual Studio 2017, Arduino IDE 1.8


Проект содержит набор технологической документации и исходных текстов ПО для самостоятельного (кустарного) производства электронной управляющей части торговых автоматов для продажи воды в розлив, и организации централизованного контроля сетью таких аппаратов.
Система обеспечивает сбор, хранение и систематизацию телеметрии и отчетов о продажах, а также удаленное управление автоматами (переключение режимов работы, смена некоторых настроек). Обмен данными защищен стойкой криптографией. Устройства разделены на группы, доступ к которым ограничен только учетной записью владельца личного кабинета.
Администратор сайта доступа к данным пользователей не имеет, выполняет функции мониторинга.
На одном сервере управления можно создать практически неограниченное количество акаунтов (личных кабинетов) пользователей, каждый из которых может зарегистрировать любое количество устройств (в пределах выданной администратором сайта лицензии).

"Мозгом" устройства является одноплатный компьютер Raspberry Pi 3 model B+. Вспомогательные устройства - плата реле, плата датчика уровня и взаимодействия с кассовым аппаратом, плата головного модуля.
Дизайн печатных плат подразумевает их установку в корпуса на DIN рейку пр-во Gainta https://www.chipdip.ru/catalog-show/plastic-cases?p.0=Gainta&x.1206=vJt

Серверная часть должна быть размещена на сервере под управлением MS Windows 2008+, требует MS SQL Server 2008+ и .Net 4.6.1+
Для связи с серверной частью в каждом автомате должен быть выход в Интернет с головного устройства (RPi). В опытном образце был установлен 5-портовый коммутатор и 3G-роутер с LAN разьемом с алиэкспресс за 300 рублей.

При использовании кассового аппарата (флаг UseKKT в модуле GlobalVars выставлен в true), он должен быть настроен до подключения к автомату. Для использования касс другой модели, модуль взаимодействия с ККТ должен быть переписан в соответствии с документацией.

Без ККТ не тестировалось, возможна нестабильная работа. В "безголовом" режиме, т.е. без связи с сервером работа не предусмотрена вообще.

Распространяется в виде "как есть" свободно. Владелец репозитория не несет ответственности на любые негативные последствия использования проекта или его частей. При разработке систем на основе данного проекта, ссылка на проект обязательна.


Видео работы собранного прототипа:

[![Video](http://img.youtube.com/vi/Y7MAJ8CCs8g/0.jpg)](https://www.youtube.com/watch?v=Y7MAJ8CCs8g)

Пример работы в личном кабинете системы управления:

[![Video](http://img.youtube.com/vi/gMk6wb8pl_E/0.jpg)](https://www.youtube.com/watch?v=gMk6wb8pl_E)

# Порядок действий

Аппаратная часть.
1. Травление, сборка, пайка, тестирование печатных плат устройств (см каталог PCB, необходимо ПО Sprint Layout 6.0. Файлы содержат полный перечень компонентов). 
2. Подключение вспомогательных устройств к плате головного модуля. 
Для использования ККТ нужен будет переходник USB-UART на базе FT232 (будьте внимательны, цена менее 7 долларов означает поддельный чип FTDI).
3. Подключение остальной периферии (купюроприемник, монетоприемник - к MDB интерфейсу головного модуля) в соответствии с маркировкой выводов. Понадобятся блоки питания на 5В и 24В.

Модификация и установка ПО:

Перед тем, как приступить, необходимо: 
~~а) определиться с местом хранения временных файлов генератора графиков. По умолчанию это будет папка на сервере C:\TempImageFiles, ее создание и установка прав на доступ веб-сервера будут сделаны автоматически при первичной настройке сервера.
При необходимости изменения нужно внести в файл web.config в корне веб-сайта, и в исходный текст метода Form1.FinishWizard проекта VendingServerInitialSetup, строка if (!SetFolderPermission(@"C:\TempImageFiles"))...~~

б) Зарегистрироваться на сервисе Bing Maps в качестве разработчика, сгенерировать ключ доступа к API

в) Нарисовать картинку с логотипами и\или рекламой для демонстрации на экране в режиме ожидания 800*480 пикс.

1. Установка на сервер роли IIS с поддержкой ASP.Net, Установка .NET 4.6.1+.
2. Установка на сервер MS SQL 2008+.
3. Редактирование на сервере скрипта SQL: местоположение файлов БД на диске, логин\пароль пользователя БД.
4. Создание БД отредактированным скриптом на сервере .
5. ~~Редактирование исходных текстов сайта: строка подключения к БД, содержание писем.~~ Сборка и публикация сайта на настроенный сервер.
6. ~~Редактирование исходников средства начальной настройки (VendingServerInitialSetup) - изменить строку подключения к БД, затем запуск на сервере и первичная настройка сервера с его помощью.~~ Сборка проекта VendingServerInitialSetup, запуск на сервере для настройки.
После настройки имеем админский акаунт на ~~сервере~~ сайте. Открытый ключ сервера сохраняется в каталог откуда запускается программа, при генерации новых ключей файл открывается автоматически.
~~**ВАЖНО**: ОБЯЗАТЕЛЬНО СОХРАНИТЬ ПУБЛИЧНЫЙ КЛЮЧ СЕРВЕРА В ПРОЦЕССЕ НАСТРОЙКИ, ИНАЧЕ ПРИДЕТСЯ УДАЛЯТЬ КЛЮЧИ ИЗ БД ВРУЧНУЮ И ГЕНЕРИРОВАТЬ НОВЫЕ!~~
7. Редактирование исходных кодов клиентского приложения RpiVendApp:
модуль GlobalVars.cs поле ServerPublicKey - здесь должна быть строка из файла публичного ключа, сохраненного на шаге 6;
фоновая картинка для главного экрана, расположенная по пути Assets\LogoSample.jpg
8. Сборка клиентского приложения, развертывание на головном устройстве, ставим его в автозагрузку. На целевом устройстве должна быть установлена Windows 10 IoT, последняя версия Dashboard https://docs.microsoft.com/en-us/windows/iot-core/downloads.
9. Регистрация личного кабинета на серверной части (необходимо подтвердить регистрацию с админского акаунта, указав количество лицензируемых устройств). Должно прийти письмо на указанный пользователем адрес.
10. Регистрация устройства на сервере. Необходимо скачать из личного кабинета пользователя файл лицензии, сохранить его в корень USB носителя, вставить носитель и перезагрузить головной модуль.
11. Должно прийти письмо на емайл личного кабинета, в нем ссылка для подтверждения регистрации устройства. После прохода по ссылке устройство в течение 5 минут загрузит и сохранит настройки с сервера и перейдет в режим продаж.
12. Редактирование настроек устройства в личном кабинете. Адрес нужен для вычисления географических координат, по координатам вычисляется момент наступления темного времени суток для включения\выключения внешнего освещения автомата. Необходимо задать индивидуальные настройки устройства: адрес датчика температуры воды в баке; используется ли кассовый аппарат; при использовании кассового аппарата внутренний идентификатор используемой системы налогообложения (см документацию ККТ).
13. Проверка автомата, запуск в эксплуатацию.
