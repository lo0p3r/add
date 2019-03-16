﻿# language: ru

#https://github.com/silverbulleters/vanessa-behavior/issues/252

@IgnoreOn82Builds
@IgnoreOnOFBuilds
@IgnoreOnWeb

@tree

Функционал: Проверка работы остановки выполения шагов и оповещения обработки содержащий step_definitions
	Как Разработчик
	Я Хочу чтобы чтобы у меня была возможность остановить выполнение шагов и сделать оповещение из другой формы
	Чтобы я мог использовать оповещения без ошибок




	Сценарий: Проверка работы оповещений
		Когда Я открываю VanessaBehavior в режиме TestClient

		И В поле с именем "КаталогФичСлужебный" я указываю путь к служебной фиче "ПроверкаРаботыОповещений"

		И в VanessaBehavoir в TestClient я загружаю и выполняю сценарии
				И В открытой форме я перехожу к закладке с заголовком "Библиотеки"
				И В открытой форме я нажимаю на кнопку с именем "КаталогиБиблиотекДобавить"
				И я добавляю в библиотеки строку с стандартной библиотекой "Пауза"
				И В форме "* Vanessa behavior" в ТЧ "КаталогиБиблиотек" я завершаю редактирование строки
				И Я нажимаю на кнопку перезагрузить сценарии в Vanessa-ADD TestClient
				И Я нажимаю на кнопку перезагрузить сценарии в Vanessa-ADD TestClient
				# специально два раза

				И Я нажимаю на кнопку выполнить сценарии в Vanessa-ADD TestClient


		Тогда в VanessaBehavoir в TestClient снипет заполнился верно
			И     таблица формы с именем "ДеревоТестов" стала равной:
				| 'Статус'  |
				| ''        |
				| ''        |
				| 'Success' |
				| 'Success' |
				| 'Success' |
		И Я закрыл все окна клиентского приложения
		И я закрываю сеанс TESTCLIENT
