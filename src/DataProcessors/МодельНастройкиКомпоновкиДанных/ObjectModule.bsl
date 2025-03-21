//  Подсистема "Модель отчета"
//	Автор: Калякин Андрей Г.
//  https://github.com/KalyakinAG/kassl
//  https://github.com/KalyakinAG/report-model

Перем Настройки Экспорт;
Перем ВыбранноеПоле;
Перем ГруппаВыбранныхПолей;
Перем ГруппаОтбора;
Перем ЭлементОтбора;
Перем Группировка;
Перем ПолеГруппировки;
Перем Таблица;
Перем ЭлементУсловногоОформления;
Перем ОформляемоеПоле;

Перем Раздел;
Перем Разделы;

Функция ЭлементОформления() Экспорт
	ЭлементУсловногоОформления = Настройки.УсловноеОформление.Элементы.Добавить();
	Возврат ЭтотОбъект;
КонецФункции

Функция Оформление(ИмяПараметра, ЗначениеПараметра) Экспорт
	ЭлементУсловногоОформления.Оформление.УстановитьЗначениеПараметра(ИмяПараметра, ЗначениеПараметра);
	Возврат ЭтотОбъект;
КонецФункции

Функция ОформляемоеПоле(ИмяПоля)
	ОформляемоеПоле = ЭлементУсловногоОформления.Поля.Элементы.Добавить();
	ОформляемоеПоле.Поле = Новый ПолеКомпоновкиДанных(ИмяПоля);
	ОформляемоеПоле.Использование = Истина;
	Возврат ЭтотОбъект;
КонецФункции

Функция Выбор() Экспорт
	Возврат ЭтотОбъект;
КонецФункции

Функция Поле(ИмяПоля, Заголовок = "") Экспорт
	Если Раздел = Разделы.УсловноеОформление Тогда
		Возврат ОформляемоеПоле(ИмяПоля);
	КонецЕсли;
	ЭтоАвтоПоле = ПустаяСтрока(ИмяПоля) ИЛИ ИмяПоля = "*";
	Если ЭтоАвтоПоле Тогда
		ТипПоля = Тип("АвтоВыбранноеПолеКомпоновкиДанных");
	Иначе
		ТипПоля = Тип("ВыбранноеПолеКомпоновкиДанных");
	КонецЕсли;
	Если ГруппаВыбранныхПолей = Неопределено Тогда
		Если Группировка = Неопределено Тогда
			ВыбранноеПоле = Настройки.Выбор.Элементы.Добавить(ТипПоля);
		Иначе
			ВыбранноеПоле = Группировка.Выбор.Элементы.Добавить(ТипПоля);
		КонецЕсли;
	Иначе
		ВыбранноеПоле = ГруппаВыбранныхПолей.Элементы.Добавить(ТипПоля);
	КонецЕсли;
	ВыбранноеПоле.Использование = Истина;
	Если ЭтоАвтоПоле Тогда
		Возврат ЭтотОбъект;
	КонецЕсли;
	ВыбранноеПоле.Поле = Новый ПолеКомпоновкиДанных(ИмяПоля);
	Если ЗначениеЗаполнено(Заголовок) Тогда
		ВыбранноеПоле.Заголовок = Заголовок;
	КонецЕсли;
	Возврат ЭтотОбъект;
КонецФункции

Функция Поля(Поля) Экспорт
	Для Каждого ЭлементПоля Из ОбщийКлиентСервер.Массив(Поля) Цикл
		Если ТипЗнч(ЭлементПоля) = Тип("Строка") Тогда
			Поле(ЭлементПоля);
			Продолжить;
		КонецЕсли;
		Поле(ЭлементПоля.Имя, ЭлементПоля.Заголовок);
	КонецЦикла;
	Возврат ЭтотОбъект;
КонецФункции

Функция ГруппаНачать(Заголовок, Расположение = Неопределено) Экспорт
	Если ГруппаВыбранныхПолей = Неопределено Тогда
		Если Группировка = Неопределено Тогда
			ГруппаВыбранныхПолей = Настройки.Выбор.Элементы.Добавить(Тип("ГруппаВыбранныхПолейКомпоновкиДанных"));
		Иначе
			ГруппаВыбранныхПолей = Группировка.Выбор.Элементы.Добавить(Тип("ГруппаВыбранныхПолейКомпоновкиДанных"));
		КонецЕсли;
	Иначе
		ГруппаВыбранныхПолей = ГруппаВыбранныхПолей.Элементы.Добавить(Тип("ГруппаВыбранныхПолейКомпоновкиДанных"));
	КонецЕсли;
	ГруппаВыбранныхПолей.Использование = Истина;
	ГруппаВыбранныхПолей.Расположение = ?(Расположение = Неопределено, РасположениеПоляКомпоновкиДанных.Авто, Расположение);
	ГруппаВыбранныхПолей.Заголовок = Заголовок;
	Возврат ЭтотОбъект;
