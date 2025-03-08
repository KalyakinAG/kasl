// Создает таблицу значений на основании информации о колонках.
// 
// Параметры:
// Колонки 	- Структура - {Имя, ОписаниеТипа}|{Имя, ТипЗнч(Значение)}
// 			- КоллекцияКолонокТаблицыЗначений, КоллекцияКолонокДереваЗначений, КоллекцияКолонокРезультатаЗапроса
// 			- Строка
// 
// Возвращаемое значение:
//  ТаблицаЗначений - Таблица значений
Функция ТаблицаЗначений(Колонки) Экспорт 
	Таблица = Новый ТаблицаЗначений;
	СоздатьКолонки(Таблица, Колонки);
	Возврат Таблица;
КонецФункции

Функция ДеревоЗначений(Колонки) Экспорт 
	Дерево = Новый ДеревоЗначений;
	СоздатьКолонки(Дерево, Колонки);
	Возврат Дерево;
КонецФункции

// Определяет идентификатор строки коллекции значений. Для коллекций, отображаемых в интерфейсе возвращается идентификатор, для
// объектных коллекций - индекс. Разделение нужно для того, чтобы была возможность идентификации строки в интерфейсе
//
// Параметры:
//	Коллекция	- ДанныеФормыДерево, ДанныеФормыКоллекция, ТабличнаяЧасть, ТаблицаЗначений, КоллекцияСтрокДереваЗначений
//	СтрокаКоллекции - ДанныеФормыЭлементКоллекции, ДанныеФормыЭлементДерева, СтрокаТабличнойЧасти, СтрокаТаблицыЗначений, СтрокаДереваЗначений
//
// Возвращаемое значение:
//	Число - идентификатор для интерфейсного элемента и индекс для объектного
//
Функция ПолучитьИдентификатор(Коллекция, СтрокаКоллекции) Экспорт
	ТипЗначения = ТипЗнч(СтрокаКоллекции);
	Если ТипЗначения = Тип("ДанныеФормыЭлементКоллекции") ИЛИ ТипЗначения = Тип("ДанныеФормыЭлементДерева") Тогда
		Возврат СтрокаКоллекции.ПолучитьИдентификатор();
	Иначе//СтрокаТабличнойЧасти, СтрокаТаблицыЗначений, СтрокаДереваЗначений
		Возврат Коллекция.Индекс(СтрокаКоллекции);
	КонецЕсли;
КонецФункции

// Вычисляет элемент коллекции по идентификатору. Если коллекция это таблица значений, то идентификатор - это индекс, для данных формы - поиск по идентификатору
//
// Параметры:
//  Коллекция - ДанныеФормыКоллекция, ДанныеФормыКоллекцияЭлементовДерева, ТаблицаЗначений, КоллекцияСтрокДереваЗначений - 
//	Идентификатор - Число - индекс строки или идентификатор данных формы
//
Функция НайтиПоИдентификатору(Коллекция, Идентификатор) Экспорт
	ТипЗначения = ТипЗнч(Коллекция);
	Если ТипЗначения = Тип("ДанныеФормыКоллекция") ИЛИ ТипЗначения = Тип("ДанныеФормыКоллекцияЭлементовДерева") Тогда
		Возврат Коллекция.НайтиПоИдентификатору(Идентификатор);
	Иначе//СтрокаТабличнойЧасти, СтрокаТаблицыЗначений, СтрокаДереваЗначений
		Возврат Коллекция[Идентификатор];
	КонецЕсли;
КонецФункции

// Одноименная функция СкопироватьКолонки(). При копировании удаляет тип Null
//
// Параметры:
//  Источник - ТаблицаЗначений
//	КолонкиДобавить - Строка, Массив - имена колонок источника, которые нужно добавить
//	КолонкиИсключить - Строка, Массив - имена колонок источника, которые нужно пропустить
//
Функция СкопироватьКолонки(Источник, КолонкиДобавить = "", КолонкиИсключить = "") Экспорт
	Таблица = Новый ТаблицаЗначений;
	Возврат ДобавитьКолонки(Таблица, Источник, КолонкиДобавить, КолонкиИсключить);
КонецФункции

