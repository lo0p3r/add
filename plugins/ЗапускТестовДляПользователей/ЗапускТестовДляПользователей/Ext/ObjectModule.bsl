﻿Перем ПутьКФайлуПолный Экспорт;// в эту переменную будет установлен правильный клиентский путь к текущему файлу

Перем КонтекстЯдра;
Перем Файлы;

// { Plugin interface
Функция ОписаниеПлагина(ВозможныеТипыПлагинов) Экспорт
	Результат = Новый Структура;
	Результат.Вставить("Тип", ВозможныеТипыПлагинов.Утилита);
	Результат.Вставить("Идентификатор", Метаданные().Имя);
	Результат.Вставить("Представление", "Запуск тестов для пользователей");
	
	Возврат Новый ФиксированнаяСтруктура(Результат);
КонецФункции

Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
	КонтекстЯдра = КонтекстЯдраПараметр;
КонецПроцедуры
// } Plugin interface

// { API interface

#Если ТолстыйКлиентОбычноеПриложение Тогда

// Процедура - Запустить тест для пользователя
//
// Параметры:
//  ОписаниеПользователя		 - Структура - ключи Логин, Пароль
//  ПутьТестов					 - Строка	 - Путь каталога с тестами или файла обработки-теста
//  	или подсистемы с тестами или встроенной обработки-теста
//  ТипКлиента					 - Строка	 - Ключ из структуры, возвращаемой ВозможныеТипыКлиентов()
//  РабочийКаталогПроекта		 - Строка	 - Необязательно. Если не задано, подставляется КаталогВременныхФайлов/ИмяПользователя_ГУИД
//  ПутьККонфигурационномуФайлу	 - Строка	 - Необязательно. Путь к файлу xUnitParams.json
//  ПутьОтчетаJUnit				 - Строка	 - 
// 
// Возвращаемое значение:
//  Структура - ключи: КодВозврата, ПутьОтчетаJUnit, ПутьЛогФайла
//
Функция ЗапуститьТестДляПользователя(Знач ОписаниеПользователя, Знач ПутьТестов, 
		Знач ТипКлиента, Знач РабочийКаталогПроекта = "", Знач ПутьККонфигурационномуФайлу = "",
		Знач ПутьОтчетаJUnit = "") Экспорт

	СоздатьПлагины();
	
	ПутьКонтекстаЯдра = КонтекстЯдра.ИспользуемоеИмяФайла;
	
	Если Не ЗначениеЗаполнено(РабочийКаталогПроекта) Тогда
		РабочийКаталогПроекта = Файлы.ОбъединитьПути(КаталогВременныхФайлов(), 
			СтрШаблон("%1_%2", ОписаниеПользователя.Логин, Новый УникальныйИдентификатор));
	КонецЕсли;
	
	Файлы.ОбеспечитьКаталог(РабочийКаталогПроекта);
	РабочийКаталогПроекта = Файлы.ОбъединитьПути(РабочийКаталогПроекта, "");
	
	ПутьЛогФайла = Файлы.ОбъединитьПути(РабочийКаталогПроекта, "online.log");
	Если Не ЗначениеЗаполнено(ПутьОтчетаJUnit) Тогда
		ПутьОтчетаJUnit = Файлы.ОбъединитьПути(РабочийКаталогПроекта, "junit.xml");
	КонецЕсли;
	
	ПутьККонфигурационномуФайлу = СоздатьКонфигурационныйФайл(РабочийКаталогПроекта, ПутьККонфигурационномуФайлу, 
			"xUnitParams.json", ПутьЛогФайла);
	
	СтрокаЗапускаТестирования = СформироватьСтрокуЗапускаТестирования(ОписаниеПользователя, ПутьТестов, 
		ТипКлиента, РабочийКаталогПроекта, ПутьККонфигурационномуФайлу, ПутьОтчетаJUnit);
		
	СтрокаЗапуска = СтрШаблон("/N %1 /C %2 /Execute %3", ОписаниеПользователя.Логин, СтрокаЗапускаТестирования,
		ПутьКонтекстаЯдра);

	Если ОписаниеПользователя.Свойство("Пароль") И ЗначениеЗаполнено(ОписаниеПользователя.Пароль) Тогда
		СтрокаЗапуска = СтрШаблон("%1 /P %2", СтрокаЗапуска, ОписаниеПользователя.Пароль);
	КонецЕсли;
	КонтекстЯдра.ВывестиСообщение("СтрокаЗапуска " + СтрокаЗапуска);
	
	КодВозврата = 0;
	ЗапуститьСистему(СтрокаЗапуска, Истина, КодВозврата);
	
	Рез = Новый Структура();
	Рез.Вставить("КодВозврата", КодВозврата);
	Рез.Вставить("ПутьОтчетаJUnit", ПутьОтчетаJUnit);
	Рез.Вставить("ПутьЛогФайла", ПутьЛогФайла);
	Возврат Новый ФиксированнаяСтруктура(Рез);
