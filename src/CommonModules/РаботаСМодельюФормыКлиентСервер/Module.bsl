#Область ПрограммныйИнтерфейс
	
Функция НайтиПодчиненныеЭлементы(Родитель) Экспорт
	НайденныеЭлементы = Новый Массив;
	Для Каждого Элемент Из Родитель.ПодчиненныеЭлементы Цикл
		ТипЭлемента = ТипЗнч(Элемент);
		Если ТипЭлемента = Тип("ПолеФормы") Тогда
			НайденныеЭлементы.Добавить(Элемент);
			Продолжить;
		КонецЕсли;
		ОбщегоНазначенияКлиентСервер.ДополнитьМассив(НайденныеЭлементы, НайтиПодчиненныеЭлементы(Элемент), Истина);
	КонецЦикла;
	Возврат НайденныеЭлементы;
КонецФункции
	
Функция НастройкаПараметровВыбораЭлемента(МодельОбъекта, Элемент) Экспорт
	ЭлементФормы = МодельОбъекта.ЭлементыФормы[Элемент.Имя];
	//Если НЕ ЗначениеЗаполнено(ЭлементФормы.Параметр.Тип) Тогда // простые типы не имеют настройки связей
	//	Возврат Неопределено;
	//КонецЕсли;
	СвязиПараметровВыбора = Новый Массив;
	ПараметрыВыбора = Новый Массив;
	Для Каждого ИдентификаторСвязи Из ЭлементФормы.Параметр.ВходящиеСвязи Цикл
		Связь = МодельОбъекта.Связи[ИдентификаторСвязи];
		Если НЕ ЗначениеЗаполнено(Связь.ПутьКДанным) Тогда
			Продолжить;
		КонецЕсли;
		Если Связь.Слабая
			ИЛИ ЗначениеЗаполнено(Связь.ПараметрИспользование) 
				И НЕ РаботаСМодельюОбъектаКлиентСервер.ПолучитьЗначениеПараметра(МодельОбъекта, Связь.ПараметрИспользование)
		Тогда
			Продолжить;
		КонецЕсли;
		Параметр = Связь.Параметр;
		Если НЕ РаботаСМодельюОбъектаКлиентСервер.ЗначениеСвойстваПараметра(МодельОбъекта, Параметр, , "Использование") Тогда
			Продолжить;
		КонецЕсли;
		Если НЕ ЗначениеЗаполнено(Параметр) Тогда
			ПараметрыВыбора.Добавить(Новый ПараметрВыбора(Связь.ПутьКДанным, Связь.Значение));
		ИначеЕсли ЗначениеЗаполнено(Параметр.ПутьКДанным) Тогда
			//  Это СвязьПараметровВыбора
			Если ЗначениеЗаполнено(Параметр.ПараметрТаблица) Тогда
				//  Это связь со строкой таблицы элемента
				ПутьКДанным = Параметр.ПутьКДанным;
				ИмяРеквизита = ОбщийКлиентСервер.ОкончаниеСтрокиПослеРазделителя(ПутьКДанным);
				ПутьКДанным = "Элементы." + Параметр.ПараметрТаблица.Имя + ".ТекущиеДанные." + ИмяРеквизита;
			Иначе
				//  Это связь с реквизитом формы или объекта
				ПутьКДанным = РаботаСМодельюОбъектаКлиентСервер.ПутьКДанным(МодельОбъекта, Параметр);
			КонецЕсли;
			СвязиПараметровВыбора.Добавить(Новый СвязьПараметраВыбора(Связь.ПутьКДанным, ПутьКДанным, РежимИзмененияСвязанногоЗначения.НеИзменять));
		Иначе
			//  Это ПараметрыВыбора
			Значение = РаботаСМодельюОбъектаКлиентСервер.ПолучитьЗначениеПараметра(МодельОбъекта, Параметр);
			ПараметрыВыбора.Добавить(Новый ПараметрВыбора(Связь.ПутьКДанным, Значение));
		КонецЕсли;
	КонецЦикла;
	НастройкаПараметровВыбора = Новый Структура("ИмяЭлемента, СвязиПараметровВыбора, ПараметрыВыбора", Элемент.Имя, СвязиПараметровВыбора, ПараметрыВыбора);
	Возврат НастройкаПараметровВыбора;
КонецФункции