// Добавляет колонки, которых нет в изначальной таблице из источника
//
// Параметры:
//  Таблица - ТаблицаЗначений
//  Источник - ТаблицаЗначений
//	КолонкиДобавить - Строка, Массив - имена колонок источника, которые нужно добавить
//	КолонкиИсключить - Строка, Массив - имена колонок источника, которые нужно пропустить
//
Функция ДобавитьКолонки(Таблица, Источник, КолонкиДобавить = "", КолонкиИсключить = "") Экспорт
	мКолонкиДобавить 	= ОбщийКлиентСервер.Массив(КолонкиДобавить);
	мКолонкиИсключить 	= ОбщийКлиентСервер.Массив(КолонкиИсключить);
	Колонки 			= Таблица.Колонки;
	Для каждого Колонка Из Источник.Колонки Цикл
		ИмяКолонки = Колонка.Имя;
		Если Колонки.Найти(ИмяКолонки) <> Неопределено 
			ИЛИ ЗначениеЗаполнено(КолонкиДобавить) И мКолонкиДобавить.Найти(ИмяКолонки) = Неопределено
			ИЛИ ЗначениеЗаполнено(КолонкиИсключить) И мКолонкиИсключить.Найти(ИмяКолонки) <> Неопределено Тогда
			Продолжить;
		КонецЕсли;
		ОписаниеКолонки = Новый Структура("Имя,ТипЗначения,Ширина,Заголовок");
		ЗаполнитьЗначенияСвойств(ОписаниеКолонки, Колонка);
		ОписаниеКолонки.ТипЗначения = Новый ОписаниеТипов(Колонка.ТипЗначения,, "Null");
		Колонки.Добавить(ОписаниеКолонки.Имя, ОписаниеКолонки.ТипЗначения, ОписаниеКолонки.Заголовок, ОписаниеКолонки.Ширина);
	КонецЦикла;
	Возврат Таблица;
КонецФункции

Процедура СоздатьКолонки(Коллекция, Колонки)
	ТипЗначения = ТипЗнч(Колонки);
	Если ТипЗначения = Тип("Строка") Тогда
		Для каждого Колонка Из ОбщийКлиентСервер.Массив(Колонки) Цикл
			Коллекция.Колонки.Добавить(Колонка);
		КонецЦикла;
	ИначеЕсли ТипЗначения = Тип("Массив") Тогда
		Если Тип(Колонки[0]) = Тип("Структура") Тогда
			Для каждого Колонка Из Колонки Цикл
				Коллекция.Колонки.Добавить(Колонка.Имя, Общий.ТипЗначенияИзСтроки(Колонка.ТипЗначения));
			КонецЦикла;
		Иначе
			Для каждого Колонка Из ОбщийКлиентСервер.Массив(Колонки) Цикл
				Коллекция.Колонки.Добавить(Колонка);
			КонецЦикла;
		КонецЕсли;
	ИначеЕсли ТипЗначения = Тип("Структура") Тогда
		Для каждого Колонка Из Колонки Цикл
			ИмяКолонки 	= Колонка.Ключ;
			Значение 	= Колонка.Значение;
			Если Значение = Неопределено Тогда
				Коллекция.Колонки.Добавить(Колонка.Ключ);
			Иначе
				ТипЗначения = Колонка.Значение;
				Если ТипЗнч(ТипЗначения) = Тип("Строка") Тогда
					ТипЗначения = Общий.ТипЗначенияИзСтроки(ТипЗначения);
				ИначеЕсли ТипЗнч(ТипЗначения) <> Тип("ОписаниеТипов") Тогда
					ТипЗначения = Новый ОписаниеТипов(ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ТипЗнч(ТипЗначения)));
				КонецЕсли;
				Коллекция.Колонки.Добавить(Колонка.Ключ, ТипЗначения);
			КонецЕсли;
		КонецЦикла;
	ИначеЕсли ТипЗнч(Колонки) = Тип("КоллекцияОбъектовМетаданных") Тогда
		Для каждого Колонка Из Колонки Цикл
			Коллекция.Колонки.Добавить(Колонка.Имя, Колонка.Тип);
		КонецЦикла;
	Иначе 
		Для каждого Колонка Из Колонки Цикл
			ТипЗначения = Новый ОписаниеТипов(Колонка.ТипЗначения,, "Null");
			Коллекция.Колонки.Добавить(Колонка.Имя, ТипЗначения);
		КонецЦикла;		
	КонецЕсли; 
