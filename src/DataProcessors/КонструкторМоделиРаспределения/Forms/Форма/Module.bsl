//@skip-check module-unused-method
//@skip-check module-structure-top-region

#Область ОписаниеПеременных
&НаКлиенте
Перем
	ОтложенныеПараметры Экспорт
	, СостояниеТаблицыФормы Экспорт
;
#КонецОбласти

#Область ОбработчикиСобытийФормыВМоделиСостояния

&НаКлиенте
Процедура РассчитатьОтложенныеПараметры() Экспорт
	ИзмененныеПараметры = РаботаСМассивом.СкопироватьМассив(ОтложенныеПараметры);
	ОтложенныеПараметры = Новый Массив;
	ПриИзмененииНаКлиенте(ИзмененныеПараметры);
КонецПроцедуры

&НаСервере
Процедура ОбновитьФормуНаСервере(ИзмененныеПараметры = Неопределено)
	РаботаСМодельюФормыКлиентСервер.ОбновитьФорму(ЭтотОбъект, ИзмененныеПараметры);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьФормуНаКлиенте(ИзмененныеПараметры = Неопределено)
	СостояниеРасчета = РаботаСМодельюФормыКлиентСервер.ОбновитьФорму(ЭтотОбъект, ИзмененныеПараметры);
	Если НЕ СостояниеРасчета.Статус Тогда
		ОбновитьФормуНаСервере(СостояниеРасчета);
		Возврат; 
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПриИзмененииНаСервере(ИзмененныеПараметры = Неопределено, СостояниеРасчета = Неопределено)
	СостояниеРасчета = РаботаСМодельюОбъектаКлиентСервер.Рассчитать(ЭтотОбъект, ИзмененныеПараметры, СостояниеРасчета);
	ОбновитьФормуНаСервере(СостояниеРасчета.РассчитанныеПараметры);
КонецПроцедуры

&НаКлиенте
Процедура ПриИзмененииНаКлиенте(ИзмененныеПараметры)
	СостояниеРасчета = РаботаСМодельюОбъектаКлиентСервер.Рассчитать(ЭтотОбъект, ИзмененныеПараметры);
	Если НЕ СостояниеРасчета.Статус Тогда
		ПриИзмененииНаСервере( , СостояниеРасчета);
		Возврат; 
	КонецЕсли;
	ОбновитьФормуНаКлиенте(СостояниеРасчета.РассчитанныеПараметры);
КонецПроцедуры

&НаКлиенте
Процедура ПриИзменении(Элемент)
	//  МодельСостояния
	МодельОбъекта = РаботаСМодельюОбъектаКлиентСервер.ПолучитьМодель(ЭтотОбъект);
	РасчетныйПараметр = РаботаСМодельюФормыКлиентСервер.ПолучитьРасчетныйПараметрЭлементаФормы(ЭтотОбъект, Элемент.Имя);
	Если РасчетныйПараметр = Неопределено Тогда
		Возврат;
	КонецЕсли;
	РаботаСМодельюОбъектаКлиентСервер.ПриИзмененииПараметра(МодельОбъекта, РасчетныйПараметр);
	ПриИзмененииНаКлиенте(МодельОбъекта.ИзмененныеПараметры);
	//  Конец МодельСостояния
КонецПроцедуры