Функция НастройкиПараметровВыбораТаблицыФормы(Форма, ТаблицаФормы) Экспорт
	МодельОбъекта = РаботаСМодельюОбъектаКлиентСервер.ПолучитьМодель(Форма);
	НайденныеЭлементы = НайтиПодчиненныеЭлементы(ТаблицаФормы);
	НастройкиПараметровВыбора = Новый Массив;
	Для Каждого Элемент Из НайденныеЭлементы Цикл
		Если НЕ ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Элемент, "СвязиПараметровВыбора") Тогда
			Продолжить;
		КонецЕсли;
		НастройкаПараметровВыбора = НастройкаПараметровВыбораЭлемента(МодельОбъекта, Элемент);
		Если НЕ ЗначениеЗаполнено(НастройкаПараметровВыбора) Тогда
			Продолжить;
		КонецЕсли;
		Если ОбщийКлиентСервер.МассивыИдентичны(Элемент.СвязиПараметровВыбора, НастройкаПараметровВыбора.СвязиПараметровВыбора) И ОбщийКлиентСервер.МассивыИдентичны(Элемент.ПараметрыВыбора, НастройкаПараметровВыбора.ПараметрыВыбора) Тогда
			Продолжить;
		КонецЕсли;
		НастройкиПараметровВыбора.Добавить(НастройкаПараметровВыбора);
	КонецЦикла;
	Возврат НастройкиПараметровВыбора;
КонецФункции
	
Функция ПриАктивизацииСтроки(Контекст, Элемент) Экспорт
	МодельОбъекта = РаботаСМодельюОбъектаКлиентСервер.ПолучитьМодель(Контекст);
	ЭлементФормы = МодельОбъекта.ЭлементыФормы[Элемент.Имя];
	Если ЭлементФормы = Неопределено ИЛИ ЭлементФормы.ПараметрТекущаяСтрока = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	Если РаботаСМодельюОбъектаКлиентСервер.УстановитьЗначениеПараметра(МодельОбъекта, ЭлементФормы.ПараметрТекущаяСтрока, Элемент.ТекущаяСтрока) Тогда
		Возврат РаботаСМодельюОбъектаКлиентСервер.СоздатьРасчетныйПараметр(МодельОбъекта, ЭлементФормы.ПараметрТекущаяСтрока);
	КонецЕсли;
	Возврат Неопределено;
КонецФункции