КонецПроцедуры

Функция ТаблицаЗначенийВСтруктуру(Таблица, ПривестиСсылкуКСтроке = Ложь) Экспорт
	СтруктураТаблицы = Новый Структура("Тип, Колонки, Строки", "ТаблицаЗначений", Новый Массив, Новый Массив);
	Колонки = СтруктураТаблицы.Колонки;
	Для Каждого Колонка Из Таблица.Колонки Цикл
		Колонки.Добавить(Новый Структура("Имя, ТипЗначения", Колонка.Имя, Общий.СтроковоеПредставлениеТипа(Колонка.ТипЗначения)));
	КонецЦикла;
	Строки = СтруктураТаблицы.Строки;
	Для Каждого Строка Из Таблица Цикл
		Значения = Новый Массив;
		Для Каждого Колонка Из Колонки Цикл
			Значение = Строка[Колонка.Имя];
			ТипЗначения = ТипЗнч(Значение);
			Если ПривестиСсылкуКСтроке И НЕ Общий.ЭтоПростойТип(ТипЗначения) Тогда
				Если ТипЗначения = Тип("УникальныйИдентификатор") Тогда
					Значения.Добавить(Строка(Значение));
				Иначе
					Значения.Добавить(XMLСтрока(Значение));
				КонецЕсли;
			Иначе
				Значения.Добавить(Значение);
			КонецЕсли;
		КонецЦикла;
		Строки.Добавить(Значения);
	КонецЦикла;
	Возврат СтруктураТаблицы;
КонецФункции

Функция СтруктураВТаблицуЗначений(ТаблицаJSON, НайтиСсылкуИзСтроки = Ложь) Экспорт
	ТипСтрока = Тип("Строка");
	Если ТипЗнч(ТаблицаJSON) = ТипСтрока Тогда
		Возврат СтруктураВТаблицуЗначений(ОбщийКлиентСервер.JSONВОбъект(ТаблицаJSON), НайтиСсылкуИзСтроки);
	КонецЕсли;
	Таблица = ТаблицаЗначений(ТаблицаJSON.Колонки);
	Колонки = Таблица.Колонки;
	Для Каждого ДанныеСтроки Из ТаблицаJSON.Строки Цикл
		Строка = Таблица.Добавить();
		Для ИндексКолонки = 0 По ДанныеСтроки.ВГраница() Цикл
			ТипЗначения = Колонки[ИндексКолонки].ТипЗначения;
			Значение = ДанныеСтроки[ИндексКолонки];
			Если ЗначениеЗаполнено(Значение) И ТипЗнч(Значение) = ТипСтрока Тогда
				Если ТипЗначения.СодержитТип(Тип("Дата")) Тогда
					Строка[ИндексКолонки] = ?(ЗначениеЗаполнено(Значение), ПрочитатьДатуJSON(ДанныеСтроки[ИндексКолонки], ФорматДатыJSON.ISO), '00010101');
					Продолжить;
				КонецЕсли;
				Тип = ?(ЗначениеЗаполнено(ТипЗначения.Типы()), ТипЗначения.Типы()[0], Неопределено);
				Если НайтиСсылкуИзСтроки И ЗначениеЗаполнено(Тип) Тогда
					Если ОбщегоНазначения.ЭтоСсылка(Тип) Тогда
						Если Общий.ЭтоТипПеречисления(Тип) Тогда
							ИмяПеречисления = Метаданные.НайтиПоТипу(ТипЗначения.Типы()[0]).Имя;
							Значение = Перечисления[ИмяПеречисления][Значение];
						Иначе
							Значение = ОбщегоНазначения.МенеджерОбъектаПоСсылке(Новый(ТипЗначения.Типы()[0])).ПолучитьСсылку(Новый УникальныйИдентификатор(ДанныеСтроки[ИндексКолонки]));
						КонецЕсли;
					ИначеЕсли Тип = Тип("УникальныйИдентификатор") Тогда
						Значение = Новый УникальныйИдентификатор(Значение);
					КонецЕсли;
				КонецЕсли;
			КонецЕсли;
			Строка[ИндексКолонки] = Значение;
		КонецЦикла;
	КонецЦикла;
	Возврат Таблица;
КонецФункции

