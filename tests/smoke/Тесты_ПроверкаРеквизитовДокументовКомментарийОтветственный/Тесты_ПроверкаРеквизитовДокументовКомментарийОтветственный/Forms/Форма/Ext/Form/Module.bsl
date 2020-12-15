﻿#Область ОписаниеПеременных

&НаКлиенте
Перем КонтекстЯдра;
&НаКлиенте
Перем Утверждения;
&НаКлиенте
Перем СтроковыеУтилиты;
&НаКлиенте
Перем ОтборПоПрефиксу;
&НаКлиенте
Перем ПрефиксОбъектов;
&НаКлиенте
Перем ИсключенияИзПроверок;
&НаКлиенте
Перем ВыводитьИсключения;
&НаКлиенте
Перем ИмяТипаКомментарий;
&НаКлиенте
Перем ИмяТипаОтветственный;
&НаКлиенте
Перем ПропускатьОбъектыСПрефиксомУдалить;

#КонецОбласти

#Область ИнтерфейсТестирования

&НаКлиенте
Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
	
	КонтекстЯдра = КонтекстЯдраПараметр;
	Утверждения = КонтекстЯдра.Плагин("БазовыеУтверждения");
	СтроковыеУтилиты = КонтекстЯдра.Плагин("СтроковыеУтилиты");
	
	Настройки(КонтекстЯдра, ИмяТеста());
		
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьНаборТестов(НаборТестов, КонтекстЯдраПараметр) Экспорт
	
	Инициализация(КонтекстЯдраПараметр);
	
	Если Не ВыполнятьТест(КонтекстЯдра) Тогда
		Возврат;
	КонецЕсли;
		
	НаборТестов.НачатьГруппу("Документы", Ложь);
	мДокументы = Документы(ПрефиксОбъектов, ОтборПоПрефиксу);
	Если Не ВыводитьИсключения Тогда
		МассивТестов = УбратьИсключения(мДокументы);
	Иначе
		МассивТестов = мДокументы;
	КонецЕсли;
	Для Каждого Тест Из МассивТестов Цикл
		ИмяПроцедуры = "ТестДолжен_ПроверитьРеквизитыДокументовКомментарийОтветственный";
		ИмяТеста = КонтекстЯдра.СтрШаблон_(
						"%1 [%2]", 
						Тест.ПолноеИмя, 
						НСтр("ru = 'Проверка реквизитов документа: комментарий, ответственный'"));
		НаборТестов.Добавить(ИмяПроцедуры, НаборТестов.ПараметрыТеста(Тест.Имя, Тест.ПолноеИмя), ИмяТеста);	
	КонецЦикла;
			
КонецПроцедуры

#КонецОбласти

#Область РаботаСНастройками

&НаКлиенте
Процедура Настройки(КонтекстЯдра, Знач ПутьНастройки)

	Если ЗначениеЗаполнено(Объект.Настройки) Тогда
		Возврат;
	КонецЕсли;
	
	ОтборПоПрефиксу = Ложь;
	ВыводитьИсключения = Ложь;
	ПрефиксОбъектов = "";
	ИмяТипаКомментарий = "";
	ИмяТипаОтветственный = "";
	ПропускатьОбъектыСПрефиксомУдалить = Ложь;
	ИсключенияИзПроверок = Новый Соответствие;
	ПлагинНастроек = КонтекстЯдра.Плагин("Настройки");
	Объект.Настройки = ПлагинНастроек.ПолучитьНастройку(ПутьНастройки);
	Настройки = Объект.Настройки;
	
	Если Не ЗначениеЗаполнено(Объект.Настройки) Тогда
		Объект.Настройки = Новый Структура(ПутьНастройки, Неопределено);
		Возврат;
	КонецЕсли;
		
	Если Настройки.Свойство("Префикс") Тогда
		ПрефиксОбъектов = ВРег(Настройки.Префикс);		
	КонецЕсли;
	
	Если Настройки.Свойство("ОтборПоПрефиксу") Тогда
		ОтборПоПрефиксу = Настройки.ОтборПоПрефиксу;		
	КонецЕсли;
	
	Если Настройки.Свойство("ОпределяемыйТипКомментарий") Тогда
		ИмяТипаКомментарий = Настройки.ОпределяемыйТипКомментарий;		
	КонецЕсли;
	
	Если Настройки.Свойство("ОпределяемыйТипОтветственный") Тогда
		ИмяТипаОтветственный = Настройки.ОпределяемыйТипОтветственный;		
	КонецЕсли;
	
	Если Настройки.Свойство("ВыводитьИсключения") Тогда
		ВыводитьИсключения = Настройки.ВыводитьИсключения;
	КонецЕсли;
	
	Если Настройки.Свойство("ПропускатьОбъектыСПрефиксомУдалить") Тогда
		ПропускатьОбъектыСПрефиксомУдалить = Настройки.ПропускатьОбъектыСПрефиксомУдалить;
	КонецЕсли;
	
	Если Настройки.Свойство("ИсключенияИзПроверок") Тогда
		ИсключенияИзПроверок(Настройки);
	КонецЕсли;
			