КонецФункции
#КонецЕсли

// Функция - Возможные типы клиентов. Варианты: Тонкий, ТолстыйУФ и ТолстыйОФ
// 
// Возвращаемое значение:
//   ФиксированнаяСтруктура - с ключами выше
//
Функция ВозможныеТипыКлиентов() Экспорт

	Рез = Новый Структура;
	Рез.Вставить("Тонкий", "Тонкий");
	Рез.Вставить("ТолстыйУФ", "Толстый управляемое приложение");
	Рез.Вставить("ТолстыйОФ", "Толстый обычное приложение");

	Возврат Новый ФиксированнаяСтруктура(Рез);
КонецФункции // ВозможныеТипыКлиентов()

// } API interface

//{ Приватные методы

Функция СоздатьКонфигурационныйФайл(Знач РабочийКаталогПроекта, Знач ПутьККонфигурационномуФайлу, 
									Знач ПутьФайла, Знач ПутьЛогФайла)
									
	КЛЮЧ_ИмяФайлаЛогВыполненияСценариев = "ИмяФайлаЛогВыполненияСценариев";
	КЛЮЧ_ДелатьЛогВыполненияСценариевВТекстовыйФайл = "ДелатьЛогВыполненияСценариевВТекстовыйФайл";
	
	Если Не ЗначениеЗаполнено(ПутьККонфигурационномуФайлу) Тогда

		Текст = ПолучитьМакет("xUnitParams_json").ПолучитьТекст();
		//Текст = СтрЗаменить(Текст, СтрШаблон("%%1%", КЛЮЧ_ИмяФайлаЛогВыполненияСценариев), 
		//	ПутьЛогФайла);
		//Текст = СтрЗаменить(Текст, "\", "\\");
		
	Иначе
		Текст = Файлы.ПрочитатьФайл(ПутьККонфигурационномуФайлу);
	КонецЕсли; 
	
	//ПутьЛогФайла = СтрЗаменить(ПутьЛогФайла, "\", "\\");
	
	ЧтениеJson = Новый ЧтениеJSON;
	ЧтениеJson.УстановитьСтроку(Текст);
	Соответствие = ПрочитатьJSON(ЧтениеJson, Ложь);
	Соответствие.Вставить(КЛЮЧ_ИмяФайлаЛогВыполненияСценариев, ПутьЛогФайла);
	Соответствие.Вставить(КЛЮЧ_ДелатьЛогВыполненияСценариевВТекстовыйФайл, Истина);
	
	РезПутьФайла = Файлы.ОбъединитьПути(РабочийКаталогПроекта, ПутьФайла);
	
	ЗаписьJSON = Новый ЗаписьJSON;
	ЗаписьJSON.ОткрытьФайл(РезПутьФайла, КодировкаТекста.UTF8, Ложь);
	ЗаписатьJSON(ЗаписьJSON, Соответствие);
	
	Возврат РезПутьФайла;
КонецФункции // СоздатьКонфигурационныйФайл()