Функция ДеревоЗначенийВСтруктуру(Дерево, ПривестиСоставныеТипыКСтроке = Ложь) Экспорт
	СтруктураТаблицы = Новый Структура("Тип, Колонки, Строки", "ДеревоЗначений", Новый Массив, Новый Массив);
	Колонки = СтруктураТаблицы.Колонки;
	Для Каждого Колонка Из Дерево.Колонки Цикл
		Колонки.Добавить(Новый Структура("Имя, ТипЗначения", Колонка.Имя, Общий.СтроковоеПредставлениеТипа(Колонка.ТипЗначения)));
	КонецЦикла;
	ДобавитьСтрокиТаблицы(Колонки, СтруктураТаблицы.Строки, Дерево.Строки, ПривестиСоставныеТипыКСтроке);
	Возврат СтруктураТаблицы;
КонецФункции

Процедура ЗагрузитьСтрокиДерева(Колонки, СтрокиДерева, Строки, НайтиСсылку)
	Для Каждого ЭлементСтроки Из Строки Цикл
		ДанныеСтроки = ЭлементСтроки.Значения;
		Строка = СтрокиДерева.Добавить();
		Для ИндексКолонки = 0 По ДанныеСтроки.ВГраница() Цикл
			ТипЗначения = Колонки[ИндексКолонки].ТипЗначения;
			Значение = ДанныеСтроки[ИндексКолонки];
			Если ЗначениеЗаполнено(Значение) Тогда
				Если ТипЗначения.СодержитТип(Тип("Дата")) Тогда
					Строка[ИндексКолонки] = ?(ЗначениеЗаполнено(Значение), ПрочитатьДатуJSON(ДанныеСтроки[ИндексКолонки], ФорматДатыJSON.ISO), '00010101');
					Продолжить;
				КонецЕсли;
				Если НайтиСсылку И ЗначениеЗаполнено(ТипЗначения.Типы()) И ОбщегоНазначения.ЭтоСсылка(ТипЗначения.Типы()[0]) Тогда
					Значение = ОбщегоНазначения.МенеджерОбъектаПоСсылке(Новый(ТипЗначения.Типы()[0])).ПолучитьСсылку(Новый УникальныйИдентификатор(ДанныеСтроки[ИндексКолонки]));
					Строка[ИндексКолонки] = Значение;
					Продолжить;
				КонецЕсли;
			КонецЕсли;
			Строка[ИндексКолонки] = Значение;
		КонецЦикла;
		ЗагрузитьСтрокиДерева(Колонки, Строка.Строки, ЭлементСтроки.Строки, НайтиСсылку);
	КонецЦикла;
КонецПроцедуры

Функция СтруктураВДеревоЗначений(ДеревоJSON, НайтиСсылку = Ложь) Экспорт
	Если ТипЗнч(ДеревоJSON) = Тип("Строка") Тогда
		Возврат СтруктураВДеревоЗначений(ОбщийКлиентСервер.JSONВОбъект(ДеревоJSON), НайтиСсылку);
	КонецЕсли;
	Дерево = ДеревоЗначений(ДеревоJSON.Колонки);
	Колонки = Дерево.Колонки;
	ЗагрузитьСтрокиДерева(Колонки, Дерево.Строки, ДеревоJSON.Строки, НайтиСсылку);
	Возврат Дерево;
КонецФункции

Процедура ДобавитьСтрокиТаблицы(Колонки, Строки, СтрокиДерева, ПривестиСоставныеТипыКСтроке)
	Для Каждого СтрокаДерева Из СтрокиДерева Цикл
		Значения = Новый Массив;
		Для Каждого Колонка Из Колонки Цикл
			Значение = СтрокаДерева[Колонка.Имя];
			Если ПривестиСоставныеТипыКСтроке И НЕ ОбщегоНазначения.ЭтоСсылка(ТипЗнч(Значение)) Тогда
				Значения.Добавить(XMLСтрока(Значение));
			Иначе
				Значения.Добавить(Значение);
			КонецЕсли;
		КонецЦикла;
		ПодчиненныеСтроки = Новый Массив;
		ДобавитьСтрокиТаблицы(Колонки, ПодчиненныеСтроки, СтрокаДерева.Строки, ПривестиСоставныеТипыКСтроке);
		Строки.Добавить(Новый Структура("Значения, Строки", Значения, ПодчиненныеСтроки));
	КонецЦикла;