КонецФункции

Функция ГруппаЗавершить() Экспорт
	ГруппаВыбранныхПолей = ГруппаВыбранныхПолей.Родитель;
	Возврат ЭтотОбъект;
КонецФункции

Функция ОтборГруппаНачать(ТипГруппы) Экспорт
	Если ГруппаОтбора = Неопределено Тогда
		ГруппаОтбора = Настройки.Отбор.Элементы.Добавить(Тип("ГруппаЭлементовОтбораКомпоновкиДанных"));
	Иначе
		ГруппаОтбора = ГруппаОтбора.Элементы.Добавить(Тип("ГруппаЭлементовОтбораКомпоновкиДанных"));
	КонецЕсли;
	ГруппаОтбора.Использование = Истина;
	ГруппаОтбора.ТипГруппы = ТипГруппы;
	Возврат ЭтотОбъект;
КонецФункции

Функция ОтборГруппаИНачать() Экспорт
	ОтборГруппаНачать(ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИ);
	Возврат ЭтотОбъект;
КонецФункции

Функция ОтборГруппаИЛИНачать() Экспорт
	ОтборГруппаНачать(ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИли);
	Возврат ЭтотОбъект;
КонецФункции

Функция ОтборГруппаНЕНачать() Экспорт
	ОтборГруппаНачать(ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаНе);
	Возврат ЭтотОбъект;
КонецФункции

Функция ОтборГруппаЗавершить() Экспорт
	ГруппаОтбора = ГруппаОтбора.Родитель;
	Возврат ЭтотОбъект;
КонецФункции

Функция Отбор(ИмяПоля, ВидСравнения = Неопределено, Значение) Экспорт
	Если ГруппаОтбора = Неопределено Тогда
		ЭлементОтбора = Настройки.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	Иначе
		ЭлементОтбора = ГруппаОтбора.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	КонецЕсли;
	ЭлементОтбора.Использование = Истина;
	ЭлементОтбора.ЛевоеЗначение = ?(ТипЗнч(ИмяПоля) = Тип("Строка"), Новый ПолеКомпоновкиДанных(ИмяПоля), ИмяПоля);
	ЭлементОтбора.ПравоеЗначение = Значение;
	ЭлементОтбора.ВидСравнения = ?(ВидСравнения = Неопределено, ВидСравненияКомпоновкиДанных.Равно, ВидСравнения);
	Возврат ЭтотОбъект;
КонецФункции

Функция Порядок(ИмяПоля, ТипУпорядочивания = Неопределено) Экспорт
	ЭлементПорядка = Настройки.Порядок.Элементы.Добавить(Тип("ЭлементПорядкаКомпоновкиДанных"));
	ЭлементПорядка.Поле = Новый ПолеКомпоновкиДанных(ИмяПоля);
	Если ТипЗнч(ТипУпорядочивания) = Тип("Строка") Тогда
		Если ТипУпорядочивания = "-" Тогда
			ЭлементПорядка.ТипУпорядочивания = НаправлениеСортировкиКомпоновкиДанных.Убыв;
		Иначе
			ЭлементПорядка.ТипУпорядочивания = НаправлениеСортировкиКомпоновкиДанных.Возр;
		КонецЕсли;
	Иначе
		ЭлементПорядка.ТипУпорядочивания = ?(ТипУпорядочивания = Неопределено, НаправлениеСортировкиКомпоновкиДанных.Возр, ТипУпорядочивания);
	КонецЕсли;
	ЭлементПорядка.Использование = Истина;
	Возврат ЭтотОбъект;
КонецФункции

Функция ГруппировкаНачать(ИмяГруппировки = Неопределено) Экспорт
	Если Группировка = Неопределено Тогда
		Группировка = Настройки.Структура.Добавить(Тип("ГруппировкаКомпоновкиДанных"));
	ИначеЕсли ТипЗнч(Группировка) = Тип("ГруппировкаТаблицыКомпоновкиДанных") Тогда
		Группировка = Группировка.Структура.Добавить();
	Иначе
		Группировка = Группировка.Структура.Добавить(Тип("ГруппировкаКомпоновкиДанных"));
	КонецЕсли;
	Группировка.Использование = Истина;
	Если ИмяГруппировки <> Неопределено Тогда
		Группировка.Имя = ИмяГруппировки;
	КонецЕсли;
//	ВыбранноеПоле = Группировка.Выбор.Элементы.Добавить(Тип("АвтоВыбранноеПолеКомпоновкиДанных"));
//	ВыбранноеПоле.Использование = Истина;
	Возврат ЭтотОбъект;
КонецФункции