&НаКлиенте
Процедура НачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	РаботаСМодельюФормыКлиент.ПроверитьЗаполнениеПараметровВыбора(ЭтотОбъект, Элемент, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытииВМоделиФормы(Отказ)
	РаботаСМодельюФормыКлиент.ПриОткрытииВМоделиФормы(ЭтотОбъект, Отказ);
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиВМоделиФормыНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	РаботаСМодельюФормы.ПриЧтенииВМоделиФормыНаСервере(ЭтотОбъект, ТекущийОбъект);
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииВМоделиФормыНаСервере(ТекущийОбъект)
	РаботаСМодельюФормы.ПриЧтенииВМоделиФормыНаСервере(ЭтотОбъект, ТекущийОбъект);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийТаблицыФормыВМоделиСостояния

&НаКлиенте
Процедура ВыборСтрокиТаблицыФормы(ТаблицаФормы, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	РаботаСМодельюФормыКлиент.ВыборСтрокиТаблицыФормы(ЭтотОбъект, ТаблицаФормы, ВыбраннаяСтрока, Поле, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура ПриАктивизацииСтрокиТаблицыФормы(ТаблицаФормы)
	РаботаСМодельюФормыКлиент.ПриАктивизацииСтрокиТаблицыФормы(ЭтотОбъект, ТаблицаФормы);
КонецПроцедуры

&НаКлиенте
Процедура ПередНачаломДобавленияСтрокиТаблицыФормы(ТаблицаФормы, Отказ, Копирование, Родитель, Группа, Параметр)
	РаботаСМодельюФормыКлиент.ПередНачаломДобавленияСтрокиТаблицыФормы(ЭтотОбъект, ТаблицаФормы, Отказ, Копирование, Родитель, Группа, Параметр);
КонецПроцедуры

&НаКлиенте
Процедура ПередНачаломИзмененияСтрокиТаблицыФормы(ТаблицаФормы, Отказ)
	РаботаСМодельюФормыКлиент.ПередНачаломИзмененияСтрокиТаблицыФормы(ЭтотОбъект, ТаблицаФормы, Отказ);
КонецПроцедуры

&НаКлиенте
Процедура ПередОкончаниемРедактированияСтрокиТаблицыФормы(ТаблицаФормы, НоваяСтрока, ОтменаРедактирования, Отказ)
	РаботаСМодельюФормыКлиент.ПередОкончаниемРедактированияСтрокиТаблицыФормы(ЭтотОбъект, ТаблицаФормы, НоваяСтрока, ОтменаРедактирования, Отказ);
КонецПроцедуры

&НаКлиенте
Процедура ПередУдалениемСтрокиТаблицыФормы(ТаблицаФормы, Отказ)
	РаботаСМодельюФормыКлиент.ПередУдалениемСтрокиТаблицыФормы(ЭтотОбъект, ТаблицаФормы, Отказ);
КонецПроцедуры

&НаСервере
Процедура ПрименитьНастройкиПараметровВыбора(НастройкиПараметровВыбора)
	РаботаСМодельюФормы.ПрименитьНастройкиПараметровВыбора(ЭтотОбъект, НастройкиПараметровВыбора);
КонецПроцедуры 

&НаКлиенте
Процедура ПриНачалеРедактированияСтрокиТаблицыФормы(ТаблицаФормы, НоваяСтрока, Копирование)
	РаботаСМодельюФормыКлиент.ПриНачалеРедактированияСтрокиТаблицыФормы(ЭтотОбъект, ТаблицаФормы, НоваяСтрока, Копирование);
	НастройкиПараметровВыбора = РаботаСМодельюФормыКлиентСервер.НастройкиПараметровВыбораТаблицыФормы(ЭтотОбъект, ТаблицаФормы);
	Если ЗначениеЗаполнено(НастройкиПараметровВыбора) Тогда
		ПрименитьНастройкиПараметровВыбора(НастройкиПараметровВыбора);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПриОкончанииРедактированияСтрокиТаблицыФормы(ТаблицаФормы, НоваяСтрока, ОтменаРедактирования)
	РаботаСМодельюФормыКлиент.ПриОкончанииРедактированияСтрокиТаблицыФормы(ЭтотОбъект, ТаблицаФормы, НоваяСтрока, ОтменаРедактирования);
КонецПроцедуры

#КонецОбласти

#Область СвойстваЭлементовИЗначенияПараметровВМоделиСостояния

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	МодельСостояния = РаботаСМодельюСостояния.МодельСостояния(ЭтотОбъект);
	//  Элементы формы
	///////////////////////////////////////////////////////////
	УстановитьУсловноеОформление();
	ДобавитьОператор("Таблица", 0);
	ДобавитьОператор("Отношение", 1);
	ДобавитьОператор("База", 2);
	//  Конец МодельСостояния
	//  Инициализация схемы
	Схема = МодельСостояния.Схема;		
	РаботаСМодельюСостояния.ДобавитьЭлементыФормы(Схема);
	РаботаСМодельюСостояния.ПрименитьМодельОбъекта(Схема);
	//  Применение модели формы
	МодельОбъекта = РаботаСМодельюОбъектаКлиентСервер.ПолучитьМодель(ЭтотОбъект);
	РаботаСМодельюФормы.НастроитьПараметрыВыбора(МодельОбъекта);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	//  Расчет модели объекта
	МодельОбъекта = РаботаСМодельюОбъектаКлиентСервер.ПолучитьМодель(ЭтотОбъект);
	РаботаСМодельюОбъектаКлиентСервер.РассчитатьПараметрыКонтекста(МодельОбъекта);
	ПриОткрытииВМоделиФормы(Отказ);
	ОбновитьФормуНаКлиенте();
КонецПроцедуры


&НаКлиентеНаСервереБезКонтекста
Функция СтрокаОтступа(ЧислоСимволов)
	Возврат СтроковыеФункцииКлиентСервер.СформироватьСтрокуСимволов(Символы.Таб, ЧислоСимволов);
КонецФункции

&НаСервере
Функция ПолучитьСтрокуРеквизитовИРесурсов(КолвоИзмерений, КолвоРеквизитов, КолвоРесурсов = 0)
	Аналитики = Новый Массив;
	Аналитики.Добавить("Ор");
	Аналитики.Добавить("Ко");
	Аналитики.Добавить("До");
	Аналитики.Добавить("Об");
	Аналитики.Добавить("Ст");
	ГСЧ = Новый ГенераторСлучайныхЧисел();
	Строка = Новый Массив;
	Для й = 0 По КолвоИзмерений - 1 Цикл
		Строка.Добавить("'" + Аналитики[й] + Строка(ГСЧ.СлучайноеЧисло(1, 9)) + "'");
	КонецЦикла;
	Для й = 0 По КолвоРеквизитов - 1 Цикл
		Строка.Добавить("'" + Аналитики[й] + Строка(ГСЧ.СлучайноеЧисло(1, 9)) + "'");
	КонецЦикла;
	Если КолвоРесурсов = 1 Тогда
		Строка.Добавить(Формат(ГСЧ.СлучайноеЧисло(1, 1000) / 100, "ЧЦ=15; ЧДЦ=2; ЧРД=.; ЧН=0; ЧГ=;"));
	ИначеЕсли КолвоРесурсов > 1 Тогда
		Ресурсы = Новый Массив;
		СуммаВсего = 0;
		Для й = 1 По КолвоРесурсов - 1 Цикл
			Сумма = ГСЧ.СлучайноеЧисло(1, 1000) / 100;
			СуммаВсего = СуммаВсего + Сумма;
			Ресурсы.Добавить(Сумма);
		КонецЦикла;
		Строка.Добавить(Формат(СуммаВсего, "ЧЦ=15; ЧДЦ=2; ЧРД=.; ЧН=0; ЧГ=;"));
		Для Каждого СуммаРесурса Из Ресурсы Цикл
			Строка.Добавить(Формат(СуммаРесурса, "ЧЦ=15; ЧДЦ=2; ЧРД=.; ЧН=0; ЧГ=;"));
		КонецЦикла;
	КонецЕсли;
	Возврат СтрСоединить(Строка, ", ");
КонецФункции
	
&НаСервере
Процедура ПолучитьМодельDSLНаСервере()
	Перем Отношение;
	Перем КолонкиОтношения;
	//@skip-check module-unused-local-variable
	Перем
		МодельРаспределения,
		РезультаРаспределелния
	;
	МодельТекстаСхема = Общий.МодельТекста()
		.Добавить("///////////////////////////////////////////////////////////////////////")
		.Добавить("//  Модель DSL")
		.Добавить("///////////////////////////////////////////////////////////////////////")
		.Добавить("МодельРаспределения = Общий.МодельРаспределения()")
	;
	Для Каждого Оператор Из СтруктураМодели.ПолучитьЭлементы() Цикл
		МодельТекстаСхема
			.ГруппировкаНачать()
		;
			Если ЗначениеЗаполнено(Оператор.Псевдоним) Тогда
				МодельТекстаСхема
					.Добавить(".{1}({2}, ""{3}"")", Оператор.Роль, Оператор.Имя, Оператор.Псевдоним)
				;
			Иначе
				МодельТекстаСхема
					.Добавить(".{1}({2})", Оператор.Роль, Оператор.Имя)
				;
			КонецЕсли;
			Для Каждого Секция Из Оператор.ПолучитьЭлементы() Цикл
				МодельТекстаСхема
					.ГруппировкаНачать()
						.Добавить(".{1}()", Секция.Роль)
				;
					МодельТекстаСхема
						.ГруппировкаНачать()
					;
					Для Каждого Поле Из Секция.ПолучитьЭлементы() Цикл
						Если ЗначениеЗаполнено(Поле.Псевдоним) Тогда
							МодельТекстаСхема
								.Добавить(".Поле(""{1}"", ""{2}"")", Поле.Имя, Поле.Псевдоним)
							;
						Иначе
							МодельТекстаСхема
								.Добавить(".Поле(""{1}"")", Поле.Имя)
							;
						КонецЕсли;
					КонецЦикла;
					МодельТекстаСхема
						.ГруппировкаЗавершить()
					.ГруппировкаЗавершить()
				;
			КонецЦикла;
		МодельТекстаСхема
			.ГруппировкаЗавершить()
		;
	КонецЦикла;
	МодельТекстаСхема
		.Добавить(";")
	;
	УстановитьБезопасныйРежим(Истина);
	Выполнить(МодельТекстаСхема.ПолучитьТекст());
	Схема = МодельРаспределения.Схема;
	Таблица = Схема.Таблица;
	База = Схема.База;
	КолонкиТаблицы = РаботаСМассивом.АТДМассив()
		.ДополнитьМассив(РаботаСМассивом.Отобразить(Таблица.Измерения, "!СтрШаблон(""'%1': 'СТРОКА(50)'"", Элемент.Поле)"))
		.ДополнитьМассив(РаботаСМассивом.Отобразить(Таблица.Реквизиты, "!СтрШаблон(""'%1': 'СТРОКА(50)'"", Элемент.Поле)"))
		.ДополнитьМассив(РаботаСМассивом.Отобразить(Таблица.Ресурсы, "!СтрШаблон(""'%1': 'ЧИСЛО(15, 2)'"", Элемент.Поле)"))	
		.ВМассив()
	;
	
	Если Схема.Свойство("Отношение", Отношение) Тогда
		КолонкиОтношения = РаботаСМассивом.АТДМассив()
			.ДополнитьМассив(РаботаСМассивом.Отобразить(Отношение.ИзмеренияТаблицы, "!СтрШаблон(""'%1': 'СТРОКА(50)'"", Элемент.Поле)"))
			.ДополнитьМассив(РаботаСМассивом.Отобразить(Отношение.ИзмеренияБазы, "!СтрШаблон(""'%1': 'СТРОКА(50)'"", Элемент.Поле)"))
			.ВМассив()
		;
	КонецЕсли;

	КолонкиБазы = РаботаСМассивом.АТДМассив()
		.ДополнитьМассив(РаботаСМассивом.Отобразить(База.Измерения, "!СтрШаблон(""'%1': 'СТРОКА(50)'"", Элемент.Поле)"))
		.ДополнитьМассив(РаботаСМассивом.Отобразить(База.Реквизиты, "!СтрШаблон(""'%1': 'СТРОКА(50)'"", Элемент.Поле)"))
		.ДополнитьМассив(РаботаСМассивом.Отобразить(База.Ресурсы, "!СтрШаблон(""'%1': 'ЧИСЛО(15, 2)'"", Элемент.Поле)"))	
		.ВМассив()
	;
//Таблица = "
//|{
//|	'Колонки': {'Объект': 'СТРОКА(50)', 'Статья': 'СТРОКА(50)',	'Сумма': 'ЧИСЛО(15, 2)', 'СуммаБезНДС': 'ЧИСЛО(15, 2)',	'СуммаНДС': 'ЧИСЛО(15, 2)'},
//|	'Строки': [
//|		['Об1', 'Ст1', 1, 0.9, 0.1],
//|		['Об1', 'Ст2', 1, 0.9, 0.1],
//|		['Об2', 'Ст1', 1, 0.9, 0.1],
//|	]
//|}";
	МодельТекстаТаблицы = Общий.МодельТекста()
		.Добавить("///////////////////////////////////////////////////////////////////////")
		.Добавить("//  Тестовые таблицы")
		.Добавить("///////////////////////////////////////////////////////////////////////")
		.Добавить("Таблица = """)
		.Добавить("|{")
	;
	МодельТекстаВставка = Общий.МодельТекста()
		.ГруппировкаНачать()
			.Добавить("'Колонки': {")
				.Присоединить(СтрСоединить(КолонкиТаблицы, ", "))
				.Присоединить("},")
			.Добавить("'Строки': [")
			.ГруппировкаНачать()
				.Добавить("[")
					.Присоединить(ПолучитьСтрокуРеквизитовИРесурсов(Таблица.Измерения.Количество(), Таблица.Реквизиты.Количество(), Таблица.Ресурсы.Количество()))
					.Присоединить("],")
				.Добавить("[")
					.Присоединить(ПолучитьСтрокуРеквизитовИРесурсов(Таблица.Измерения.Количество(), Таблица.Реквизиты.Количество(), Таблица.Ресурсы.Количество()))
					.Присоединить("],")
				.Добавить("[")
					.Присоединить(ПолучитьСтрокуРеквизитовИРесурсов(Таблица.Измерения.Количество(), Таблица.Реквизиты.Количество(), Таблица.Ресурсы.Количество()))
					.Присоединить("],")
			.ГруппировкаЗавершить()
			.Добавить("]")
		.ГруппировкаЗавершить()
	;
	МодельТекстаТаблицы
		.Добавить("|" + СтрЗаменить(МодельТекстаВставка.ПолучитьТекст(), Символы.ПС, Символы.ПС + "|"))
		.Добавить("|}"";")
	;
	Если ЗначениеЗаполнено(Отношение) Тогда
		МодельТекстаТаблицы
			.Добавить("Отношение = """)
			.Добавить("|{")
		;
		МодельТекстаВставка = Общий.МодельТекста()
			.ГруппировкаНачать()
				.Добавить("'Колонки': {")
					.Присоединить(СтрСоединить(КолонкиОтношения, ", "))
					.Присоединить("},")
				.Добавить("'Строки': [")
				.ГруппировкаНачать()
					.Добавить("[")
						.Присоединить(ПолучитьСтрокуРеквизитовИРесурсов(Отношение.ИзмеренияТаблицы.Количество(), Отношение.ИзмеренияБазы.Количество()))
						.Присоединить("],")
					.Добавить("[")
						.Присоединить(ПолучитьСтрокуРеквизитовИРесурсов(Отношение.ИзмеренияТаблицы.Количество(), Отношение.ИзмеренияБазы.Количество()))
						.Присоединить("],")
					.Добавить("[")
						.Присоединить(ПолучитьСтрокуРеквизитовИРесурсов(Отношение.ИзмеренияТаблицы.Количество(), Отношение.ИзмеренияБазы.Количество()))
						.Присоединить("],")
				.ГруппировкаЗавершить()
				.Добавить("]")
			.ГруппировкаЗавершить()
		;
		МодельТекстаТаблицы
			.Добавить("|" + СтрЗаменить(МодельТекстаВставка.ПолучитьТекст(), Символы.ПС, Символы.ПС + "|"))
			.Добавить("|}"";")
		;
	КонецЕсли;
	МодельТекстаТаблицы
		.Добавить("База = """)
		.Добавить("|{")
	;
	МодельТекстаВставка = Общий.МодельТекста()
		.ГруппировкаНачать()
			.Добавить("'Колонки': {")
				.Присоединить(СтрСоединить(КолонкиБазы, ", "))
				.Присоединить("},")
			.Добавить("'Строки': [")
			.ГруппировкаНачать()
				.Добавить("[")
					.Присоединить(ПолучитьСтрокуРеквизитовИРесурсов(База.Измерения.Количество(), База.Реквизиты.Количество(), База.Ресурсы.Количество()))
					.Присоединить("],")
				.Добавить("[")
					.Присоединить(ПолучитьСтрокуРеквизитовИРесурсов(База.Измерения.Количество(), База.Реквизиты.Количество(), База.Ресурсы.Количество()))
					.Присоединить("],")
				.Добавить("[")
					.Присоединить(ПолучитьСтрокуРеквизитовИРесурсов(База.Измерения.Количество(), База.Реквизиты.Количество(), База.Ресурсы.Количество()))
					.Присоединить("],")
			.ГруппировкаЗавершить()
			.Добавить("]")
		.ГруппировкаЗавершить()
	;
	МодельТекстаТаблицы
		.Добавить("|" + СтрЗаменить(МодельТекстаВставка.ПолучитьТекст(), Символы.ПС, Символы.ПС + "|"))
		.Добавить("|}"";")
		.Добавить("")
	;
//	МодельТекстаВременныеТаблицы = Общий.МодельТекста()
//		.Добавить("МодельЗапроса = Общий.МодельЗапроса()")
//		.Добавить(";")
//		.Добавить("МодельЗапроса.ЗапросПакета().Поместить(""ВТ_ТАБЛИЦА"")")
//		.ГруппировкаНачать()
//			.Добавить(".Источник(ОбщийКлиентСервер.JSONВОбъект(Таблица))")
//			.Добавить(".Поле(""*"")")		
//		.ГруппировкаЗавершить()
//		.Добавить(";")
//		.Добавить("МодельЗапроса.ЗапросПакета().Поместить(""ВТ_ОТНОШЕНИЕ"")")
//		.ГруппировкаНачать()
//			.Добавить(".Источник(ОбщийКлиентСервер.JSONВОбъект(Отношение))")
//			.Добавить(".Поле(""*"")")		
//		.ГруппировкаЗавершить()
//		.Добавить(";")
//		.Добавить("МодельЗапроса.ЗапросПакета().Поместить(""ВТ_БАЗА"")")
//		.ГруппировкаНачать()
//			.Добавить(".Источник(ОбщийКлиентСервер.JSONВОбъект(База))")
//			.Добавить(".Поле(""*"")")		
//		.ГруппировкаЗавершить()
//		.Добавить(";")
//		.Добавить("МодельЗапроса.ВыполнитьЗапрос();")
//	;
	Объект.МодельDSL = Общий.МодельТекста()
		.Добавить(МодельТекстаТаблицы.ПолучитьТекст())
//		.Добавить(МодельТекстаВременныеТаблицы.ПолучитьТекст())
		.Добавить(МодельТекстаСхема.ПолучитьТекст())
		.ПолучитьТекст()
	;
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьМодельDSL(Команда)
	ПолучитьМодельDSLНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура Сформировать(Команда)
	СформироватьНаСервере();
КонецПроцедуры

&НаСервере
Процедура ДобавитьПоляИсточника(МодельЗапроса, Источник, Секция, Точность = 2)
	Перем Измерения;
	Если Источник.Свойство(Секция, Измерения) Тогда
		Если Секция = "Ресурсы" Тогда
			Для Каждого Поле Из Измерения Цикл
				МодельЗапроса
					.Поле(СтрШаблон("ВЫРАЗИТЬ(%1 КАК ЧИСЛО(%2, %3))", Поле.Поле, 15, Точность), ?(ЗначениеЗаполнено(Поле.Псевдоним), Поле.Псевдоним, Поле.Поле))
				;
			КонецЦикла;
			Возврат;
		КонецЕсли;
		Для Каждого Поле Из Измерения Цикл
			МодельЗапроса
				.Поле(Поле.Поле, Поле.Псевдоним)
			;
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ДобавитьЗапросИсточника(Схема, МодельЗапроса, ИмяИсточника, Псевдоним)
	Источник = Схема[ИмяИсточника];
	Если ТипЗнч(Источник.Источник) = Тип("Строка") Тогда
		МодельЗапроса.ЗапросПакета(ИмяИсточника).Поместить(Псевдоним)
			.Источник(Источник.Источник, Источник.Псевдоним)
		;
	Иначе
		МодельЗапроса.ЗапросПакета().Поместить(Источник.Псевдоним)
			.Источник(Источник.Источник, Источник.Псевдоним)
			.Поле("*")
		;
		МодельЗапроса.ЗапросПакета(ИмяИсточника)
			.Источник(Источник.Псевдоним)
		;
	КонецЕсли;
	ДобавитьПоляИсточника(МодельЗапроса, Источник, "ИзмеренияТаблицы");
	ДобавитьПоляИсточника(МодельЗапроса, Источник, "ИзмеренияБазы");
	ДобавитьПоляИсточника(МодельЗапроса, Источник, "Измерения");
	ДобавитьПоляИсточника(МодельЗапроса, Источник, "Реквизиты");
	ДобавитьПоляИсточника(МодельЗапроса, Источник, "Ресурсы");
	Для Каждого Порядок Из Источник.Порядок Цикл
		МодельЗапроса
			.Порядок(Порядок.Выражение, Порядок.Направление)
		;
	КонецЦикла;
	Для Каждого ВыражениеОтбора Из Источник.Отбор Цикл
		МодельЗапроса
			.Отбор(ВыражениеОтбора)
		;
	КонецЦикла;
	Если Источник.Автопорядок Тогда
		МодельЗапроса
			.Автопорядок()
		;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ВыполнитьРаспределение(Результат)
	Перем МодельРаспределения;
	Перем РезультатРаспределения;
	Перем Ресурсы;
	УстановитьБезопасныйРежим(Истина);
	Выполнить(Объект.МодельDSL);
	Схема = МодельРаспределения.Схема;
	Если Схема.Таблица.Ресурсы.Количество() > 1 Тогда
		Ресурсы = Схема.Таблица.Ресурсы;				
	Иначе
		Ресурсы = Схема.База.Ресурсы;
	КонецЕсли;
	Если РезультатРаспределения = Неопределено Тогда
		Пока МодельРаспределения.Следующий() Цикл
			Если РезультатРаспределения = Неопределено Тогда
				РезультатРаспределения = МодельРаспределения.РезультатРаспределения.СкопироватьКолонки();
				РезультатРаспределения.Колонки.Добавить("НомерСтроки", ОбщегоНазначения.ОписаниеТипаЧисло(9));
				Для Каждого Ресурс Из Ресурсы Цикл
					РезультатРаспределения.Колонки.Добавить(Ресурс.Псевдоним + "НачальныйОстаток", ОбщегоНазначения.ОписаниеТипаЧисло(15, 2));
					РезультатРаспределения.Колонки.Добавить(Ресурс.Псевдоним + "КонечныйОстаток", ОбщегоНазначения.ОписаниеТипаЧисло(15, 2));
					РезультатРаспределения.Колонки.Добавить(Ресурс.Псевдоним + "Распределение", ОбщегоНазначения.ОписаниеТипаЧисло(15, 2));				
				КонецЦикла;
			КонецЕсли;
			СтрокаРезультата = МодельРаспределения.СтрокаРезультата;
			СтрокаТаблицы = МодельРаспределения.ИтераторТаблицы.ТекущиеДанные;
			СтрокаРаспределения = РезультатРаспределения.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаРаспределения, СтрокаРезультата);
			Для Каждого Ресурс Из Ресурсы Цикл
				ИмяПоля = Ресурс.Псевдоним;
				СтрокаРаспределения[ИмяПоля + "НачальныйОстаток"] = СтрокаТаблицы[ИмяПоля];
				СтрокаРаспределения[ИмяПоля + "Распределение"] = СтрокаРезультата[ИмяПоля];
				СтрокаРаспределения[ИмяПоля + "КонечныйОстаток"] = СтрокаТаблицы[ИмяПоля] - СтрокаРезультата[ИмяПоля];
			КонецЦикла;			
		КонецЦикла;
	КонецЕсли;
	Если РезультатРаспределения = Неопределено Тогда
		ВызватьИсключение "Таблица не распределилась!";
	КонецЕсли;
	///////////////////////////////////////////////////////////////////////
	//  Формирование отчета
	МодельЗапроса = Общий.МодельЗапроса(МодельРаспределения.МенеджерВременныхТаблиц)
	;//  ЗАПРОС ПАКЕТА. ВТ_РЕЗУЛЬТАТ 
	МодельЗапроса.ЗапросПакета().Поместить("ВТ_РЕЗУЛЬТАТ")
		.Источник(РезультатРаспределения)
		.Поле("*")
	;//  ЗАПРОС ПАКЕТА. ВТ_ОСТАТОК
	МодельЗапроса.ЗапросПакета().Поместить("ВТ_ОСТАТОК")
		.Источник(МодельРаспределения.ТаблицаРаспределения)
		.Поле("*")
	;
	МодельЗапроса.ЗапросПакета().Поместить("ВТ_РЕЗУЛЬТАТ_РАСПРЕДЕЛЕНИЯ")
		.Выбрать()
			.Источник("ВТ_РЕЗУЛЬТАТ")
			.Поле("*")
		.ОбъединитьВсе()
			.Источник("ВТ_ОСТАТОК")
			.Источник("ВТ_РЕЗУЛЬТАТ")
			.ЛевоеСоединение("ВТ_ОСТАТОК", "ВТ_РЕЗУЛЬТАТ")
				.Связь(РаботаСМассивом.АТДМассив(Схема.Таблица.Измерения)
					.Отобразить("Элемент.Псевдоним")
					.ВМассив()
				)
			.Отбор(СтрШаблон("ВТ_РЕЗУЛЬТАТ.%1 ЕСТЬ NULL", Схема.Таблица.Измерения[0].Псевдоним))
	;
			Для Каждого Ресурс Из Ресурсы Цикл
				ИмяПоля = Ресурс.Псевдоним;
				МодельЗапроса
					.Поле("ВТ_ОСТАТОК." + ИмяПоля, ИмяПоля + "НачальныйОстаток")
					.Поле("0", ИмяПоля + "Распределение")
					.Поле("ВТ_ОСТАТОК." + ИмяПоля, ИмяПоля + "КонечныйОстаток")
				;
			КонецЦикла;
			МодельЗапроса
				.Поле("ВТ_ОСТАТОК.*")
	;
	МодельЗапроса.ВыполнитьЗапрос();
	////////////////////////////////////////////////////////////////////////////////
	//  Модель отчета
	////////////////////////////////////////////////////////////////////////////////
	//  Схема компоновки
	МодельСхемыКомпоновки = Общий.МодельСхемыКомпоновкиДанных()
	;//  Источник данных
	МодельЗапроса.ЗапросПакета()
		.Источник("ВТ_РЕЗУЛЬТАТ_РАСПРЕДЕЛЕНИЯ")
		.Поле("*")
	;
	ТекстЗапроса = МодельЗапроса.ПолучитьТекстЗапроса();
	МодельСхемыКомпоновки.НаборДанныхЗапрос(ТекстЗапроса)
		.Измерения()
	;
	Для Каждого Поле Из Схема.Таблица.Измерения Цикл
		МодельСхемыКомпоновки
			.Поле(Поле.Псевдоним)
		;	
	КонецЦикла;
	Для Каждого Поле Из Схема.Таблица.Реквизиты Цикл
		МодельСхемыКомпоновки
			.Поле(Поле.Псевдоним)
		;	
	КонецЦикла;
	МодельСхемыКомпоновки
		.Ресурсы()
	;
	Для Каждого Ресурс Из Ресурсы Цикл
		МодельСхемыКомпоновки
			.НачальныйОстаток(Ресурс.Поле + "НачальныйОстаток", , , Ресурс.Поле).Оформление("Формат", "ЧЦ=15; ЧДЦ=2;")
			.Сумма(Ресурс.Поле + "Распределение").Оформление("Формат", "ЧЦ=15; ЧДЦ=2;")	
			.КонечныйОстаток(Ресурс.Поле + "КонечныйОстаток", , , Ресурс.Поле).Оформление("Формат", "ЧЦ=15; ЧДЦ=2;")
		;	
	КонецЦикла;
	//  Реквизиты
	МодельСхемыКомпоновки
		.Реквизиты()
		.Период("НомерСтроки").Обязательное()
	;
	Для Каждого Поле Из Схема.База.Измерения Цикл
		МодельСхемыКомпоновки
			.Поле(Поле.Псевдоним)
		;	
	КонецЦикла;
	Для Каждого Поле Из Схема.База.Реквизиты Цикл
		МодельСхемыКомпоновки
			.Поле(Поле.Псевдоним)
		;	
	КонецЦикла;
	////////////////////////////////////////////////////////////////////////////////
	//  Настройка компоновки
	МодельНастройкиКомпоновки = Общий.МодельНастройкиКомпоновкиДанных(МодельСхемыКомпоновки.СхемаКомпоновкиДанных)
	;
	Для Каждого Поле Из Схема.Таблица.Измерения Цикл
		МодельНастройкиКомпоновки
			.Поле(Поле.Псевдоним)
		;	
	КонецЦикла;
	Для Каждого Поле Из Схема.Таблица.Реквизиты Цикл
		МодельНастройкиКомпоновки
			.Поле(Поле.Псевдоним)
		;	
	КонецЦикла;
	Для Каждого Поле Из Схема.База.Измерения Цикл
		МодельНастройкиКомпоновки
			.Поле(Поле.Псевдоним)
		;	
	КонецЦикла;
	Для Каждого Поле Из Схема.База.Реквизиты Цикл
		МодельНастройкиКомпоновки
			.Поле(Поле.Псевдоним)
		;	
	КонецЦикла;
	МодельНастройкиКомпоновки
		.ГруппаНачать("Ресурсы", РасположениеПоляКомпоновкиДанных.Авто)
	;
		Для Каждого Группа Из СтрРазделить("Начальный остаток,Распределение,Конечный остаток", ",") Цикл
			МодельНастройкиКомпоновки
				.ГруппаНачать(Группа, РасположениеПоляКомпоновкиДанных.Авто)
			;
			Для Каждого Ресурс Из Ресурсы Цикл
				МодельНастройкиКомпоновки
					.Поле(Ресурс.Поле + СтрЗаменить(Группа, " ", ""), Ресурс.Псевдоним)
				;	
			КонецЦикла;
			МодельНастройкиКомпоновки
				.ГруппаЗавершить()
			;
		КонецЦикла;
	МодельНастройкиКомпоновки
		.ГруппаЗавершить()
		.Структура()
			.ГруппировкаНачать()
	;
			Для Каждого Поле Из Схема.Таблица.Измерения Цикл
				МодельНастройкиКомпоновки
					.ПолеГруппировки(Поле.Псевдоним)
				;
			КонецЦикла;
			Для Каждого Поле Из Схема.Таблица.Реквизиты Цикл
				МодельНастройкиКомпоновки
					.ПолеГруппировки(Поле.Псевдоним)
				;
			КонецЦикла;
			МодельНастройкиКомпоновки
				.Поле("*")
				.ГруппировкаНачать()
					.ПолеГруппировки("*")
					.Поле("*")
				.ГруппировкаЗавершить()
			.ГруппировкаЗавершить()
		.Порядок("НомерСтроки")
		.ПараметрыВывода()
			.Параметр("МакетОформления", "Арктика")
	;
	////////////////////////////////////////////////////////////////////////////////
	//  Макет компоновки данных
	////////////////////////////////////////////////////////////////////////////////
	МодельМакетаКомпоновки = Общий.МодельМакетаКомпоновкиДанных()
		.Схема(МодельСхемыКомпоновки.СхемаКомпоновкиДанных)
		.Настройки(МодельНастройкиКомпоновки.Настройки)
		.Скомпоновать()
		.ИдентификаторТаблицы()
	;
	Макеты = МодельМакетаКомпоновки.МакетКомпоновкиДанных.Макеты;
	СтруктураМакета = МодельМакетаКомпоновки.СтруктураМакета();
	МакетШапка = Макеты[СтруктураМакета[СтруктураМакета.ВГраница() - 1].Макет];
	Если Ресурсы.Количество() = 1 Тогда
		МакетШапка.Макет.Удалить(МакетШапка.Макет.Количество() - 1);
	КонецЕсли;
	ЯчейкиТаблицы = МакетШапка.Макет[0].Ячейки;
	Для Каждого Ячейка Из ЯчейкиТаблицы Цикл
		Ячейка.Оформление.УстановитьЗначениеПараметра("МинимальнаяШирина", 15);
		Ячейка.Оформление.УстановитьЗначениеПараметра("МаксимальнаяШирина", 15);
	КонецЦикла;
	////////////////////////////////////////////////////////////////////////////////
	//  Макет компоновки данных
	////////////////////////////////////////////////////////////////////////////////
	МодельМакетаКомпоновки
		.МенеджерВременныхТаблиц(МодельЗапроса.МенеджерВременныхТаблиц)
		.ВывестиВТабличныйДокумент(Результат)		
	;
КонецПроцедуры

&НаКлиенте
Процедура КомандаРезультатСОграничениемБезОтношения(Команда)
	ЗагрузитьСхему("СОграничениемБезОтношения");
КонецПроцедуры

&НаКлиенте
Процедура КомандаРезультатСДопРаспределением(Команда)
	ЗагрузитьСхему("РезультатСДопРаспределением");
КонецПроцедуры

&НаСервере
Процедура СформироватьНаСервере()
	Результат.Очистить();
	ВыполнитьРаспределение(Результат);
КонецПроцедуры

&НаСервере
Функция ДобавитьВСтруктуруМоделиПоля(Оператор, Роль, Таблица)
	Секция = Оператор.ПолучитьЭлементы().Добавить();
	Секция.Роль = Роль;
	Секция.Уровень = 1;
	Для Каждого СтруктураПоля Из Таблица[Роль] Цикл
		Поле = Секция.ПолучитьЭлементы().Добавить();
		Поле.Роль = "Поле";
		Поле.Имя = СтруктураПоля.Поле;
		Если ЗначениеЗаполнено(СтруктураПоля.Псевдоним) И СтруктураПоля.Псевдоним <> Поле.Имя Тогда
			Поле.Псевдоним = СтруктураПоля.Псевдоним;
		КонецЕсли;
		Поле.Уровень = 2;
	КонецЦикла;
КонецФункции

&НаКлиенте
Процедура ЗагрузитьСхему(ИмяСхемы)
	Дерево = СтруктураМодели.ПолучитьЭлементы();
	Дерево.Очистить();
	ЗагрузитьСхемуНаСервере(ИмяСхемы);
	Для Каждого Элемент Из Дерево Цикл
		Элементы.СтруктураМодели.Развернуть(Элемент.ПолучитьИдентификатор(), Истина);		
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура КомандаОтношениеСДопРесурсами(Команда)
	ЗагрузитьСхему("ОтношениеСДопРесурсами");
КонецПроцедуры

&НаКлиенте
Процедура КомандаРезультатСОграничением(Команда)
	ЗагрузитьСхему("РезультатСОграничением");
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьСхемуНаСервере(ИмяСхемы)
	_Обработка = РеквизитФормыВЗначение("Объект");
	Макет = _Обработка.ПолучитьМакет(ИмяСхемы);
	Объект.МодельDSL = Макет.ПолучитьТекст();
	ПолучитьСхемуИзМоделиНаСервере();
КонецПроцедуры

&НаСервере
Процедура ДобавитьВСтруктуруМоделиТаблицу(Роль, Схема)
	Если НЕ Схема.Свойство(Роль) Тогда
		Возврат;
	КонецЕсли;
	Таблица = Схема[Роль];
	Оператор = СтруктураМодели.ПолучитьЭлементы().Добавить();
	Оператор.Роль = Роль;
	Оператор.Псевдоним = ?(Лев(Таблица.Псевдоним, 1) = "_", "", Таблица.Псевдоним);
	Если Таблица.ЭтоИсточникИзОбъекта Тогда
		Оператор.Имя = ?(ЗначениеЗаполнено(Оператор.Псевдоним), Оператор.Псевдоним, Роль);
	Иначе 
		Оператор.Имя = Таблица.Источник;
	КонецЕсли;
	Оператор.Уровень = 0;
	Если Роль = "Отношение" Тогда
		ДобавитьВСтруктуруМоделиПоля(Оператор, "ИзмеренияТаблицы", Таблица);
		ДобавитьВСтруктуруМоделиПоля(Оператор, "ИзмеренияБазы", Таблица);
	Иначе
		ДобавитьВСтруктуруМоделиПоля(Оператор, "Измерения", Таблица);
		ДобавитьВСтруктуруМоделиПоля(Оператор, "Ресурсы", Таблица);
		ДобавитьВСтруктуруМоделиПоля(Оператор, "Реквизиты", Таблица);
	КонецЕсли;
КонецПроцедуры

//@skip-check module-unused-local-variable
&НаСервере
Процедура ПолучитьСхемуИзМоделиНаСервере()
	Перем 
		МодельРаспределения,
		РезультатРаспределения
	;
	УстановитьБезопасныйРежим(Истина);
	Выполнить(Объект.МодельDSL);
	Схема = МодельРаспределения.Схема;
	ДобавитьВСтруктуруМоделиТаблицу("Таблица", Схема);
	ДобавитьВСтруктуруМоделиТаблицу("Отношение", Схема);
	ДобавитьВСтруктуруМоделиТаблицу("База", Схема);
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьСхемуИзМодели(Команда)
	Дерево = СтруктураМодели.ПолучитьЭлементы();
	Дерево.Очистить();
	ПолучитьСхемуИзМоделиНаСервере();
	Для Каждого Элемент Из Дерево Цикл
		Элементы.СтруктураМодели.Развернуть(Элемент.ПолучитьИдентификатор(), Истина);		
	КонецЦикла;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьУсловноеОформление()
	УсловноеОформление.Элементы.Очистить();
	МодельОформления = Общий.МодельОформления(УсловноеОформление)
	;//  Уровень 1
	МодельОформления.ЭлементОформления()
		.Элемент("СтруктураМоделиИмя")
		.Элемент("СтруктураМоделиПсевдоним")
			.Оформление("ТолькоПросмотр", Истина)
			.Оформление("ЦветФона", ЦветаСтиля.ИтогиФонГруппы)
			.Отбор("СтруктураМодели.Уровень", ВидСравненияКомпоновкиДанных.Равно, 1)
	;
КонецПроцедуры

&НаСервере
Процедура ДобавитьОператор(Имя, Порядок)
	Оператор = СтруктураМодели.ПолучитьЭлементы().Добавить();
	Оператор.Роль = Имя;
	Оператор.Порядок = Порядок;
	Если Имя = "Отношение" Тогда
		Секции = Оператор.ПолучитьЭлементы();
		Секция = Секции.Добавить();
		Секция.Роль = "ИзмеренияТаблицы";
		Секция.Уровень = 1;
		Секция = Секции.Добавить();
		Секция.Роль = "ИзмеренияБазы";
		Секция.Уровень = 1;
		Секция = Секции.Добавить();
		Секция.Роль = "Ресурсы";
		Секция.Уровень = 1;
		Возврат;
	КонецЕсли;
	Секции = Оператор.ПолучитьЭлементы();
	Секция = Секции.Добавить();
	Секция.Роль = "Измерения";
	Секция.Уровень = 1;
	Секция = Секции.Добавить();
	Секция.Роль = "Ресурсы";
	Секция.Уровень = 1;
	Секция = Секции.Добавить();
	Секция.Роль = "Реквизиты";
	Секция.Уровень = 1;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийТабличнойЧастиСтруктураМодели

&НаКлиенте
Асинх Процедура ВыбратьУровень(Уровень)
	Меню = Новый СписокЗначений;
	Если Уровень = 0 Тогда
		ЭлементыУровня0 = СтруктураМодели.ПолучитьЭлементы();
		Роли = Новый Массив;
		Для Каждого ЭлементУровня0 Из ЭлементыУровня0 Цикл
			Роли.Добавить(ЭлементУровня0.Имя);
		КонецЦикла;
		Если Роли.Найти("Отношение") = Неопределено Тогда
			Меню.Добавить("Отношение");
		КонецЕсли;
		Если Роли.Найти("База") = Неопределено Тогда
			Меню.Добавить("База");
		КонецЕсли;
		РезультатВыбора = Ждать Меню.ВыбратьЭлементАсинх("Выбор таблицы");
		Если РезультатВыбора = Неопределено Тогда
			Возврат;
		КонецЕсли;
		//РаботаСМодельюФормыКлиент.ПередНачаломДобавленияСтрокиТаблицыФормы(ЭтотОбъект, Элементы.СтруктураМодели);
		//ЭлементТекущейСтроки = СтруктураМодели.НайтиПоИдентификатору(Элементы.СтруктураМодели.ТекущаяСтрока);
		ЭлементТекущейСтроки = СтруктураМодели.ПолучитьЭлементы().Добавить();
		ЭлементТекущейСтроки.Уровень = 0;
		ЭлементТекущейСтроки.Роль = РезультатВыбора.Значение;
		Если РезультатВыбора.Значение = "Отношение" Тогда
			ЭлементТекущейСтроки.Порядок = 1;
		Иначе
			ЭлементТекущейСтроки.Порядок = 2;
		КонецЕсли;
		РаботаСМассивом.СортироватьЭлементыКоллекции(СтруктураМодели.ПолучитьЭлементы(), "Сравнить(А.Порядок, Б.Порядок)", Ложь);
		ТекущийЭлемент = Элементы.СтруктураМоделиИмя;
		Элементы.СтруктураМодели.ИзменитьСтроку();
		Возврат;
	КонецЕсли;
	Меню.Добавить("Измерения");
	Меню.Добавить("ИзмеренияТаблицы");
	Меню.Добавить("ИзмеренияБазы");
	Меню.Добавить("Ресурсы");
	Меню.Добавить("Реквизиты");
	//РезультатВыбора = ВыбратьИзМеню(Меню);
	РезультатВыбора = Ждать Меню.ВыбратьЭлементАсинх("Выбор секции таблицы");
	Если РезультатВыбора = Неопределено Тогда
		Возврат;
	КонецЕсли;
	ЭлементТекущейСтроки = СтруктураМодели.ПолучитьЭлементы().Добавить();
	ЭлементТекущейСтроки.Уровень = 1;
	ЭлементТекущейСтроки.Роль = РезультатВыбора.Значение;
	Если РезультатВыбора.Значение = "Измерения" Тогда
		ЭлементТекущейСтроки.Порядок = 1;
	ИначеЕсли РезультатВыбора.Значение = "ИзмеренияТаблицы" Тогда
		ЭлементТекущейСтроки.Порядок = 2;
	ИначеЕсли РезультатВыбора.Значение = "ИзмеренияБазы" Тогда
		ЭлементТекущейСтроки.Порядок = 3;
	ИначеЕсли РезультатВыбора.Значение = "Ресурсы" Тогда
		ЭлементТекущейСтроки.Порядок = 4;
	Иначе
		ЭлементТекущейСтроки.Порядок = 5;
	КонецЕсли;
	РаботаСМассивом.СортироватьЭлементыКоллекции(СтруктураМодели.ПолучитьЭлементы(), "Сравнить(А.Порядок, Б.Порядок)", Истина);
	ТекущийЭлемент = Элементы.СтруктураМоделиИмя;
	Элементы.СтруктураМодели.ИзменитьСтроку();
КонецПроцедуры

&НаКлиенте
Процедура СтруктураМоделиПередНачаломДобавленияСтроки(ТаблицаФормы, Отказ, Копирование, Родитель, Группа, Параметр)
	ТекущийЭлемент = Элементы.СтруктураМоделиИмя;
	Если ТаблицаФормы.ТекущиеДанные.Уровень = 0 Тогда
		Отказ = Истина;
		ВыбратьУровень(0);
		Возврат;
	КонецЕсли;
	Если ТаблицаФормы.ТекущиеДанные.Уровень = 1 Тогда
		РаботаСМодельюФормыКлиент.ПередНачаломДобавленияСтрокиТаблицыФормы(ЭтотОбъект, ТаблицаФормы, Отказ, Копирование, Родитель, Группа, Параметр, Истина);
		ЭлементТекущейСтроки = СтруктураМодели.НайтиПоИдентификатору(ТаблицаФормы.ТекущаяСтрока);
		ЭлементТекущейСтроки.Роль = "Поле";
		ЭлементТекущейСтроки.Уровень = 2;
		Возврат;
	КонецЕсли;
	РаботаСМодельюФормыКлиент.ПередНачаломДобавленияСтрокиТаблицыФормы(ЭтотОбъект, ТаблицаФормы, Отказ, Копирование, Родитель, Группа, Параметр);
	ЭлементТекущейСтроки = СтруктураМодели.НайтиПоИдентификатору(ТаблицаФормы.ТекущаяСтрока);
	ЭлементТекущейСтроки.Роль = "Поле";
	ЭлементТекущейСтроки.Уровень = 2;
КонецПроцедуры

#КонецОбласти