КонецПроцедуры

Процедура ЗаполнитьИдентификаторыСтрокДерева(Строки, КолонкаИД, КолонкаИДРодителя, Счетчик)
	Для Каждого Строка Из Строки Цикл
		Счетчик = Счетчик + 1;
		Строка[КолонкаИД] = Счетчик;
		Если Строка.Родитель <> Неопределено Тогда
			Строка[КолонкаИДРодителя] = Строка.Родитель[КолонкаИД];
		КонецЕсли;
		ЗаполнитьИдентификаторыСтрокДерева(Строка.Строки, КолонкаИД, КолонкаИДРодителя, Счетчик);
	КонецЦикла;
КонецПроцедуры
	
Процедура ДобавитьКолонкиИерархии(Дерево, КолонкаИД = "Идентификатор", КолонкаИДРодителя = "ИдентификаторРодителя") Экспорт
	Колонки = Дерево.Колонки;
	Если Колонки.Найти(КолонкаИД) = Неопределено Тогда
		Колонки.Добавить(КолонкаИД, ОбщегоНазначения.ОписаниеТипаЧисло(9));
	КонецЕсли;
	Если Колонки.Найти(КолонкаИДРодителя) = Неопределено Тогда
		Колонки.Добавить(КолонкаИДРодителя, ОбщегоНазначения.ОписаниеТипаЧисло(9));
	КонецЕсли;
	Счетчик = 0;
	ЗаполнитьИдентификаторыСтрокДерева(Дерево.Строки, КолонкаИД, КолонкаИДРодителя, Счетчик);
КонецПроцедуры

Процедура ДобавитьСтрокиДереваВТаблицуЗначений(Таблица, Строки)
	Для Каждого Строка Из Строки Цикл
		ЗаполнитьЗначенияСвойств(Таблица.Добавить(), Строка);
		ДобавитьСтрокиДереваВТаблицуЗначений(Таблица, Строка.Строки);
	КонецЦикла;
КонецПроцедуры

Функция ДеревоВТаблицуЗначений(Дерево) Экспорт
	Таблица = ТаблицаЗначений(Дерево.Колонки);
	ДобавитьСтрокиДереваВТаблицуЗначений(Таблица, Дерево.Строки);
	Возврат Таблица;
КонецФункции

Функция ЭлементСтрокиДерева(КолонкаИД, КолонкаИДРодителя)
	ЭлементСтроки = Новый Структура("Строка, Родитель");
	ЭлементСтроки.Вставить(КолонкаИД);
	ЭлементСтроки.Вставить(КолонкаИДРодителя);
	ЭлементСтроки.Вставить("Строки", Новый Массив);
	Возврат ЭлементСтроки;
КонецФункции

Функция ПолучитьЭлементСтрокиДерева(СловарьСтрок, СловарьЭлементовСтрок, Строка, КолонкаИД, КолонкаИДРодителя)
	ИД = Строка[КолонкаИД];
	ЭлементСтрокиДерева = СловарьЭлементовСтрок[ИД];
	Если ЗначениеЗаполнено(ЭлементСтрокиДерева) Тогда
		Возврат ЭлементСтрокиДерева;
	КонецЕсли;
	СтрокаДерева = ЭлементСтрокиДерева(КолонкаИД, КолонкаИДРодителя);
	СтрокаДерева.Строка = Строка;
	СловарьЭлементовСтрок[ИД] = СтрокаДерева;
	ИДРодителя = Строка[КолонкаИДРодителя];
	Если ЗначениеЗаполнено(ИДРодителя) Тогда
		ЭлементРодителя = ПолучитьЭлементСтрокиДерева(СловарьСтрок, СловарьЭлементовСтрок, СловарьСтрок[ИДРодителя], КолонкаИД, КолонкаИДРодителя);
		ЭлементРодителя.Строки.Добавить(СтрокаДерева);
		СтрокаДерева.Родитель = ЭлементРодителя;
	КонецЕсли;
	Возврат СтрокаДерева;
КонецФункции