Функция ОбновитьФорму(Контекст, РассчитанныеПараметры = Неопределено) Экспорт
	МодельОбъекта = РаботаСМодельюОбъектаКлиентСервер.ПолучитьМодель(Контекст);
	#Если Клиент Тогда
		РасчетВКонтекстеКлиента = Истина;
	#Иначе
		РасчетВКонтекстеКлиента = Ложь;
	#КонецЕсли
	
	//  Инициализация
	ИзмененныеПараметры = Новый Массив;
	Если ТипЗнч(РассчитанныеПараметры) = Тип("Структура") Тогда
		СостояниеРасчета = РассчитанныеПараметры;
	Иначе
		СостояниеРасчета = СоздатьСостояниеРасчета();
		Если РассчитанныеПараметры = Неопределено Тогда
			Для Каждого ЭлементПараметра Из МодельОбъекта.ПараметрыСостояния Цикл
				ИзмененныеПараметры.Добавить(ЭлементПараметра.Значение);
			КонецЦикла;
		ИначеЕсли ТипЗнч(РассчитанныеПараметры) = Тип("Строка") Тогда
			Для Каждого Параметр Из ОбщийКлиентСервер.Массив(РассчитанныеПараметры) Цикл
				ИзмененныеПараметры.Добавить(РаботаСМодельюОбъектаКлиентСервер.ПолучитьПараметрИзИдентификатора(МодельОбъекта, Параметр).Параметр);
			КонецЦикла;
		Иначе
			Для Каждого РасчетныйПараметр Из РассчитанныеПараметры Цикл
				ИзмененныеПараметры.Добавить(РасчетныйПараметр.Параметр);
			КонецЦикла;
		КонецЕсли;
	КонецЕсли;
		
	ЭлементыФормы = СостояниеРасчета.ЭлементыФормы;
	СвойстваЭлементов = СостояниеРасчета.СвойстваЭлементов;
	ЭлементыСвязей = СостояниеРасчета.ЭлементыСвязей;				
	СловарьЭлементов = СостояниеРасчета.СловарьЭлементов;
	
	Для Каждого Параметр Из ИзмененныеПараметры Цикл
		Для Каждого ИдентификаторПараметраЭлемента Из Параметр.ЗависимыеЭлементы Цикл
			ПараметрЭлемента = МодельОбъекта.ПараметрыЭлементов[ИдентификаторПараметраЭлемента];
			Если ЗначениеЗаполнено(ПараметрЭлемента.Свойство) Тогда
				СвойстваЭлементов.Добавить(ПараметрЭлемента);
				Продолжить;
			КонецЕсли;
			ЭлементФормы = ПараметрЭлемента.Элемент;
			Если СловарьЭлементов[ЭлементФормы.Имя] = Истина Тогда
				Продолжить;
			КонецЕсли;
			Если РасчетВКонтекстеКлиента И НЕ ЭлементФормы.НаКлиенте Тогда
				РасчетВКонтекстеКлиента = Ложь;
			КонецЕсли;
			СловарьЭлементов[ЭлементФормы.Имя] = Истина;
			ЭлементыФормы.Добавить(ЭлементФормы);
		КонецЦикла;
		ОбщегоНазначенияКлиентСервер.ДополнитьМассив(ЭлементыСвязей, Параметр.ЭлементыСвязей, Истина);
	КонецЦикла;
	
	#Если Клиент Тогда
		Если НЕ РасчетВКонтекстеКлиента ИЛИ ЗначениеЗаполнено(ЭлементыСвязей) Тогда
			Возврат СостояниеРасчета;
		КонецЕсли;
	#КонецЕсли
	
	Форма = МодельОбъекта.Контекст;
	Элементы = Форма.Элементы;
	Для Каждого ПараметрСвойства Из СвойстваЭлементов Цикл
		Если ЗначениеЗаполнено(ПараметрСвойства.ПараметрИспользование) И НЕ РаботаСМодельюОбъектаКлиентСервер.ПолучитьЗначениеПараметра(МодельОбъекта, ПараметрСвойства.ПараметрИспользование) Тогда 
			Продолжить;		
		КонецЕсли;
		ИмяЭлемента = ПараметрСвойства.Элемент.Имя;
		ИмяСвойства = ПараметрСвойства.Свойство;
		Если ИмяЭлемента = "ЭтаФорма" Тогда
			Элемент = Форма;
		Иначе
			Элемент = Элементы.Найти(ИмяЭлемента);
		КонецЕсли;
		Если Элемент = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		ЗначениеПараметра = РаботаСМодельюОбъектаКлиентСервер.ПолучитьЗначениеПараметра(МодельОбъекта, ПараметрСвойства.Параметр);
		НастроитьСвойство(Форма, Элемент, ИмяСвойства, ЗначениеПараметра);
	КонецЦикла;
	
	Если ЗначениеЗаполнено(ЭлементыФормы) Тогда
		РаботаСМассивом.СортироватьПо(ЭлементыФормы, "Порядок");
		Для Каждого ЭлементФормы Из ЭлементыФормы Цикл
			Если НЕ ЗначениеЗаполнено(ЭлементФормы.ФункцияСостояния) Тогда
				Продолжить;
			КонецЕсли;
			ИмяЭлемента = ЭлементФормы.Имя;
			Если ИмяЭлемента = "ЭтаФорма" Тогда
				Элемент = Форма;
			Иначе
				Элемент = Элементы.Найти(ИмяЭлемента);
			КонецЕсли;
			Если Элемент = Неопределено Тогда
				Продолжить;
			КонецЕсли;
			Параметры = Новый Структура;
			Для Каждого ИдентификаторПараметраЭлемента Из ЭлементФормы.Параметры Цикл
				ПараметрЭлемента = МодельОбъекта.ПараметрыЭлементов[ИдентификаторПараметраЭлемента];
				ЗначениеПараметра = РаботаСМодельюОбъектаКлиентСервер.ПолучитьЗначениеПараметра(МодельОбъекта, ПараметрЭлемента.Параметр);
				ОбщийКлиентСервер.ДобавитьЗначениеВСтруктуруПараметров(Параметры, ЗначениеПараметра, ПараметрЭлемента.ПутьКДанным);
			КонецЦикла;
			Свойства = Новый Структура;
			//@skip-check server-execution-safe-mode
			Результат = Вычислить(ЭлементФормы.ФункцияСостояния);
			Если Результат = Ложь Тогда
				Продолжить;
			КонецЕсли;
			НастроитьЭлемент(Форма, Элемент, Свойства);
		КонецЦикла;
	КонецЕсли;

	#Если Сервер Тогда
		НастройкиПараметровВыбора = Новый Массив;
		Для Каждого ИмяЭлемента Из ЭлементыСвязей Цикл
			Элемент = Контекст.Элементы.Найти(ИмяЭлемента);
			Если Элемент = Неопределено ИЛИ НЕ ТипЗнч(Элемент) = Тип("ПолеФормы") ИЛИ НЕ Элемент.Вид = ВидПоляФормы.ПолеВвода Тогда
				Продолжить;
			КонецЕсли;
			НастройкаПараметровВыбора = НастройкаПараметровВыбораЭлемента(МодельОбъекта, Элемент);
			Если ОбщийКлиентСервер.МассивыИдентичны(Элемент.СвязиПараметровВыбора, НастройкаПараметровВыбора.СвязиПараметровВыбора) И ОбщийКлиентСервер.МассивыИдентичны(Элемент.ПараметрыВыбора, НастройкаПараметровВыбора.ПараметрыВыбора) Тогда
				Продолжить;
			КонецЕсли;
			НастройкиПараметровВыбора.Добавить(НастройкаПараметровВыбора);
		КонецЦикла;
		Если ЗначениеЗаполнено(НастройкиПараметровВыбора) Тогда
			РаботаСМодельюФормы.ПрименитьНастройкиПараметровВыбора(Форма, НастройкиПараметровВыбора);
		КонецЕсли;
	#КонецЕсли
	
	СостояниеРасчета.Статус = Истина;
	Возврат СостояниеРасчета;	
