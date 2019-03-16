# language: ru

@IgnoreOn82Builds
@IgnoreOnOFBuilds
@IgnoreOnWeb
@IgnoreOn836
@IgnoreOn837
@IgnoreOn838



Функционал: Проверка выполнения с шага внутри цикла


Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий с закрытием всех окон кроме "* Vanessa behavior"


Сценарий: Проверка работы цикла и вложенного сценария
	Когда Я открываю VanessaBehavior в режиме TestClient со стандартной библиотекой
	И В поле с именем "КаталогФичСлужебный" я указываю путь к служебной фиче "ДляПроверкиВыполненияСценарияСШагаВнутриЦикла"
	И Я нажимаю на кнопку перезагрузить сценарии в Vanessa-ADD TestClient

	#Сделаем переход ко второй строке
	И     в таблице "ДеревоТестов" я разворачиваю строку:
		| 'Наименование'   |
		| '*Вторая группа' |

	И     в таблице "ДеревоТестов" я перехожу к строке:
		| 'Наименование'                         |
		| 'Дано Я задаю таблицу строк "Таблица"' |

	И  я снимаю флаг "Сценарии выполнены"
	И я выбираю пункт контекстного меню "Выполнить шаг" на элементе формы с именем "ДеревоТестов"
	И     у элемента "Сценарии выполнены" я жду значения "Да" в течение 50 секунд

	И     в таблице "ДеревоТестов" я разворачиваю строку:
		| 'Наименование'                                                             |
		| 'И для каждого значения "ЗначениеИзМассива" из таблицы в памяти "Таблица"' |

	И     в таблице "ДеревоТестов" я перехожу к строке:
		| 'Наименование'                                                           |
		| 'И Я запоминаю значение выражения "3" в переменную "ТестоваяПеременная"' |


	И я выбираю пункт контекстного меню "Выполнить с текущего шага" на элементе формы с именем "ДеревоТестов"

	И     у элемента "Сценарии выполнены" я жду значения "Да" в течение 50 секунд
	И     элемент формы с именем "Статистика" стал равен "1/1/11, 5/0/0"