КонецПроцедуры

&НаКлиенте
Процедура ИсключенияИзПроверок(Настройки)

	Для Каждого ИсключенияИзПроверокПоОбъектам Из Настройки.ИсключенияИзпроверок Цикл
		Для Каждого ИсключениеИзПроверок Из ИсключенияИзПроверокПоОбъектам.Значение Цикл
			ИсключенияИзПроверок.Вставить(ВРег(ИсключенияИзПроверокПоОбъектам.Ключ + "." + ИсключениеИзПроверок), Истина); 	
		КонецЦикла;
	КонецЦикла;	

КонецПроцедуры

#КонецОбласти

#Область Тесты

&НаКлиенте
Процедура ТестДолжен_ПроверитьРеквизитыДокументовКомментарийОтветственный(ИмяДокумента, ПолноеИмяДокумента) Экспорт
	
	ПропускатьТест = ПропускатьТест(ПолноеИмяДокумента);
	
	Результат = ПроверитьРеквизитыДокументовКомментарийОтветственный(
					ИмяДокумента, ИмяТипаКомментарий, ИмяТипаОтветственный);
	
	Если Результат <> "" И ПропускатьТест.Пропустить Тогда
		Утверждения.ПропуститьТест(ПропускатьТест.ТекстСообщения);
	Иначе
		Утверждения.Проверить(Результат = "", ТекстСообщения(ИмяДокумента, Результат));
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПроверитьРеквизитыДокументовКомментарийОтветственный(ИмяДокумента, ИмяТипаКомментарий, ИмяТипаОтветственный)
	
	Документ = Метаданные.Документы.Найти(ИмяДокумента);	
	Результат = "";
	СтроковыеУтилиты = СтроковыеУтилиты();
	
	РеквизитКомментарий = Документ.Реквизиты.Найти("Комментарий");
	Если РеквизитКомментарий = Неопределено Тогда
		ШаблонСообщения = НСтр("ru = '%1%2 не указан реквизит ""Комментарий""'");
		ДобавитьСообщениеВРезультат(СтроковыеУтилиты, Результат, ШаблонСообщения)
	Иначе
		Если РеквизитКомментарий <> Неопределено И ЗначениеЗаполнено(ИмяТипаКомментарий) Тогда
			ОпределяемыйТипКомментарий = Метаданные.ОпределяемыеТипы.Найти(ИмяТипаКомментарий);
			Если РеквизитКомментарий.Тип <> ОпределяемыйТипКомментарий.Тип Тогда
				ШаблонСообщения = НСтр("ru = '%1 тип реквизита ""Комментарий"" не соответствует определяемому типу %2'");
				ШаблонСообщения = СтроковыеУтилиты.ПодставитьПараметрыВСтроку(ШаблонСообщения, "%1%2", ИмяТипаКомментарий);
				ДобавитьСообщениеВРезультат(СтроковыеУтилиты, Результат, ШаблонСообщения)	
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	РеквизитОтветственный = Документ.Реквизиты.Найти("Ответственный");
	Если РеквизитОтветственный = Неопределено Тогда
		ШаблонСообщения = НСтр("ru = '%1%2 не указан реквизит ""Ответственный""'");
		ДобавитьСообщениеВРезультат(СтроковыеУтилиты, Результат, ШаблонСообщения)
	Иначе
		Если РеквизитОтветственный <> Неопределено И ЗначениеЗаполнено(ИмяТипаОтветственный) Тогда
			ОпределяемыйТипОтветственный = Метаданные.ОпределяемыеТипы.Найти(ИмяТипаОтветственный);
			Если РеквизитОтветственный.Тип <> ОпределяемыйТипОтветственный.Тип Тогда
				ШаблонСообщения = НСтр("ru = '%1 тип реквизита ""Ответственный"" не соответствует определяемому типу %2'");
				ШаблонСообщения = СтроковыеУтилиты.ПодставитьПараметрыВСтроку(ШаблонСообщения, "%1%2", ИмяТипаОтветственный);
				ДобавитьСообщениеВРезультат(СтроковыеУтилиты, Результат, ШаблонСообщения)	
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
		
	Возврат Результат;

КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервереБезКонтекста
Процедура ДобавитьСообщениеВРезультат(СтроковыеУтилиты, Результат, ШаблонСообщения)
	Разделитель = ?(ЗначениеЗаполнено(Результат), ";", "");
	Результат = СтроковыеУтилиты.ПодставитьПараметрыВСтроку(ШаблонСообщения, Результат, Разделитель);	
КонецПроцедуры