Процедура ДобавитьЭлементыСтрокДерева(Строки, ЭлементыСтрокДереваВерхнегоУровня)
	Для Каждого ЭлементСтрокиДерева Из ЭлементыСтрокДереваВерхнегоУровня Цикл
		Строка = Строки.Добавить();
		ЗаполнитьЗначенияСвойств(Строка, ЭлементСтрокиДерева.Строка);
		ДобавитьЭлементыСтрокДерева(Строка.Строки, ЭлементСтрокиДерева.Строки);
	КонецЦикла;
КонецПроцедуры

Функция ТаблицаВДеревоЗначений(Таблица, КолонкаИД = "Идентификатор", КолонкаИДРодителя = "ИдентификаторРодителя") Экспорт
	Дерево = ДеревоЗначений(Таблица.Колонки);
	//  Подготовка словаря
	СловарьСтрок = Новый Соответствие;
	Для Каждого Строка Из Таблица Цикл
		СловарьСтрок[Строка[КолонкаИД]] = Строка;
	КонецЦикла;
	//  Создание иерархической структуры строк
	ЭлементыСтрокДереваВерхнегоУровня = Новый Массив;
	СловарьЭлементовСтрок = Новый Соответствие;
	Для Каждого Строка Из Таблица Цикл
		ЭлементСтрокиДерева = ПолучитьЭлементСтрокиДерева(СловарьСтрок, СловарьЭлементовСтрок, Строка, КолонкаИД, КолонкаИДРодителя);
		Если ЭлементСтрокиДерева.Родитель = Неопределено Тогда
			ЭлементыСтрокДереваВерхнегоУровня.Добавить(ЭлементСтрокиДерева);
		КонецЕсли;
	КонецЦикла;
	//  Создание дерева по иерархической структуре строк
	ДобавитьЭлементыСтрокДерева(Дерево.Строки, ЭлементыСтрокДереваВерхнегоУровня);
	Возврат Дерево;
КонецФункции

Функция ТаблицаКлючей(ТаблицаИсточника, ПоляКлюча) Экспорт
	Ключи = ТаблицаЗначений(ПоляКлюча);
	Для Каждого Ключ Из ТаблицаИсточника Цикл
		ЗаполнитьЗначенияСвойств(Ключи.Добавить(), Ключ);
	КонецЦикла;
	Ключи.Свернуть(ПоляКлюча);
	Ключи.Сортировать(ПоляКлюча, Новый СравнениеЗначений);
	Возврат Ключи;
КонецФункции

//  Добавляет к таблице приемнику строки таблицы источника. Результат сворачивается в разрезе полей приемника по полю ресурса
Процедура ДобавитьТаблицу(ТаблицаПриемник, ТаблицаИсточник, ПоляКлюча, ПоляРесурсов, Знак = "") Экспорт
	Если Знак = "-" Тогда
		Для Каждого СтрокаИсточника Из ТаблицаИсточник Цикл
			НоваяСтрока = ТаблицаПриемник.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаИсточника);
			ОбщийКлиентСервер.ИнвертироватьЗнак(НоваяСтрока, ПоляРесурсов);
		КонецЦикла;
	Иначе
		Для Каждого СтрокаИсточника Из ТаблицаИсточник Цикл
			ЗаполнитьЗначенияСвойств(ТаблицаПриемник.Добавить(), СтрокаИсточника);
		КонецЦикла;
	КонецЕсли;
	ТаблицаПриемник.Свернуть(ПоляКлюча, ПоляРесурсов);
КонецПроцедуры

Функция ПеречислениеВТаблицуЗначений(ИмяПеречисления) Экспорт
	_Перечисление = Перечисления[ИмяПеречисления];
	_Метаданные =  Метаданные.Перечисления[ИмяПеречисления];
	Таблица = РаботаСКоллекцией.ТаблицаЗначений(Новый Структура("Ссылка, Имя, Синоним", 
			Новый ОписаниеТипов("ПеречислениеСсылка." + ИмяПеречисления), 
			ОбщегоНазначения.ОписаниеТипаСтрока(50),
			ОбщегоНазначения.ОписаниеТипаСтрока(50)
		)
	);
	Для Каждого ЭлементЗначения Из _Метаданные.ЗначенияПеречисления Цикл
		Строка = Таблица.Добавить();
		Строка.Ссылка = _Перечисление[ЭлементЗначения.Имя];
		Строка.Имя = ЭлементЗначения.Имя;
		Строка.Синоним = ЭлементЗначения.Синоним;
	КонецЦикла;
	Возврат Таблица;