Функция СформироватьСтрокуЗапускаТестирования(Знач ОписаниеПользователя, Знач ПутьТестов, 
		Знач ТипКлиента, Знач РабочийКаталогПроекта, Знач ПутьККонфигурационномуФайлу, Знач ПутьОтчетаJUnit)

	СтрокаЗапускаТестов = "";
	
	ВключенаОтладкаТестирования = Истина;
	Завершать1СПослеТестирования = ЛОжь;
	ЗагружатьВстроенныеТесты = Ложь; // TODO доработать на использование встроенных тестов
	ТестКлиент = "";//TODO добавить запуск тест-клиента
	
	ФормируемыеОтчеты = Новый Структура;
	ФормируемыеОтчеты.Вставить("ГенераторОтчетаJUnitXML", ПутьОтчетаJUnit);
	
	ПутьФайлаСтатусаТестирования = СтрШаблон("%1%2%3.log", КаталогВременныхФайлов(), "СтатусТестов_", 
		ОписаниеПользователя.Логин);
	
	ФайлТестов = Новый Файл(ПутьТестов);
	
	Если Не ЗагружатьВстроенныеТесты Тогда
		Если ФайлТестов.ЭтоКаталог() Тогда
			СтрокаЗапускаТестов = """xddRun ЗагрузчикКаталога """""+ПутьТестов+""""";";
		Иначе
			СтрокаЗапускаТестов = """xddRun ЗагрузчикФайла """""+ПутьТестов+""""";";
		КонецЕсли;
	Иначе		
		СтрокаЗапускаТестов = """xddRun ЗагрузчикИзПодсистемКонфигурации """""+ПутьТестов+""""";";
	КонецЕсли;

	Если Не ПустаяСтрока(ТестКлиент) Тогда
		СтрокаЗапускаТестов = СтрокаЗапускаТестов +
				СтрШаблон(" xddTestClient """"%1"""" ; ", ТестКлиент);
	КонецЕсли;
	
	Для каждого ПараметрыОтчета Из ФормируемыеОтчеты Цикл
		Генератор = СтрЗаменить(ПараметрыОтчета.Ключ, "GenerateReport", "ГенераторОтчета");
		СтрокаЗапускаТестов = СтрокаЗапускаТестов + "xddReport " + Генератор + " """"" + ПараметрыОтчета.Значение + """"";";
	КонецЦикла;

	Если Не ПустаяСтрока(ПутьККонфигурационномуФайлу) Тогда
		СтрокаЗапускаТестов = СтрокаЗапускаТестов + 
				СтрШаблон(" xddConfig """"%1"""" ; ", ПутьККонфигурационномуФайлу);
	КонецЕсли;

	Если Не ПустаяСтрока(ПутьФайлаСтатусаТестирования) Тогда
		СтрокаЗапускаТестов = СтрокаЗапускаТестов + 
				СтрШаблон(" xddExitCodePath ГенерацияКодаВозврата """"%1"""" ; ", ПутьФайлаСтатусаТестирования);
	КонецЕсли;

	//НастройкиДля1С.ДобавитьШаблоннуюПеременную("workspaceRoot", РабочийКаталогПроекта);

	//Настройки = НастройкиДля1С.ПрочитатьНастройки(ПутьККонфигурационномуФайлу);

	//ПутьЛогаВыполненияСценариев = НастройкиДля1С.ПолучитьНастройку(Настройки, "ИмяФайлаЛогВыполненияСценариев", 
	//							"./build/xddonline.txt", РабочийКаталогПроекта, "путь к лог-файлу выполнения");

	Если ВключенаОтладкаТестирования Тогда
		СтрокаЗапускаТестов = СтрокаЗапускаТестов + " debug ; ";
	КонецЕсли;

	СтрокаЗапускаТестов = СтрокаЗапускаТестов + " workspaceRoot " + РабочийКаталогПроекта + " ; ";

	Если Завершать1СПослеТестирования Тогда
		СтрокаЗапускаТестов = СтрокаЗапускаТестов + " xddShutdown ";
	КонецЕсли;
	
	СтрокаЗапускаТестов = СтрокаЗапускаТестов + " """;

	КонтекстЯдра.ВывестиСообщение(СтрокаЗапускаТестов);
	
	Возврат СтрокаЗапускаТестов;

КонецФункции // СформироватьСтрокуЗапускаТестирования()

Процедура СоздатьПлагины()
	Если Файлы = Неопределено Тогда
		Файлы = КонтекстЯдра.Плагин("Файлы");
	КонецЕсли; 
КонецПроцедуры

//}