КонецФункции

Функция ПолучитьРасчетныйПараметрЭлементаФормы(Контекст, ИмяЭлемента, Знач ИдентификаторСтроки = Неопределено) Экспорт
	МодельОбъекта = РаботаСМодельюОбъектаКлиентСервер.ПолучитьМодель(Контекст);
	ЭлементФормы = МодельОбъекта.ЭлементыФормы[ИмяЭлемента];
	Если ЭлементФормы = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	Если ИдентификаторСтроки = Неопределено И ЗначениеЗаполнено(ЭлементФормы.Таблица) Тогда
		ИдентификаторСтроки = Контекст.Элементы[ЭлементФормы.Таблица].ТекущаяСтрока;
	КонецЕсли;
	Возврат РаботаСМодельюОбъектаКлиентСервер.СоздатьРасчетныйПараметр(МодельОбъекта, ЭлементФормы.Параметр, ИдентификаторСтроки);
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура НастроитьСвойство(Форма, Элемент, Свойство, Значение)
	Если Свойство = "ТекущаяСтраница" Тогда
		Если НЕ ЗначениеЗаполнено(Значение) Тогда
			Возврат;
		КонецЕсли;
		ОбщийКлиентСервер.УстановитьЗначение(Элемент[Свойство], Форма.Элементы[Значение]);
	ИначеЕсли Свойство = "ОтборСтрок" Тогда
		ОбщийКлиентСервер.УстановитьЗначение(Элемент[Свойство], Значение);
	ИначеЕсли Свойство = "СписокВыбора" Тогда
		Элемент.СписокВыбора.Очистить();
		Для каждого ЭлементСписка Из Значение Цикл
			Элемент.СписокВыбора.Добавить(ЭлементСписка.Значение, ЭлементСписка.Представление);
		КонецЦикла;
	ИначеЕсли Свойство = "ОграничениеТипа" Тогда
		Если Значение = Неопределено Тогда
			Элемент.ОграничениеТипа = Новый ОписаниеТипов("Неопределено");
		Иначе
			Элемент.ОграничениеТипа = Значение;
		КонецЕсли;
	ИначеЕсли Свойство = "ТекущийЭлемент" Тогда
		Форма.ТекущийЭлемент = Форма.Элементы[Значение];
	ИначеЕсли Свойство = "Свернута" Тогда
		Если Значение Тогда
			Элемент.Скрыть();
		Иначе
			Элемент.Показать();
		КонецЕсли;
	Иначе
		ОбщийКлиентСервер.УстановитьЗначение(Элемент[Свойство], Значение, Истина, Истина);
	КонецЕсли;
КонецПроцедуры

Процедура НастроитьЭлемент(Форма, Элемент, Свойства)
	Для Каждого ЭлементСвойства Из Свойства Цикл
		НастроитьСвойство(Форма, Элемент, ЭлементСвойства.Ключ, ЭлементСвойства.Значение);
	КонецЦикла;
КонецПроцедуры

Функция СоздатьСостояниеРасчета()
	Состояние = Новый Структура;
	Состояние.Вставить("ЭлементыФормы", Новый Массив);
	Состояние.Вставить("ЭлементыСвязей", Новый Массив);
	Состояние.Вставить("СвойстваЭлементов", Новый Массив);
	Состояние.Вставить("СловарьЭлементов", Новый Соответствие);
	Состояние.Вставить("Статус", Ложь);
	Возврат Состояние;
КонецФункции

#КонецОбласти