Функция ПолеГруппировки(ПутьКДанным) Экспорт
	Если ПутьКДанным = "*" Тогда
		ПолеГруппировки = Группировка.ПоляГруппировки.Элементы.Добавить(Тип("АвтоПолеГруппировкиКомпоновкиДанных"));
		Возврат ЭтотОбъект;
	КонецЕсли;
	ПолеГруппировки = Группировка.ПоляГруппировки.Элементы.Добавить(Тип("ПолеГруппировкиКомпоновкиДанных"));
	ПолеГруппировки.Использование = Истина;
	ПолеГруппировки.Поле = ?(ТипЗнч(ПутьКДанным) = Тип("Строка"), Новый ПолеКомпоновкиДанных(ПутьКДанным), ПутьКДанным);
	Возврат ЭтотОбъект;
КонецФункции

Функция ГруппировкаЗавершить() Экспорт
	Группировка = Группировка.Родитель;
	Возврат ЭтотОбъект;
КонецФункции

Функция ТаблицаНачать() Экспорт
	Если Группировка = Неопределено Тогда
		Таблица = Настройки.Структура.Добавить(Тип("ТаблицаКомпоновкиДанных"));
	Иначе
		Таблица = Группировка.Структура.Добавить(Тип("ТаблицаКомпоновкиДанных"));
	КонецЕсли;
	Возврат ЭтотОбъект;
КонецФункции

Функция ТаблицаЗавершить() Экспорт
	Группировка = Таблица.Родитель;
	Таблица = Неопределено;
	Возврат ЭтотОбъект;
КонецФункции

Функция Строки() Экспорт
	Группировка = Таблица.Строки.Добавить();
	Группировка.Использование = Истина;
	ВыбранноеПоле = Группировка.Выбор.Элементы.Добавить(Тип("АвтоВыбранноеПолеКомпоновкиДанных"));
	ВыбранноеПоле.Использование = Истина;
	Возврат ЭтотОбъект;
КонецФункции

Функция Колонки() Экспорт
	Группировка = Таблица.Колонки.Добавить();
	Группировка.Использование = Истина;
	ВыбранноеПоле = Группировка.Выбор.Элементы.Добавить(Тип("АвтоВыбранноеПолеКомпоновкиДанных"));
	ВыбранноеПоле.Использование = Истина;
	Возврат ЭтотОбъект;
КонецФункции

Функция Параметр(ИмяПараметра, Значение) Экспорт
	Если Раздел = Разделы.ПараметрыВывода Тогда
		Если Группировка = Неопределено Тогда
			Параметр = Настройки.ПараметрыВывода.Элементы.Найти(ИмяПараметра);
		Иначе
			Параметр = Группировка.ПараметрыВывода.Элементы.Найти(ИмяПараметра);
		КонецЕсли;
		Если Параметр = Неопределено Тогда
			ВызватьИсключение "Неизвестный параметр вывода " + ИмяПараметра;
		КонецЕсли;
		Параметр.Значение = Значение;
		Параметр.Использование = Истина;
	ИначеЕсли Раздел = Разделы.ПараметрыДанных Тогда
		Параметр = Настройки.ПараметрыДанных.Элементы.Добавить();
		Параметр.Параметр = Новый ПараметрКомпоновкиДанных(ИмяПараметра);
		Параметр.Значение = Значение;
		Параметр.Использование = Истина;
	Иначе
		ВызватьИсключение "Не задан контекст для параметра настройки СКД!";
	КонецЕсли;
	Возврат ЭтотОбъект;
КонецФункции

Функция Измерения() Экспорт
	Раздел = Разделы.Измерения;
	НомерПериода = 0;
	Возврат ЭтотОбъект;
КонецФункции

Функция Реквизиты() Экспорт
	Раздел = Разделы.Реквизиты;
	Возврат ЭтотОбъект;
КонецФункции

Функция Ресурсы() Экспорт
	Раздел = Разделы.Ресурсы;
	Возврат ЭтотОбъект;
КонецФункции

Функция Условия() Экспорт
	Раздел = Разделы.Условия;
	Возврат ЭтотОбъект;
КонецФункции

Функция УсловноеОформление() Экспорт
	Раздел = Разделы.УсловноеОформление;
	Возврат ЭтотОбъект;
КонецФункции

Функция Структура() Экспорт
	Раздел = Разделы.Структура;
	Возврат ЭтотОбъект;
КонецФункции

Функция ПараметрыДанных() Экспорт
	Раздел = Разделы.ПараметрыДанных;
	Возврат ЭтотОбъект;
КонецФункции

Функция ПараметрыВывода() Экспорт
	Раздел = Разделы.ПараметрыВывода;
	Возврат ЭтотОбъект;
КонецФункции

Разделы = Новый Структура("Измерения, Реквизиты, Ресурсы, Условия, УсловноеОформление, Структура, ПараметрыДанных, ПараметрыВывода", 1, 2, 3, 4, 5, 6, 7, 8);
