# language: ru

@IgnoreOn82Builds
@IgnoreOnOFBuilds
@IgnoreOn836
@IgnoreOn837
@IgnoreOn838
@IgnoreOnWeb
@Video
@IgnoreOnLinux


Функционал: Проверка формирования файла видео

Как разработчик
Я хочу чтобы корректно формировался файл видео под фиче
Чтобы я мог видеть результат работы сценариев в формате видео

	#[autodoc.groupsteps] В интерфейсе я выбираю Справочник1 и Справочник2 ["" + 11]
	#[autodoc.donotscale]
	#[autodoc.ignorestep]
	#[autodoc.text] В интерфейсе \[я\] выбираю %2 и %1 ["" + ТекущаяДата()]


Контекст:
	Дано Я убедился что работает звуковой движок по созданию TTS
	Дано Я открываю VanessaBehavior в режиме TestClient
	И я убедился что каталог указанный в реквизите "ЗаписьВидеоКаталогДляВременныхФайлов" существует или создал его
	И В поле с именем "КаталогФичСлужебный" я указываю путь к служебной фиче "ФичаДляПроверкиФормированияВидео"

Сценарий: Проверка формирования видео

	И     В открытой форме я перехожу к закладке с заголовком "Сервис"
	И     В открытой форме я изменяю флаг "Создавать видеоинструкцию"
	И     в поле "Каталог для формирования инструкций Видео" я указываю путь к относительному каталогу "tools\Video" и очищаю каталог

	И В открытой форме я перехожу к закладке с заголовком "Библиотеки"
	И В открытой форме я нажимаю на кнопку с именем "КаталогиБиблиотекДобавить"
	И я добавляю в библиотеки строку с стандартной библиотекой "libraries"

	И Я заполняю настройки записи видео в TestClient

	И Я нажимаю на кнопку перезагрузить сценарии в Vanessa-ADD TestClient
	И Я нажимаю на кнопку выполнить сценарии в Vanessa-ADD TestClient
	И в течение 800 секунд в каталоге заданном в переменной контекста "ПараметрКаталог" появился файл "result.mp4"
	И в логе сообщений TestClient нет слова "ошибка"