КонецФункции

Процедура СкопироватьКолонкуРекурсивно(Дерево, КолонкаИсточник, КолонкаПолучатель) Экспорт
	Строки = Дерево.Строки;
	Строки.ЗагрузитьКолонку(Строки.ВыгрузитьКолонку(КолонкаИсточник), КолонкаПолучатель);
	Для Каждого Строка Из Строки Цикл
		СкопироватьКолонкуРекурсивно(Строка, КолонкаИсточник, КолонкаПолучатель)
	КонецЦикла;
КонецПроцедуры

Функция КоллекцияЗначенийВСтруктуру(КоллекцияЗначений, ПривестиСоставныеТипыКСтроке = Ложь) Экспорт
	Если ТипЗнч(КоллекцияЗначений) = Тип("ДеревоЗначений") Тогда
		Возврат ДеревоЗначенийВСтруктуру(КоллекцияЗначений, ПривестиСоставныеТипыКСтроке);
	ИначеЕсли ТипЗнч(КоллекцияЗначений) = Тип("ТаблицаЗначений") Тогда
		Возврат ТаблицаЗначенийВСтруктуру(КоллекцияЗначений, ПривестиСоставныеТипыКСтроке);
	Иначе
		ВызватьИсключение "Неизвестный тип коллекции " + ТипЗнч(КоллекцияЗначений);
	КонецЕсли;
КонецФункции

Функция ВывестиВТабличныйДокумент(Коллекция, ТабличныйДокумент = Неопределено) Экспорт
	Если ТабличныйДокумент = Неопределено Тогда
		ТабличныйДокумент = Новый ТабличныйДокумент;
	КонецЕсли;
	МодельСхемыКомпоновки = Общий.МодельСхемыКомпоновкиДанных(Коллекция);
	////////////////////////////////////////////////////////////////////////////////
	//  Настройка компоновки
	МодельНастройкиКомпоновки = Общий.МодельНастройкиКомпоновкиДанных(МодельСхемыКомпоновки.НастройкиПоУмолчанию())
	;
	Для Каждого Колонка Из Коллекция.Колонки Цикл
		МодельНастройкиКомпоновки
			.Поле(Колонка.Имя)
		;	
	КонецЦикла;
	//  Описание структуры
	МодельНастройкиКомпоновки
		.Структура()
			.ГруппировкаНачать()
				.ПолеГруппировки("*")
				.Поле("*")
			.ГруппировкаЗавершить()
	;
	//  Компоновка
	МодельМакетаКомпоновки = Общий.МодельМакетаКомпоновкиДанных()
		.Схема(МодельСхемыКомпоновки.СхемаКомпоновкиДанных)
		.Настройки(МодельНастройкиКомпоновки.Настройки)
		.Скомпоновать()
		.ВнешниеНаборыДанных(МодельСхемыКомпоновки.ВнешниеНаборыДанных)
	;
	//  Вывод
	Возврат МодельМакетаКомпоновки.Вывести(ТабличныйДокумент);
КонецФункции

Функция ВJSON(Коллекция) Экспорт
	ТипЗначения = ТипЗнч(Коллекция);
	Если ТипЗначения = Тип("ТаблицаЗначений") Тогда
		Возврат ОбщийКлиентСервер.ОбъектВJSON(ТаблицаЗначенийВСтруктуру(Коллекция));
	ИначеЕсли ТипЗначения = Тип("ДеревоЗначений") Тогда
		Возврат ОбщийКлиентСервер.ОбъектВJSON(ДеревоЗначенийВСтруктуру(Коллекция));
	ИначеЕсли ТипЗначения = Тип("Структура") И Коллекция.Свойство("Тип") Тогда
		Возврат ОбщийКлиентСервер.ОбъектВJSON(Коллекция);
	Иначе
		ВызватьИсключение "Неизвестный тип коллекции " + ТипЗначения;
	КонецЕсли;
КонецФункции

Функция ИзJSON(КоллекцияJSON) Экспорт
	Перем ТипЗначения;
	Коллекция = ОбщийКлиентСервер.JSONВОбъект(КоллекцияJSON);
	Коллекция.Свойство("Тип", ТипЗначения);
	Если НЕ ЗначениеЗаполнено(ТипЗначения) ИЛИ ТипЗначения = "ТаблицаЗначений" Тогда
		Возврат СтруктураВТаблицуЗначений(Коллекция);
	ИначеЕсли ТипЗначения = "ДеревоЗначений" Тогда
		Возврат СтруктураВДеревоЗначений(Коллекция);
	Иначе
		ВызватьИсключение "Неизвестный тип коллекции " + ТипЗначения;
	КонецЕсли;