&НаКлиенте
Функция ПропускатьТест(ИмяДокумента)

	Результат = Новый Структура;
	Результат.Вставить("ТекстСообщения", "");
	Результат.Вставить("Пропустить", Ложь);
	
	Если ИсключенияИзПроверок.Получить(ВРег(ИмяДокумента)) <> Неопределено Тогда
		ШаблонСообщения = НСтр("ru = 'Объект ""%1"" исключен из проверки.'");
		Результат.ТекстСообщения = СтроковыеУтилиты.ПодставитьПараметрыВСтроку(ШаблонСообщения, ИмяДокумента);
		Результат.Пропустить = Истина;
		Возврат Результат;
	КонецЕсли;
	
	Если ПропускатьОбъектыСПрефиксомУдалить = Истина И СтрНайти(ВРег(ИмяДокумента), ".УДАЛИТЬ") > 0 Тогда
		ШаблонСообшения = НСтр("ru = 'Объект ""%1"" исключен из проверки, префикс ""Удалить""'");
		Результат.ТекстСообщения = СтроковыеУтилиты.ПодставитьПараметрыВСтроку(ШаблонСообшения, ИмяДокумента);
		Результат.Пропустить = Истина;
		Возврат Результат;
	КонецЕсли;
		
	Возврат Результат;

КонецФункции 

&НаКлиенте
Функция ТекстСообщения(ИмяДокумента, Результат)

	ШаблонСообщения = НСтр("ru = 'Для документа ""%1"":%2.'");
	ТекстСообщения = СтроковыеУтилиты.ПодставитьПараметрыВСтроку(ШаблонСообщения, ИмяДокумента, Результат);
	
	Возврат ТекстСообщения;

КонецФункции

&НаКлиенте
Функция УбратьИсключения(МассивТестов)

	Исключения = Новый Соответствие;
	Результат = Новый Массив;
	
	Для Каждого Тест Из МассивТестов Цикл
		Если ИсключенИзПроверок(Тест.ПолноеИмя) Тогда
			Исключения.Вставить(Тест, Истина);
		КонецЕсли;	
	КонецЦикла;
	
	Для Каждого Тест Из МассивТестов Цикл
 		Если Исключения.Получить(Тест) = Истина Тогда
			Продолжить;
		КонецЕсли;
		Результат.Добавить(Тест);
	КонецЦикла;
	
	Возврат Результат;

КонецФункции

&НаКлиенте
Функция ИсключенИзПроверок(ПолноеИмяМетаданных)
	
	Результат = Ложь;
	ИмяТеста = ПолноеИмяМетаданных;
	ИслючениеВсехОбъектов = "Документ.*";
	
	Если ИсключенияИзПроверок.Получить(ВРег(ИмяТеста)) <> Неопределено
	 Или ИсключенияИзПроверок.Получить(ВРег(ИслючениеВсехОбъектов)) <> Неопределено Тогда
		Результат = Истина;	
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаСервереБезКонтекста
Функция СтроковыеУтилиты()
	Возврат ВнешниеОбработки.Создать("СтроковыеУтилиты");	
КонецФункции 

&НаКлиенте
Функция ИмяТеста()
	
	Если Не ЗначениеЗаполнено(Объект.ИмяТеста) Тогда
		Объект.ИмяТеста = ИмяТестаНаСервере();
	КонецЕсли;
	
	Возврат Объект.ИмяТеста;
	
КонецФункции

&НаСервере
Функция ИмяТестаНаСервере()
	Возврат РеквизитФормыВЗначение("Объект").Метаданные().Имя;
КонецФункции

&НаКлиенте
Функция ВыполнятьТест(КонтекстЯдра)
	
	ВыполнятьТест = Ложь;
	Настройки(КонтекстЯдра, ИмяТеста());
	Настройки = Объект.Настройки;
	
	Если Не ЗначениеЗаполнено(Настройки) Тогда
		Возврат ВыполнятьТест;
	КонецЕсли;
		
	Если ТипЗнч(Настройки) = Тип("Структура") И Настройки.Свойство("Используется") Тогда
		ВыполнятьТест = Настройки.Используется;	
	КонецЕсли;
	
	Возврат ВыполнятьТест;

КонецФункции

&НаСервереБезКонтекста
Функция Документы(ПрефиксОбъектов, ОтборПоПрефиксу)

	Результат = Новый Массив;
	
	Для Каждого Документ Из Метаданные.Документы Цикл
		Если ОтборПоПрефиксу И Не ИмяСодержитПрефикс(Документ.Имя, ПрефиксОбъектов) Тогда
			Продолжить;
		КонецЕсли;
		СтруктураДокумента = Новый Структура;
		СтруктураДокумента.Вставить("Имя", Документ.Имя);
		СтруктураДокумента.Вставить("Синоним", Документ.Синоним);
		СтруктураДокумента.Вставить("ПолноеИмя", Документ.ПолноеИмя());
		Результат.Добавить(СтруктураДокумента);
	КонецЦикла;	
	
	Возврат Результат;

КонецФункции 

&НаКлиентеНаСервереБезКонтекста
Функция ИмяСодержитПрефикс(Имя, Префикс)
	
	Если Не ЗначениеЗаполнено(Префикс) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	ДлинаПрефикса = СтрДлина(Префикс);
	Возврат СтрНайти(ВРег(Лев(Имя, ДлинаПрефикса)), Префикс) > 0;
	
КонецФункции

#КонецОбласти