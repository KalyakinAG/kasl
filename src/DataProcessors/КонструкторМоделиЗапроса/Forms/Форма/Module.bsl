&НаСервере
Перем Метки;

&НаСервере
Перем МодельТекста;

&НаКлиенте
Процедура КомандаПолучитьТекстМодели(Команда)
	КомандаПолучитьТекстМоделиНаСервере();
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция Псевдоним(ПутьКДанным) 
	Возврат СтрЗаменить(ОбщийКлиентСервер.НачалоСтрокиПослеРазделителя(ПутьКДанным, "."), ".", "");
КонецФункции

&НаСервере
Процедура ДобавитьТекстПоля(ЗапросПакета, Выражение)
	
	Колонка = ЗапросПакета.Колонки.Найти(Выражение);
	Поле = Строка(Выражение);
	
	АгрегатнаяФункция = "";
	Если СтрНачинаетсяС(Поле, "СУММА(") Тогда
		АгрегатнаяФункция = "Сумма";
		ЧислоСимволов = 6;
		Поле = Сред(Поле, ЧислоСимволов + 1, СтрДлина(Поле) - ЧислоСимволов - 1);
	ИначеЕсли СтрНачинаетсяС(Поле, "КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ") Тогда
		АгрегатнаяФункция = "КоличествоРазличных";
		ЧислоСимволов = 21;
		Поле = Сред(Поле, ЧислоСимволов + 1, СтрДлина(Поле) - ЧислоСимволов - 1);
	ИначеЕсли СтрНачинаетсяС(Поле, "КОЛИЧЕСТВО(") Тогда
		АгрегатнаяФункция = "Количество";
		ЧислоСимволов = 11;
		Поле = Сред(Поле, ЧислоСимволов + 1, СтрДлина(Поле) - ЧислоСимволов - 1);
	ИначеЕсли СтрНачинаетсяС(Поле, "СРЕДНЕЕ(") Тогда
		АгрегатнаяФункция = "Среднее";
		ЧислоСимволов = 8;
		Поле = Сред(Поле, ЧислоСимволов + 1, СтрДлина(Поле) - ЧислоСимволов - 1);
	ИначеЕсли СтрНачинаетсяС(Поле, "МАКСИМУМ(") Тогда
		АгрегатнаяФункция = "Максимум";
		ЧислоСимволов = 9;
		Поле = Сред(Поле, ЧислоСимволов + 1, СтрДлина(Поле) - ЧислоСимволов - 1);
	ИначеЕсли СтрНачинаетсяС(Поле, "МИНИМУМ(") Тогда
		АгрегатнаяФункция = "Минимум";
		ЧислоСимволов = 8;
		Поле = Сред(Поле, ЧислоСимволов + 1, СтрДлина(Поле) - ЧислоСимволов - 1);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(АгрегатнаяФункция) Тогда
		Псевдоним = Псевдоним(Поле);
		Если Колонка.Поля.Количество() = 1 И Псевдоним = Колонка.Псевдоним Тогда
			МодельТекста
				.Добавить(".{1}(""{2}"")", АгрегатнаяФункция, Поле)
			;
			Возврат;
		КонецЕсли;
		МодельТекста
			.Добавить(".{1}(""{2}"", ""{3}"")", АгрегатнаяФункция, ОбщийКлиентСервер.ЭкранироватьТекст(Поле), Колонка.Псевдоним)
		;
		Возврат;
	КонецЕсли;
	
	Если СтрНачинаетсяС(Поле, "ЕСТЬNULL(") Тогда
		ЧислоСимволов = 9;
		Поле = Сред(Поле, ЧислоСимволов + 1, СтрДлина(Поле) - ЧислоСимволов - 1);
		ПозицияРазделителя = СтрНайти(Поле, ",", НаправлениеПоиска.СКонца);
		ПолеЕстьNull = СокрЛ(Прав(Поле, СтрДлина(Поле) - ПозицияРазделителя));
		Поле = Лев(Поле, ПозицияРазделителя - 1);
		Псевдоним = Псевдоним(Поле);
		Если Колонка.Поля.Количество() = 1 И Псевдоним = Колонка.Псевдоним Тогда
			МодельТекста
				.Добавить(".Поле(""{1}"", , ""{2}"")", Поле, ПолеЕстьNull)
			;
			Возврат;
		КонецЕсли;
		МодельТекста
			.Добавить(".Поле(""{1}"", ""{2}"", ""{3}"")", ОбщийКлиентСервер.ЭкранироватьТекст(Поле), Колонка.Псевдоним, ОбщийКлиентСервер.ЭкранироватьТекст(ПолеЕстьNull))
		;
		Возврат;
	КонецЕсли;
	
	Псевдоним = Псевдоним(Строка(Выражение));
	Если Колонка.Поля.Количество() = 1 И Псевдоним = Колонка.Псевдоним Тогда
		МодельТекста
			.Добавить(".Поле(""{1}"")", Выражение)
		;
		Возврат;
	КонецЕсли;

	МодельТекста	
		.Добавить(".Поле(""{1}"", ""{2}"")", ОбщийКлиентСервер.ЭкранироватьТекст(Выражение), Колонка.Псевдоним)
	;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьТекстЗапроса()
	
	МодельЗапроса = Общий.МодельЗапроса();
	УстановитьБезопасныйРежим(Истина);
	Выполнить(Объект.ТекстМодели.ПолучитьТекст());
	Возврат МодельЗапроса.ПолучитьТекстЗапроса();
	