КонецФункции

Функция ВCSV(Таблица, Знач Разделитель = "Таб") Экспорт
	Строки = Новый Массив;
	Разделитель = Символы[Разделитель];
	Колонки = Новый Массив;
	Для Каждого Колонка Из Таблица.Колонки Цикл
		Колонки.Добавить(Колонка.Имя);
	КонецЦикла;
	Строки.Добавить(СтрСоединить(Колонки, Разделитель));
	Значения = Новый Массив;
	Для Каждого СтрокаТаблицы Из Таблица Цикл
		Для Каждого ИмяКолонки Из Колонки Цикл
			Значение = СтрокаТаблицы[ИмяКолонки];
			ТипЗначения = ТипЗнч(Значение);
			Если ТипЗначения = Тип("Строка") Тогда
				Значения.Добавить("""" + Значение + """");
			Иначе
				Значения.Добавить(Строка(Значение));
			КонецЕсли;
		КонецЦикла;
		Строки.Добавить(СтрСоединить(Значения, Разделитель));
	КонецЦикла;
КонецФункции

Функция CSVвСтруктуру(Текст, Знач Разделитель = "Таб") Экспорт
	Разделитель = Символы[Разделитель];
	СтруктураТаблицы = Новый Структура("Тип, Колонки, Строки", "ТаблицаЗначений", Новый Массив, Новый Массив);
	Строки = СтрРазделить(Текст, Символы.ПС);
	Шапка = РаботаСМассивом.Сдвинуть(Строки);
	СтруктураТаблицы.Колонки = РаботаСМассивом.АТДМассив(СтрРазделить(Шапка, Разделитель))
		.Отобразить("СтрРазделить(Элемент, ': ', Ложь)")
		.Отобразить("Структура('Имя, ТипЗначения', Элемент[0], ?(Элемент.Количество() = 2, Элемент[1], Неопределено))")
	;
	СтруктураТаблицы.Строки = РаботаСМассивом.Отобразить(Строки, "СтрРазделить(Элемент, Контекст)", Разделитель);
	Возврат СтруктураТаблицы;
КонецФункции

Функция MarkdownВСтруктуру(Текст) Экспорт
	Строки = СтрРазделить(Текст, Символы.ПС);
	Колонки = РаботаСМассивом.АТДМассив(СтрРазделить(Строки[0], "| ", Ложь))
		.Отобразить("СтрРазделить(Элемент, ': ', Ложь)")
		.Отобразить("Структура('Имя, ТипЗначения', Элемент[0], ?(Элемент.Количество() = 2, Элемент[1], Неопределено))")
	;
КонецФункции

Функция ВMarkdown(Коллекция) Экспорт
	Если ТипЗнч(Коллекция) = Тип("ТаблицаЗначений") Тогда
		Возврат ВMarkdown(ТаблицаЗначенийВСтруктуру(Коллекция));
	КонецЕсли;
	Колонки = РаботаСМассивом.Отобразить(Коллекция.Колонки, "СтрШаблон(Элемент.Имя, Элемент)");
	Строки = Новый Массив;
	Строки.Добавить("|" + СтрСоединить(Колонки, "|") + "|");
	Строки.Добавить(СтроковыеФункцииКлиентСервер.СформироватьСтрокуСимволов("|-", Колонки.Количество()) + "|");
	Для Каждого Значения Из Коллекция.Строки Цикл
		Строки.Добавить("|" + СтрСоединить(Значения, "|") + "|");
	КонецЦикла;
	Возврат СтрСоединить(Строки, Символы.ПС);
КонецФункции

Процедура ДополнитьТаблицу(ТаблицаПриемник, ТаблицаИсточник) Экспорт
	Для Каждого СтрокаИсточника Из ТаблицаИсточник Цикл
		ЗаполнитьЗначенияСвойств(ТаблицаПриемник.Добавить(), СтрокаИсточника);
	КонецЦикла;
КонецПроцедуры

