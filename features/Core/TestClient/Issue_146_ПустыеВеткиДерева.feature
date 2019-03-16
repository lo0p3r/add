# language: ru

@IgnoreOn82Builds
@IgnoreOnOFBuilds
@IgnoreOnWeb



Функционал: Проверка что в дере фич нет веток в которых нет фич

Как разработчик
Я хочу чтобы корректно происходила загрузка фич из каталога
Чтобы в дереве не было пустых веток


Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий с закрытием всех окон кроме "* Vanessa behavior"

Сценарий: Загруза фич без пустых веток
	Когда Я открываю VanessaBehavior в режиме TestClient
	И создал каталог "Temp1\Temp2" если его нет в каталоге "features\Core\OpenForm"
	И в каталоге "features\Core\OpenForm\Temp1\Temp2" я записываю фичу с тегом "IgnoreFeature"
	И В поле с именем "КаталогФичСлужебный" я указываю полный путь к относитльному каталогу "features\Core\OpenForm"

	И     В открытой форме я перехожу к закладке с заголовком "Сервис"

	#заполним тег
	И я нажимаю кнопку очистить у поля "Список исключаемых тэгов"
	И     В открытой форме я нажимаю кнопку выбора у поля "Список исключаемых тэгов"
	Тогда открылось окно "Список значений"
	И     В открытой форме я нажимаю на кнопку с заголовком "Добавить"
	И     В открытой форме в ТЧ "ValueList" в поле с заголовком "Значение" я ввожу текст "IgnoreFeature"
	И     В форме "Список значений" в ТЧ "ValueList" я завершаю редактирование строки
	И     В открытой форме я нажимаю на кнопку с заголовком "ОК"

	И Я нажимаю на кнопку перезагрузить сценарии в Vanessa-ADD TestClient
	И В открытой форме в таблице с именем "ДеревоТестов" в колонке "Наименование" есть значение "ОткрытиеФормы"
	И В открытой форме в таблице с именем "ДеревоТестов" в колонке "Наименование" нет значения "Temp1"
	И В открытой форме в таблице с именем "ДеревоТестов" в колонке "Наименование" нет значения "Temp2"
