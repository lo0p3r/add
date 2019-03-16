﻿# language: ru

@IgnoreOnOFBuilds
@IgnoreOn82Builds
@IgnoreOnWeb

Функционал: Проверка работы структуры сценария
	Как Разработчик
	Я Хочу чтобы я мог использовать структуру сценария
	Чтобы я мог использовать такие сценарии


Контекст:
	Дано Я открываю VanessaBehavior в режиме TestClient

Сценарий: Передача параметра во вложенный сценарий первого и второго уровня - фича ДляПроверкиСтруктураСценарияТег_tree
	Когда В поле с именем "КаталогФичСлужебный" я указываю путь к служебной фиче "ДляПроверкиСтруктураСценарияТег_tree"
	И В открытой форме я перехожу к закладке с заголовком "Библиотеки"
	И В открытой форме я нажимаю на кнопку с именем "КаталогиБиблиотекДобавить"
	И я добавляю в библиотеки строку с стандартной библиотекой "libraries"

	И Я нажимаю на кнопку перезагрузить сценарии в Vanessa-ADD TestClient


	И Я нажимаю на кнопку выполнить сценарии в Vanessa-ADD TestClient

	И     таблица формы с именем "ДеревоТестов" стала равной:
		| 'Снипет'                                                | 'Наименование'                                                                  |
		| ''                                                      | 'ДляПроверкиСтруктураСценарияТег_tree.feature'                                  |
		| ''                                                      | 'ДляПроверкиСтруктураСценарияТег_tree'                                          |
		| ''                                                      | 'Перемещение по группам и фасовка1'                                              |
		| 'ВОткрытойФормеВПолеЯВвожуТекстТестовыйШаг(Парам01,ШК)' | 'Когда В открытой форме в поле   "InputFld" я ввожу текст    <ШК> тестовый шаг' |
		| ''                                                      | 'И шаг дерево'                                                                  |
		| 'ПерейтиКТаблице(ТабПарам)'                             | 'И перейти к таблице:'                                                          |
		| ''                                                      | *                                                                               |
		| ''                                                      | 'Перемещение по группам и фасовка2'                                              |
		| 'ПервыйШаг(ШК)'                                         | 'Когда первый шаг <ШК>'                                                         |
		| ''                                                      | 'Когда шаг дерево'                                                              |
		| 'ШагЛист(ШК)'                                           | 'И шаг лист <ШК>'                                                               |
		| 'ПерейтиКТаблице(ШК,ТабПарам)'                          | 'И перейти к <ШК> таблице:'                                                     |
		| ''                                                      | *                                                                               |
		| ''                                                      | 'И вызов экспортного сценария для структуры сценария "Парам2"'                  |
		| 'ПростойШаг(Парам01)'                                   | 'Когда Простой шаг  \'Парам2\' '                                                |
		| 'ФинальныйШаг(ШК)'                                      | 'И финальный шаг <ШК>'                                                          |
		| ''                                                      | 'Примеры'                                                                       |
		| ''                                                      | *                                                                               |
		| ''                                                      | *                                                                               |
		| 'ПервыйШаг(ШК)'                                         | 'Когда первый шаг "2200001008004"'                                              |
		| ''                                                      | 'Когда шаг дерево'                                                              |
		| 'ШагЛист(ШК)'                                           | 'И шаг лист "2200001008004"'                                                    |
		| 'ПерейтиКТаблице(ШК,ТабПарам)'                          | 'И перейти к "2200001008004" таблице:'                                          |
		| ''                                                      | *                                                                               |
		| ''                                                      | 'И вызов экспортного сценария для структуры сценария "Парам2"'                  |
		| 'ПростойШаг(Парам01)'                                   | 'Когда Простой шаг  \'Парам2\' '                                                |
		| 'ФинальныйШаг(ШК)'                                      | 'И финальный шаг "2200001008004"'                                               |
		| ''                                                      | *                                                                               |
		| 'ПервыйШаг(ШК)'                                         | 'Когда первый шаг 2200001015504'                                                |
		| ''                                                      | 'Когда шаг дерево'                                                              |
		| 'ШагЛист(ШК)'                                           | 'И шаг лист 2200001015504'                                                      |
		| 'ПерейтиКТаблице(ШК,ТабПарам)'                          | 'И перейти к 2200001015504 таблице:'                                            |
		| ''                                                      | *                                                                               |
		| ''                                                      | 'И вызов экспортного сценария для структуры сценария "Парам2"'                  |
		| 'ПростойШаг(Парам01)'                                   | 'Когда Простой шаг  \'Парам2\' '                                                |
		| 'ФинальныйШаг(ШК)'                                      | 'И финальный шаг 2200001015504'                                                 |
		| ''                                                      | 'Третий сценарий'                                                               |
		| 'ЯРазвернулВсеВеткиДереваVB()'                          | 'Когда  я развернул все ветки дерева VB'                                        |
		| 'ТестовыйШаг()'                                         | 'Когда тестовый шаг'                                                            |
		| ''                                                      | 'И второй шаг дерево'                                                           |
		| 'ЕщёЩаг()'                                              | 'И ещё щаг'                                                                     |
		| 'ПростоШаг()'                                           | 'И просто шаг'                                                                  |
		| ''                                                      | 'Перемещение по группам и фасовка 4'                                            |
		| 'ПервыйШаг(ШК)'                                         | 'Когда первый шаг <ШК>'                                                         |
		| ''                                                      | 'Когда шаг дерево'                                                              |
		| 'ШагЛист(ШК)'                                           | 'И шаг лист <ШК>'                                                               |
		| 'ПерейтиКТаблице(ШК,ТабПарам)'                          | 'И перейти к <ШК> таблице:'                                                     |
		| ''                                                      | '\| Кол1 \| Кол2 \|'                                                            |
		| ''                                                      | 'И вызов экспортного сценария для структуры сценария <ШК>'                      |
		| 'ПростойШаг(Парам01)'                                   | 'Когда Простой шаг  <ШК> '                                                     |
		| 'ФинальныйШаг(ШК)'                                      | 'И финальный шаг <ШК>'                                                          |
		| ''                                                      | 'Примеры'                                                                       |
		| ''                                                      | '\| ШК              \|'                                                         |
		| ''                                                      | '\| '2200001008004' \|'                                                         |
		| 'ПервыйШаг(ШК)'                                         | 'Когда первый шаг "2200001008004"'                                              |
		| ''                                                      | 'Когда шаг дерево'                                                              |
		| 'ШагЛист(ШК)'                                           | 'И шаг лист "2200001008004"'                                                    |
		| 'ПерейтиКТаблице(ШК,ТабПарам)'                          | 'И перейти к "2200001008004" таблице:'                                          |
		| ''                                                      | '\| Кол1 \| Кол2 \|'                                                            |
		| ''                                                      | 'И вызов экспортного сценария для структуры сценария "2200001008004"'           |
		| 'ПростойШаг(Парам01)'                                   | 'Когда Простой шаг  "2200001008004" '                                          |
		| 'ФинальныйШаг(ШК)'                                      | 'И финальный шаг "2200001008004"'                                                |
		| ''                                                      | '\| 2200001015504   \|'                                                         |
		| 'ПервыйШаг(ШК)'                                         | 'Когда первый шаг 2200001015504'                                                |
		| ''                                                      | 'Когда шаг дерево'                                                              |
		| 'ШагЛист(ШК)'                                           | 'И шаг лист 2200001015504'                                                      |
		| 'ПерейтиКТаблице(ШК,ТабПарам)'                          | 'И перейти к 2200001015504 таблице:'                                            |
		| ''                                                      | '\| Кол1 \| Кол2 \|'                                                            |
		| ''                                                      | 'И вызов экспортного сценария для структуры сценария 2200001015504'             |
		| 'ПростойШаг(Парам01)'                                   | 'Когда Простой шаг  2200001015504 '                                            |
		| 'ФинальныйШаг(ШК)'                                      | 'И финальный шаг 2200001015504'                                                  |