КонецФункции

&НаКлиенте
Процедура КомандаПолучитьТекстЗапроса(Команда)
	
	Текст = Новый ТекстовыйДокумент;
	Текст.УстановитьТекст(ПолучитьТекстЗапроса());
	Текст.Показать("Текст запроса из модели");
	
КонецПроцедуры

&НаСервере
Функция ПривестиСтроку(Строка, ОчиститьВызов = Истина, ОчиститьОкончание = Истина)
	
	Результат = Строка;
	Если ОчиститьВызов Тогда
		Результат = СтрЗаменить(Результат, "МодельЗапроса", "");
	КонецЕсли;
			
	Если ОчиститьОкончание Тогда
		Результат = СтрЗаменить(Результат, ";", "");
	КонецЕсли;
			
	Возврат Результат;
	
КонецФункции

&НаСервере
Процедура ДобавитьТекстОператора(ЗапросПакета, ОператорВыбрать, ЭтоПервыйОператор)
	Перем Значение;
	
	Если ЭтоПервыйОператор Тогда
		ИмяМетода = "Выбрать";
	ИначеЕсли ОператорВыбрать.ТипОбъединения = ТипОбъединенияСхемыЗапроса.ОбъединитьВсе Тогда
		ИмяМетода = "ОбъединитьВсе";
	Иначе
		ИмяМетода = "Объединить";
	КонецЕсли;
	
	Если ОператорВыбрать.КоличествоПолучаемыхЗаписей = Неопределено Тогда
		ВыбратьПервые = "";
	Иначе
		ВыбратьПервые = Формат(ОператорВыбрать.КоличествоПолучаемыхЗаписей, "ЧГ=;");
	КонецЕсли;
	
	Если ОператорВыбрать.ВыбиратьРазличные Тогда
		МодельТекста
			.Добавить(".{1}({2}, Истина)", ИмяМетода, ВыбратьПервые)
		;
	Иначе
		МодельТекста
			.Добавить(".{1}({2})", ИмяМетода, ВыбратьПервые)
		;
	КонецЕсли;

	МодельТекста
		.ГруппировкаНачать()
	;

	Для Каждого Источник Из ОператорВыбрать.Источники Цикл
		ТипИсточника = ТипЗнч(Источник.Источник);
		
		Если ТипИсточника = Тип("ВложенныйЗапросСхемыЗапроса") Тогда
			ВложенныйЗапрос = Источник.Источник.Запрос;
			МодельТекста
				.Добавить(".ИсточникНачать(""{1}"")", Источник.Источник.Псевдоним)
			;
			ЭтоПервыйОператорВложенногоЗапроса = Истина;
			
			Для Каждого ВложенныйЗапросОператорВыбрать Из ВложенныйЗапрос.Операторы Цикл
				МодельТекста
					.ГруппировкаНачать()
				;
				ДобавитьТекстОператора(ВложенныйЗапрос, ВложенныйЗапросОператорВыбрать, ЭтоПервыйОператорВложенногоЗапроса);
				ЭтоПервыйОператорВложенногоЗапроса = Ложь;						
				МодельТекста
					.ГруппировкаЗавершить()
				;
			КонецЦикла;
			
			МодельТекста
				.Добавить(".ИсточникЗавершить()")
			;
			Продолжить;
		КонецЕсли;
		
		ИмяТаблицы = Источник.Источник.ИмяТаблицы;
		Псевдоним = Источник.Источник.Псевдоним;
		
		Если ТипИсточника = Тип("ОписаниеВременнойТаблицыСхемыЗапроса") Тогда
			МодельТекста
				.Добавить(".Источник(""{1}"", ""{2}"")", ИмяТаблицы, Псевдоним)
			;
			Продолжить;
		КонецЕсли;
							
		СтруктураПараметров = РаботаСоСхемойЗапроса.ПараметрыВиртуальнойТаблицы(ИмяТаблицы, Источник.Источник.Параметры);
		
		Если СтруктураПараметров = Неопределено Тогда
			Если Псевдоним = ОбщийКлиентСервер.ОкончаниеСтрокиПослеРазделителя(ИмяТаблицы) Тогда
				МодельТекста
					.Добавить(".Источник(""{1}"")", ИмяТаблицы)
				;					
			Иначе
				МодельТекста
					.Добавить(".Источник(""{1}"", ""{2}"")", ИмяТаблицы, Псевдоним)
				;					
			КонецЕсли;
		Иначе
			СловарьМетодов = РаботаСМножеством.Дополнить(, ОбщийКлиентСервер.Массив("НачалоПериода,КонецПериода,Период,Периодичность,Условие"));
			СловарьПараметров = РаботаСМножеством.Дополнить(, РаботаСМассивом.Отобразить(СтруктураПараметров, "Элемент.Ключ"));
			СловарьПараметровПоМетодам = РаботаСМножеством.Пересечение(СловарьМетодов, СловарьПараметров);
			СловарьПрочихПараметров = РаботаСМножеством.Разность(СловарьПараметров, СловарьПараметровПоМетодам);
			
			МодельТекста
				.Добавить(".Источник")
				.Присоединить("(")
				.Присоединить("""{1}""", ИмяТаблицы)
			;
			
			Если Псевдоним = ОбщийКлиентСервер.ОкончаниеСтрокиПослеРазделителя(ИмяТаблицы) Тогда
				Если РаботаСМножеством.Пустое(СловарьПрочихПараметров) Тогда
					МодельТекста
						.Присоединить(")")
					;
				Иначе
					МодельТекста
						.Присоединить(", Новый Структура(""{1}"", ""{2}"")", 
							СтрСоединить(РаботаСМассивом.Отобразить(СловарьПрочихПараметров.Словарь, "Элемент.Ключ"), ", "),
							СтрСоединить(РаботаСМассивом.Отобразить(СловарьПрочихПараметров.Словарь, "Параметры[Элемент.Ключ]", , СтруктураПараметров), """, """)
						)
						.Присоединить(")")
					;
				КонецЕсли;
			Иначе
				Если РаботаСМножеством.Пустое(СловарьПрочихПараметров) Тогда
					МодельТекста
						.Присоединить(", ""{1}""", Псевдоним)
						.Присоединить(")")
					;
				Иначе
					МодельТекста
						.Присоединить(", ""{1}""", Псевдоним)
						.Присоединить(", Новый Структура(""{1}"", ""{2}"")", 
							СтрСоединить(РаботаСМассивом.Отобразить(СловарьПрочихПараметров.Словарь, "Элемент.Ключ"), ", "),
							СтрСоединить(РаботаСМассивом.Отобразить(СловарьПрочихПараметров.Словарь, "Параметры[Элемент.Ключ]", , СтруктураПараметров), """, """)
						)
						.Присоединить(")")
					;
				КонецЕсли;
			КонецЕсли;
			
			Если НЕ РаботаСМножеством.Пустое(СловарьПараметровПоМетодам) Тогда
				МодельТекста
					.ГруппировкаНачать()
				;
				Для Каждого Элемент Из СловарьПараметровПоМетодам.Словарь Цикл
					Если Элемент.Ключ = "Периодичность" Тогда
						МодельТекста
							.Добавить(".{1}{2}()", Элемент.Ключ, СтруктураПараметров[Элемент.Ключ])
						;
					Иначе
						МодельТекста
							.Добавить(".{1}(""{2}"")", Элемент.Ключ, СтруктураПараметров[Элемент.Ключ])
						;
					КонецЕсли;
				КонецЦикла;
				МодельТекста
					.ГруппировкаЗавершить()
				;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	//  Группировка условий соединения по ключу: ПсевдонимСлева, ПсевдонимСправа, ТипСоединения
	СловарьСоединений = РаботаСМножеством.Множество("Ключ");
	Для Каждого Источник Из ОператорВыбрать.Источники Цикл
		ИсточникСлева = Источник.Источник;
		ПсевдонимСлева = ИсточникСлева.Псевдоним;
		
		Для Каждого Соединение Из Источник.Соединения Цикл
			ИсточникСправа = Соединение.Источник.Источник;
			ПсевдонимСправа = ИсточникСправа.Псевдоним;
			ТипСоединения = СтрЗаменить(Соединение.ТипСоединения, " внешнее", "");
			Условие = Соединение.Условие;
			Ключ = СтрШаблон("%1%2%3", ПсевдонимСлева, ПсевдонимСправа, ТипСоединения);
			Если РаботаСМножеством.Содержит(СловарьСоединений, Новый Структура("Ключ", Ключ), Значение) Тогда
				РаботаСМассивом.Дополнить(Значение.Условия, СтрРазделить(СтрЗаменить(Соединение.Условие, " И ", ","), ","));
				Продолжить;
			КонецЕсли;								
			ОписаниеСоединения = Новый Структура;
			ОписаниеСоединения.Вставить("Ключ", Ключ);
			ОписаниеСоединения.Вставить("ИсточникСлева", ИсточникСлева);
			ОписаниеСоединения.Вставить("ПсевдонимСлева", ПсевдонимСлева);
			ОписаниеСоединения.Вставить("ИсточникСправа", ИсточникСправа);
			ОписаниеСоединения.Вставить("ПсевдонимСправа", ПсевдонимСправа);
			ОписаниеСоединения.Вставить("ТипСоединения", ТипСоединения);
			ОписаниеСоединения.Вставить("Условия", СтрРазделить(СтрЗаменить(Соединение.Условие, " И ", ","), ","));
			РаботаСМножеством.Добавить(СловарьСоединений, ОписаниеСоединения);
		КонецЦикла;
		
	КонецЦикла;
	
	//  Добавление соединений в текст
	Для Каждого ОписаниеСоединения Из РаботаСМножеством.Массив(СловарьСоединений) Цикл
		ИсточникСлева = ОписаниеСоединения.ИсточникСлева;
		ИсточникСправа = ОписаниеСоединения.ИсточникСправа;
		ТипСоединения = ОписаниеСоединения.ТипСоединения;
		
		ВыраженияУсловийГруппыИ = Новый Массив;
		
		Для Каждого Выражение Из ОписаниеСоединения.Условия Цикл

			Состав = СтрРазделить(Выражение, "=");
			
			Если Состав.Количество() <> 2 Тогда
				ВыраженияУсловийГруппыИ.Добавить(Новый Структура("Выражение, ЭтоСвязь", Выражение, Ложь));
				Продолжить;
			КонецЕсли;
			
			ПолеСлева = СтрЗаменить(СокрЛП(Состав[0]), ИсточникСлева.Псевдоним + ".", "");
			ПолеСправа = СтрЗаменить(СокрЛП(Состав[1]), ИсточникСправа.Псевдоним + ".", "");
			
			Если ИсточникСлева.ДоступныеПоля.Найти(ПолеСлева) = Неопределено Тогда
				ВыраженияУсловийГруппыИ.Добавить(Новый Структура("Выражение, ЭтоСвязь", Выражение, Ложь));
				Продолжить;
			КонецЕсли;
			
			Если ИсточникСправа.ДоступныеПоля.Найти(ПолеСправа) = Неопределено Тогда
				ВыраженияУсловийГруппыИ.Добавить(Новый Структура("Выражение, ЭтоСвязь", Выражение, Ложь));
				Продолжить;
			КонецЕсли;
			
			Если ПолеСлева = ПолеСправа Тогда
				ВыраженияУсловийГруппыИ.Добавить(Новый Структура("Выражение, ЭтоСвязь", ПолеСлева, Истина));
				Продолжить;
			КонецЕсли;
			
			ВыраженияУсловийГруппыИ.Добавить(Новый Структура("Выражение, ЭтоСвязь", СтрШаблон("%1 = %2", ПолеСлева, ПолеСправа), Истина));
			
		КонецЦикла;
		
		МодельТекста
			.Добавить(".{1}Соединение(""{2}"", ""{3}"")", ТипСоединения, ИсточникСлева.Псевдоним, ИсточникСправа.Псевдоним)
			.ГруппировкаНачать()
		;
		
		Связи = РаботаСМассивом.Отобрать(ВыраженияУсловийГруппыИ, "Элемент.ЭтоСвязь");
		
		Если ЗначениеЗаполнено(Связи) Тогда
			МодельТекста
				.Добавить(".Связь(""{1}"")", СтрСоединить(РаботаСМассивом.Отобразить(Связи, "Элемент.Выражение"), ", "))
			;
		КонецЕсли;
		
		Условия = РаботаСМассивом.Отобрать(ВыраженияУсловийГруппыИ, "НЕ Элемент.ЭтоСвязь");
		
		Если ЗначениеЗаполнено(Условия) Тогда
			МодельТекста
				.Добавить(".УсловиеСвязи(""{1}"")", СтрСоединить(РаботаСМассивом.Отобразить(Условия, "Элемент.Выражение"), ", "))
			;
		КонецЕсли;

		МодельТекста
			.ГруппировкаЗавершить()
		;			
	КонецЦикла;
			
	Для Каждого Выражение Из ОператорВыбрать.Отбор Цикл
		МодельТекста
			.Добавить(".Отбор(""{1}"")", ОбщийКлиентСервер.ЭкранироватьТекст(Выражение))
		;
	КонецЦикла;
	
	Для Каждого ВыбранноеПоле Из ОператорВыбрать.ВыбираемыеПоля Цикл
		ДобавитьТекстПоля(ЗапросПакета, ВыбранноеПоле);
	КонецЦикла;
	
	МодельТекста
		.ГруппировкаЗавершить()
	;
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьТекстПорядка(ВыражениеПорядка)
	
	Элемент = ВыражениеПорядка.Элемент;
	Если ТипЗнч(Элемент) = Тип("ВыражениеСхемыЗапроса") Тогда
		Псевдоним = Строка(Элемент);
	Иначе
		Псевдоним = ВыражениеПорядка.Элемент.Псевдоним;//Тип("КолонкаСхемыЗапроса")
	КонецЕсли;
	
	Если ВыражениеПорядка.Направление = НаправлениеПорядкаСхемыЗапроса.ПоВозрастанию Тогда
		МодельТекста
			.Добавить(".Порядок(""{1}"")", Псевдоним)
		;
	Иначе
		МодельТекста
			.Добавить(".Порядок(""{1}"", НаправлениеПорядкаСхемыЗапроса.{2})", Псевдоним, ОбщийКлиентСервер.CamelCase(Строка(ВыражениеПорядка.Направление)))
		;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьТекстЗапроса(ЗапросПакета)
	
	Если ТипЗнч(ЗапросПакета) = Тип("ЗапросУничтоженияТаблицыСхемыЗапроса") Тогда
		МодельТекста
			.Добавить(";//  ЗАПРОС УНИЧТОЖЕНИЯ. {1}", ЗапросПакета.ИмяТаблицы)
			.Добавить("МодельЗапроса.Уничтожить(""{1}"")", ЗапросПакета.ИмяТаблицы)
		;
		Возврат;
	КонецЕсли;
				
	//  Общее
	МодельТекста
		.Добавить(";//  ЗАПРОС ПАКЕТА. ")
	;
	Если ЗначениеЗаполнено(ЗапросПакета.ТаблицаДляПомещения) Тогда
		ИмяЗапроса = ЗапросПакета.ТаблицаДляПомещения;
		Метки.Добавить(ИмяЗапроса);
		МодельТекста
			.Присоединить(ИмяЗапроса)
			.Добавить("МодельЗапроса.ЗапросПакета()")
			.Присоединить(".Поместить(""{1}"")", ЗапросПакета.ТаблицаДляПомещения)
		;
	ИначеЕсли ЗначениеЗаполнено(ЗапросПакета.ТаблицаДляДобавления) Тогда
		ИмяЗапроса = ЗапросПакета.ТаблицаДляДобавления;
		Метки.Добавить(ИмяЗапроса);
		МодельТекста
			.Присоединить(ИмяЗапроса)
			.Добавить("МодельЗапроса.ЗапросПакета()")
			.Присоединить(".Добавить(""{1}"")", ЗапросПакета.ТаблицаДляДобавления)
		;
	ИначеЕсли ЗапросПакета.Операторы.Количество() = 1 И ЗапросПакета.Операторы[0].Источники.Количество() = 1 Тогда
		ИмяЗапроса = ЗапросПакета.Операторы[0].Источники[0].Источник.Псевдоним;
		Метки.Добавить(ИмяЗапроса);
		МодельТекста
			.Присоединить(ИмяЗапроса)
			.Добавить("МодельЗапроса.ЗапросПакета(""{1}"")", ИмяЗапроса)
		;
	Иначе
		МодельТекста
			.Добавить("МодельЗапроса.ЗапросПакета()")
		;
	КонецЕсли;
	
	Если ЗапросПакета.ВыбиратьРазрешенные Тогда
		МодельТекста
			.Присоединить(".Разрешенные()")
		;
	КонецЕсли;

	МодельТекста
		.ГруппировкаНачать()
	;
	ЭтоПервыйОператор = Истина;
	Для Каждого ОператорВыбрать Из ЗапросПакета.Операторы Цикл
		ДобавитьТекстОператора(ЗапросПакета, ОператорВыбрать, ЭтоПервыйОператор);
	КонецЦикла;
	МодельТекста
		.ГруппировкаЗавершить()
	;
	
	//  Порядок
	Для Каждого ВыражениеПорядка Из ЗапросПакета.Порядок Цикл
		ДобавитьТекстПорядка(ВыражениеПорядка);
	КонецЦикла;
	
	Если ЗапросПакета.Автопорядок Тогда
		МодельТекста
			.Добавить(".Автопорядок()")
		;
	КонецЕсли;
	
	//  Итоги
	Для Каждого КонтрольнаяТочкаИтогов Из ЗапросПакета.КонтрольныеТочкиИтогов Цикл
		
		Если ТипЗнч(КонтрольнаяТочкаИтогов.Выражение) = Тип("ВыражениеСхемыЗапроса") Тогда
			Выражение = КонтрольнаяТочкаИтогов.Выражение;
		Иначе // КолонкаСхемыЗапроса
			Выражение = КонтрольнаяТочкаИтогов.Выражение.Псевдоним;
		КонецЕсли;
		
		ИмяКолонкиСовпадаетСВыражением = Строка(Выражение) = КонтрольнаяТочкаИтогов.ИмяКолонки;
		
		Если КонтрольнаяТочкаИтогов.ТипКонтрольнойТочки = ТипКонтрольнойТочкиСхемыЗапроса.Элементы Тогда
			Если ИмяКолонкиСовпадаетСВыражением Тогда
				МодельТекста
					.Добавить(".Группировка(""{1}"")", Выражение)
				;
			Иначе
				МодельТекста
					.Добавить(".Группировка(""{1}"", ""{2}"")", Выражение, КонтрольнаяТочкаИтогов.ИмяКолонки)
				;
			КонецЕсли;
		Иначе
			Если ИмяКолонкиСовпадаетСВыражением Тогда
				МодельТекста
					.Добавить(".Группировка(""{1}"", , ТипКонтрольнойТочкиСхемыЗапроса.{2})", Выражение, ОбщийКлиентСервер.CamelCase(Строка(КонтрольнаяТочкаИтогов.ТипКонтрольнойТочки)))
				;
			Иначе
				МодельТекста
					.Добавить(".Группировка(""{1}"", ""{2}"", ТипКонтрольнойТочкиСхемыЗапроса.{3})", Выражение, КонтрольнаяТочкаИтогов.ИмяКолонки, ОбщийКлиентСервер.CamelCase(Строка(КонтрольнаяТочкаИтогов.ТипКонтрольнойТочки)))
				;
			КонецЕсли;
		КонецЕсли;
		
		Если КонтрольнаяТочкаИтогов.ТипДополненияПериодами = ТипДополненияПериодамиСхемыЗапроса.БезДополнения Тогда
			Продолжить;
		КонецЕсли;
		
		МодельТекста
			.Добавить(".ПоПериодам(ТипДополненияПериодамиСхемыЗапроса.{1}, ""{2}"", ""{3}"")", ОбщийКлиентСервер.CamelCase(Строка(КонтрольнаяТочкаИтогов.ТипДополненияПериодами)), КонтрольнаяТочкаИтогов.НачалоПериодаДополнения, КонтрольнаяТочкаИтогов.КонецПериодаДополнения)
		;
	КонецЦикла;
	
	Для Каждого ВыражениеИтогов Из ЗапросПакета.ВыраженияИтогов Цикл
		Если СтрШаблон("СУММА(%1)", ВыражениеИтогов.Поле.Псевдоним) = Строка(ВыражениеИтогов.Выражение) Тогда
			МодельТекста
				.Добавить(".ИтогСумма(""{1}"")", ВыражениеИтогов.Поле.Псевдоним)
			;
		Иначе
			МодельТекста
				.Добавить(".Итог(""{1}"", ""{2}"")", ВыражениеИтогов.Выражение, ВыражениеИтогов.Поле.Псевдоним)
			;
		КонецЕсли;
	КонецЦикла;
	
	Если ЗапросПакета.ОбщиеИтоги Тогда
		МодельТекста
			.Добавить(".ОбщиеИтоги()")
		;
	КонецЕсли;
	
	//  Индексы
	Для Каждого Индекс Из ЗапросПакета.Индекс Цикл
		МодельТекста
			.Добавить(".Индекс(""{1}"")", Индекс.Выражение.Псевдоним)
		;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьТестУстановкиПараметров(СхемаЗапроса)
	
	Если СхемаЗапроса.НайтиПараметры().Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	МодельТекста
		.Добавить(";//  Установка параметров")
		.Добавить("//МодельЗапроса")
	;
	
	Для Каждого Параметр Из СхемаЗапроса.НайтиПараметры() Цикл
		МодельТекста
			.Добавить("//	.Параметр(""{1}"", )// {2}", Параметр.Имя, Параметр.ТипЗначения)
		;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура КомандаПолучитьТекстМоделиНаСервере()
	
	МодельТекста = Общий.МодельТекста()
	;
	Метки = Новый Массив;
	
	СхемаЗапроса = Новый СхемаЗапроса;
	СхемаЗапроса.УстановитьТекстЗапроса(Объект.ТекстЗапроса.ПолучитьТекст());
	
	//  Запросы
	Для Каждого ЗапросПакета Из СхемаЗапроса.ПакетЗапросов Цикл
		ДобавитьТекстЗапроса(ЗапросПакета);		
	КонецЦикла;
	
	ДобавитьТестУстановкиПараметров(СхемаЗапроса);
	
	МодельТекста
		.Добавить(";//  Обработка результата")
		.Добавить("//МодельЗапроса.ВыполнитьЗапрос();")
	;
	Для Каждого Метка Из Метки Цикл
		МодельТекста
			.Добавить("//Результат = МодельЗапроса.Результат(""{1}"");", Метка)
		;		
	КонецЦикла;
	
	Объект.ТекстМодели.УстановитьТекст(МодельТекста.ПолучитьТекст());

КонецПроцедуры

&НаКлиенте
Асинх Процедура ОткрытьКонструкторЗапроса()
	
	Конструктор = Новый КонструкторЗапроса;
	Конструктор.Текст = Объект.ТекстЗапроса.ПолучитьТекст();
	ТекстЗапроса = Ждать Конструктор.ОткрытьАсинх();
	
	Если ТекстЗапроса <> Неопределено Тогда
		Объект.ТекстЗапроса.УстановитьТекст(ТекстЗапроса);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаОткрытьКонструкторЗапроса(Команда)
	
	ОткрытьКонструкторЗапроса();
	
КонецПроцедуры
