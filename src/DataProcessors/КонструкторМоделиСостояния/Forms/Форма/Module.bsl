//  Формирование графа: внешняя компонента GraphViz1С,  https://infostart.ru/public/1344516/
//  Панорамирование и зуммирование: https://github.com/bumbu/svg-pan-zoom

&НаКлиенте
Перем ИдентификаторКомпоненты, ВнешняяКомпонента;

#Область МодельСостояния

&НаКлиенте
Перем ИзмененныеПараметрыТекущейСтроки;

&НаСервере
Процедура ОбновитьФормуНаСервере(ИзмененныеПараметры = Неопределено)
	РаботаСМодельюФормыКлиентСервер.ОбновитьФорму(ЭтотОбъект, ИзмененныеПараметры);
КонецПроцедуры

&НаСервере
Процедура ПриИзмененииНаСервере(ИзмененныеПараметры = Неопределено, СостояниеРасчета = Неопределено)
	СостояниеРасчета = РаботаСМодельюОбъектаКлиентСервер.Рассчитать(ЭтотОбъект, ИзмененныеПараметры, СостояниеРасчета);
	ОбновитьФормуНаСервере(СостояниеРасчета.РассчитанныеПараметры);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьФормуНаКлиенте(ИзмененныеПараметры = Неопределено)
	СостояниеРасчета = РаботаСМодельюФормыКлиентСервер.ОбновитьФорму(ЭтотОбъект, ИзмененныеПараметры);
	Если НЕ СостояниеРасчета.Статус Тогда
		ОбновитьФормуНаСервере(СостояниеРасчета);
		Возврат; 
	КонецЕсли;
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

//@skip-check module-unused-method
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

//@skip-check module-unused-method
&НаКлиенте
Процедура ПриАктивизацииСтроки(Элемент)
	Если ИзмененныеПараметрыТекущейСтроки = Неопределено Тогда
		ИзмененныеПараметрыТекущейСтроки = Новый Массив;
	КонецЕсли;
	РасчетныйПараметрТекущейСтроки = РаботаСМодельюФормыКлиентСервер.ПриАктивизацииСтроки(ЭтотОбъект, Элемент);
	Если РасчетныйПараметрТекущейСтроки <> Неопределено Тогда
		ИзмененныеПараметрыТекущейСтроки.Добавить(РасчетныйПараметрТекущейСтроки);
	КонецЕсли;
	Если ЗначениеЗаполнено(ИзмененныеПараметрыТекущейСтроки) Тогда
		ПодключитьОбработчикОжидания("ПриИзмененииТекущейСтроки", 0.1, Истина);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПриИзмененииТекущейСтроки() Экспорт
	ИзмененныеПараметры = РаботаСМассивом.СкопироватьМассив(ИзмененныеПараметрыТекущейСтроки);
	ИзмененныеПараметрыТекущейСтроки = Неопределено;
	ПриИзмененииНаКлиенте(ИзмененныеПараметры);
КонецПроцедуры

//@skip-check module-unused-method
&НаКлиенте
Процедура НачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	РаботаСМодельюФормыКлиентСервер.ПроверитьЗаполнениеПараметровВыбора(ЭтотОбъект, Элемент, СтандартнаяОбработка);
КонецПроцедуры

//@skip-check module-unused-method
&НаСервере
Процедура ПослеЗаписиВМоделиОбъектаНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	МодельОбъекта = РаботаСМодельюОбъектаКлиентСервер.ПолучитьМодель(ЭтотОбъект);
	РаботаСМодельюОбъектаКлиентСервер.РассчитатьПараметрыКонтекста(МодельОбъекта);
	РаботаСМодельюФормы.НастроитьПараметрыВыбора(МодельОбъекта);
	ОбновитьФормуНаСервере();
КонецПроцедуры

//@skip-check module-unused-method
&НаСервере
Процедура ПриЧтенииВМоделиОбъектаНаСервере(ТекущийОбъект)
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(ЭтотОбъект, "ЗначенияПараметров") Тогда
		МодельОбъекта = РаботаСМодельюОбъектаКлиентСервер.ПолучитьМодель(ЭтотОбъект);
		РаботаСМодельюОбъектаКлиентСервер.РассчитатьПараметрыКонтекста(МодельОбъекта);
		РаботаСМодельюФормы.НастроитьПараметрыВыбора(МодельОбъекта);
		ОбновитьФормуНаСервере();
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

&НаСервере
Функция ПолучитьТекстГрафа() 
	Перем Параметры;
	ТаблицаВыбранныеПараметры = Общий.ТаблицаЗначений(Новый Структура("Имя", ОбщегоНазначения.ОписаниеТипаСтрока(255)));
	Для каждого ВыделеннаяСтрока Из Элементы.ПараметрыСостояния.ВыделенныеСтроки Цикл
		ДанныеПараметра = Объект.ПараметрыСостояния.НайтиПоИдентификатору(ВыделеннаяСтрока);
		ЗаполнитьЗначенияСвойств(ТаблицаВыбранныеПараметры.Добавить(), ДанныеПараметра);
	КонецЦикла;
	МодельЗапроса = Общий.МодельЗапроса()
	;
	МодельЗапроса.ЗапросПакета().Поместить("ВТ_ВЫБРАННЫЕ_ПАРАМЕТРЫ")
		.Источник(ТаблицаВыбранныеПараметры)
		.Поле("*")
	;
	МодельЗапроса.ЗапросПакета().Поместить("ВТ_ПАРАМЕТРЫ_СОСТОЯНИЯ")
		.Источник(Объект.ПараметрыСостояния)
		.Поле("*")
	;
	МодельЗапроса.ЗапросПакета().Поместить("ВТ_СВЯЗИ_ПАРАМЕТРОВ")
		.Источник(Объект.СвязиПараметров)
		.Поле("*")
	;
	МодельЗапроса.ЗапросПакета().Поместить("ВТ_ЭЛЕМЕНТЫ_ФОРМЫ")
		.Источник(Объект.ЭлементыФормы)
		.Поле("*")
	;
	МодельЗапроса.ЗапросПакета().Поместить("ВТ_ПАРАМЕТРЫ_ЭЛЕМЕНТОВ")
		.Источник(Объект.ПараметрыЭлементов)
		.Поле("*")
	;//  ЗАПРОС ПАКЕТА. ВТ_СВЯЗИ
	МодельЗапроса.ЗапросПакета().Поместить("ВТ_СВЯЗИ")
		.Выбрать(, Истина)
			.Источник("ВТ_СВЯЗИ_ПАРАМЕТРОВ")
			.Источник("ВТ_ВЫБРАННЫЕ_ПАРАМЕТРЫ")
			.ВнутреннееСоединение("ВТ_СВЯЗИ_ПАРАМЕТРОВ", "ВТ_ВЫБРАННЫЕ_ПАРАМЕТРЫ")
				.Связь("ПараметрСостояния = Имя")
			.Поле("ПараметрСостояния")
			.Поле("Параметр")
			.Поле("Представление")
		.Объединить()
			.Источник("ВТ_СВЯЗИ_ПАРАМЕТРОВ")
			.Источник("ВТ_ВЫБРАННЫЕ_ПАРАМЕТРЫ")
			.ВнутреннееСоединение("ВТ_СВЯЗИ_ПАРАМЕТРОВ", "ВТ_ВЫБРАННЫЕ_ПАРАМЕТРЫ")
				.Связь("Параметр = Имя")
			.Поле("ПараметрСостояния")
			.Поле("Параметр")
			.Поле("Представление")
	;//  ЗАПРОС ПАКЕТА. ВТ_ПАРАМЕТРЫ - Параметры, определенные по связям
	МодельЗапроса.ЗапросПакета().Поместить("ВТ_ПАРАМЕТРЫ")
		.Выбрать(, Истина)
			.Источник("ВТ_СВЯЗИ")
			.Поле("ПараметрСостояния", "Параметр")
		.Объединить()
			.Источник("ВТ_СВЯЗИ")
			.Поле("Параметр", "Параметр")
	;//  ЗАПРОС ПАКЕТА. ВТ_ЭЛЕМЕНТЫ_ПАРАМЕТРОВ - Элементы и их параметры
	МодельЗапроса.ЗапросПакета().Поместить("ВТ_ЭЛЕМЕНТЫ_ПАРАМЕТРОВ")
		.Выбрать(, Истина)
			.Источник("ВТ_ПАРАМЕТРЫ")
			.Источник("ВТ_ПАРАМЕТРЫ_ЭЛЕМЕНТОВ")
			.ВнутреннееСоединение("ВТ_ПАРАМЕТРЫ", "ВТ_ПАРАМЕТРЫ_ЭЛЕМЕНТОВ")
				.Связь("Параметр")
			.Поле("ВТ_ПАРАМЕТРЫ.Параметр")
			.Поле("Элемент")
	;//  ЗАПРОС ПАКЕТА. Параметры
	МодельЗапроса.ЗапросПакета("Параметры")
		.Выбрать()
			.Источник("ВТ_ПАРАМЕТРЫ")
			.Источник("ВТ_ПАРАМЕТРЫ_СОСТОЯНИЯ")
			.ВнутреннееСоединение("ВТ_ПАРАМЕТРЫ", "ВТ_ПАРАМЕТРЫ_СОСТОЯНИЯ")
				.Связь("Параметр = Имя")
			.Поле("ВТ_ПАРАМЕТРЫ_СОСТОЯНИЯ.ПриведенноеИмя", "Параметр")
			.Поле("Тип")
			.Поле("Представление")
		.Порядок("Параметр")
	;//  ЗАПРОС ПАКЕТА. Элементы
	МодельЗапроса.ЗапросПакета("Элементы")
		.Выбрать(, Истина)
			.Источник("ВТ_ЭЛЕМЕНТЫ_ПАРАМЕТРОВ")
			.Источник("ВТ_ЭЛЕМЕНТЫ_ФОРМЫ")
			.Источник("ВТ_ПАРАМЕТРЫ_СОСТОЯНИЯ")
			.ВнутреннееСоединение("ВТ_ЭЛЕМЕНТЫ_ПАРАМЕТРОВ", "ВТ_ЭЛЕМЕНТЫ_ФОРМЫ")
				.Связь("Элемент = Имя")
			.ВнутреннееСоединение("ВТ_ЭЛЕМЕНТЫ_ПАРАМЕТРОВ", "ВТ_ПАРАМЕТРЫ_СОСТОЯНИЯ")
				.Связь("Параметр = Имя")
			.Поле("ВТ_ЭЛЕМЕНТЫ_ФОРМЫ.ПриведенноеИмя", "Элемент")
			.Поле("ВТ_ПАРАМЕТРЫ_СОСТОЯНИЯ.ПриведенноеИмя", "Параметр")
		.Порядок("Элемент")
	;//  ЗАПРОС ПАКЕТА. Связи параметров
	МодельЗапроса.ЗапросПакета("СвязиПараметров")
		.Выбрать()
			.Источник("ВТ_СВЯЗИ")
			.Источник("ВТ_ПАРАМЕТРЫ_СОСТОЯНИЯ", "ПараметрыСостояния")
			.Источник("ВТ_ПАРАМЕТРЫ_СОСТОЯНИЯ", "Параметры")
			.ВнутреннееСоединение("ВТ_СВЯЗИ", "ПараметрыСостояния")
				.Связь("ПараметрСостояния = Имя")
			.ВнутреннееСоединение("ВТ_СВЯЗИ", "Параметры")
				.Связь("Параметр = Имя")
			.Поле("ПараметрыСостояния.ПриведенноеИмя", "ПараметрСостояния")
			.Поле("Параметры.ПриведенноеИмя", "Параметр")
			.Поле("ВТ_СВЯЗИ.Представление")
		.Порядок("ПараметрСостояния")
		.Порядок("Параметр")
	;//  ЗАПРОС ПАКЕТА. Связи элементов
	МодельЗапроса.ЗапросПакета("СвязиЭлементов")
		.Выбрать(, Истина)
			.Источник("ВТ_ЭЛЕМЕНТЫ_ПАРАМЕТРОВ")
			.Источник("ВТ_ЭЛЕМЕНТЫ_ФОРМЫ")
			.Источник("ВТ_ПАРАМЕТРЫ_СОСТОЯНИЯ")
			.ВнутреннееСоединение("ВТ_ЭЛЕМЕНТЫ_ПАРАМЕТРОВ", "ВТ_ЭЛЕМЕНТЫ_ФОРМЫ")
				.Связь("Элемент = Имя")
			.ВнутреннееСоединение("ВТ_ЭЛЕМЕНТЫ_ПАРАМЕТРОВ", "ВТ_ПАРАМЕТРЫ_СОСТОЯНИЯ")
				.Связь("Параметр = Имя")
			.Поле("ВТ_ПАРАМЕТРЫ_СОСТОЯНИЯ.ПриведенноеИмя", "Параметр")
			.Поле("ВТ_ЭЛЕМЕНТЫ_ФОРМЫ.ПриведенноеИмя", "Элемент")
		.Порядок("Параметр")
		.Порядок("Элемент")
	;
	МодельЗапроса.ВыполнитьЗапрос();
	
	СтрокиСкрипта = Новый Массив;
	СтрокиСкрипта.Добавить("digraph Модель {
	|bgcolor=white
	|transparent=true
	|rankdir=TD");
	//  Параметры типа 0
	СтрокиСкрипта.Добавить("node [shape=ellipse style=filled fontsize=24 color=deepskyblue height=2.00 width=5.00]");
	РаботаСМассивом.ДополнитьМассив(СтрокиСкрипта,
		РаботаСМассивом.АТДМассив(МодельЗапроса.ВыгрузитьРезультат("Параметры"))
			.Отобрать("Элемент.Тип = 0")
			.Отобразить("СтрШаблон('%1', СтрЗаменить(Элемент.Параметр, '.', ''))")
			.ВМассив()	
	);
	//  Параметры типа 1 - Признаки
	СтрокиСкрипта.Добавить("node [shape=ellipse style=none fontsize=24 color=deepskyblue height=2.00 width=5.00]");
	РаботаСМассивом.ДополнитьМассив(СтрокиСкрипта,
		РаботаСМассивом.АТДМассив(МодельЗапроса.ВыгрузитьРезультат("Параметры"))
			.Отобрать("Элемент.Тип = 1")
			.Отобразить("СтрШаблон('%1 [label = ''%2'']', СтрЗаменить(Элемент.Параметр, '.', ''), Элемент.Представление)")
			.ВМассив()	
	);
	//  Параметры типа 2 - Свойства
	СтрокиСкрипта.Добавить("node [shape=ellipse style=none fontsize=24 color=darkgoldenrod1 height=2.00 width=5.00]");
	РаботаСМассивом.ДополнитьМассив(СтрокиСкрипта,
		РаботаСМассивом.АТДМассив(МодельЗапроса.ВыгрузитьРезультат("Параметры"))
			.Отобрать("Элемент.Тип = 2")
			.Отобразить("СтрШаблон('%1 [label = ''%2'']', СтрЗаменить(Элемент.Параметр, '.', ''), Элемент.Представление)")
			.ВМассив()	
	);
	//  Элементы
	СтрокиСкрипта.Добавить("node [shape=ellipse style=filled fontsize=24 color=yellow height=2.00 width=5.00]");
	РаботаСМассивом.ДополнитьМассив(СтрокиСкрипта,
		РаботаСМассивом.АТДМассив(МодельЗапроса.ВыгрузитьРезультат("Элементы"))
			.Отобрать("Элемент.Параметр <> Элемент.Элемент")
			.Отобразить("Элемент.Элемент")
			.ВМассив()	
	);
	//  Связи параметров
	СтрокиСкрипта.Добавить("edge [color=black penwidth=5]");
	РаботаСМассивом.ДополнитьМассив(СтрокиСкрипта,
		РаботаСМассивом.АТДМассив(МодельЗапроса.ВыгрузитьРезультат("СвязиПараметров"))
			.Отобрать("НЕ ЗначениеЗаполнено(Элемент.Представление)")
			.Отобразить("СтрШаблон('%1 -> %2', СтрЗаменить(Элемент.Параметр, '.', ''), СтрЗаменить(Элемент.ПараметрСостояния, '.', ''))")
			.ВМассив() 
	);
	РаботаСМассивом.ДополнитьМассив(СтрокиСкрипта,
		РаботаСМассивом.АТДМассив(МодельЗапроса.ВыгрузитьРезультат("СвязиПараметров"))
			.Отобрать("ЗначениеЗаполнено(Элемент.Представление)")
			.Отобразить("СтрШаблон('%1 -> %2 [label = ''%3'']', СтрЗаменить(Элемент.Параметр, '.', ''), СтрЗаменить(Элемент.ПараметрСостояния, '.', ''), Элемент.Представление)")
			.ВМассив() 
	);
	//  Связи элементов
	СтрокиСкрипта.Добавить("edge [color=darkgoldenrod1 penwidth=5]");
	РаботаСМассивом.ДополнитьМассив(СтрокиСкрипта,
		РаботаСМассивом.АТДМассив(МодельЗапроса.ВыгрузитьРезультат("СвязиЭлементов"))
			.Отобрать("Элемент.Параметр <> Элемент.Элемент")
			.Отобразить("СтрШаблон('%1 -> %2', Элемент.Параметр, Элемент.Элемент)")
			.ВМассив() 
	);
	СтрокиСкрипта.Добавить("}");
	Возврат СтрСоединить(СтрокиСкрипта, Символы.ПС);
КонецФункции

&НаКлиенте
Процедура КомандаСохранитьSVG(Команда)
	ДиалогВыбораФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
	ДиалогВыбораФайла.Фильтр = НСтр("ru = 'Картинка svg'") + "(*.svg)|*.svg";
	ДиалогВыбораФайла.Заголовок = "Сохранить картинку графа в файл";
	Если ДиалогВыбораФайла.Выбрать() Тогда
	    ИмяФайла = ДиалогВыбораФайла.ВыбранныеФайлы[0];
		ЗаписьТекста = Новый ЗаписьТекста(ИмяФайла, КодировкаТекста.UTF8);
		ЗаписьТекста.Записать(svg);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура КомандаПоказатьТекстDOT(Команда)
	Текст = Новый ТекстовыйДокумент;
	Текст.УстановитьТекст(ТекстГрафа);
	Текст.Показать();
КонецПроцедуры

&НаКлиенте
Процедура СформироватьHTML(ДанныеКартинки) Экспорт
	Поток = ДанныеКартинки.ОткрытьПотокДляЧтения();
	ЧтениеТекста = Новый ЧтениеТекста(Поток, КодировкаТекста.UTF8);
	svg = ЧтениеТекста.Прочитать();
	ТекстHTMLОтображенияГрафа =
	"<html>
	|<head>
	|	<style>svg {width: 100%; height: 100%;}</style>
	|	<script src=""" + АдресСкриптаJS + """></script>
	|</head>
	|<body>
	|<div id = 'container'>
	|" + svg + "
	|</div> 
	|<script>
	|	// Don't use window.onLoad like this in production, because it can only listen to one function.
	|	window.onload = function () {
	|		const svg = document.querySelector('svg');
	|		svg.setAttribute('id', 'graphviz');
	|		svgPanZoom('#graphviz', {
	|			zoomEnabled: true,
	|			controlIconsEnabled: true,
	|			fit: true,
	|			center: true,
	|		});
	|	};
	|	</script>
	|</body>
	|</html>";
КонецПроцедуры

&НаКлиенте
Функция ПолучитьОтборСтрокПараметры(Параметры) Экспорт
	Если Параметры.ТекущаяСтрока = Неопределено ИЛИ НЕ Параметры.Синхронизировать Тогда
		Возврат Неопределено;
	КонецЕсли;
	ДанныеСтроки = Параметры.ПараметрыСостояния.НайтиПоИдентификатору(Параметры.ТекущаяСтрока);
	Отбор = Новый Структура("ИДПараметраСостояния", ДанныеСтроки.ИД);
	Возврат Новый ФиксированнаяСтруктура(Отбор);
КонецФункции

&НаКлиенте
Функция ПолучитьОтборСтрокПараметрыЭлементов(Параметры) Экспорт
	Если Параметры.ТекущаяСтрока = Неопределено ИЛИ НЕ Параметры.Синхронизировать Тогда
		Возврат Неопределено;
	КонецЕсли;
	ДанныеСтроки = Параметры.ЭлементыФормы.НайтиПоИдентификатору(Параметры.ТекущаяСтрока);
	Отбор = Новый Структура("ИДЭлемента", ДанныеСтроки.ИД);
	Возврат Новый ФиксированнаяСтруктура(Отбор);
КонецФункции

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	МодельСостояния = РаботаСМодельюСостояния.МодельСостояния(ЭтотОбъект, , "КонструкторМоделиСостоянияМодель")
	;
	МодельСостояния.ЭлементФормы("ПараметрыСостояния").НаКлиенте()
		.ТекущаяСтрока()
	;
	МодельСостояния.ЭлементФормы("ЭлементыФормы").НаКлиенте()
		.ТекущаяСтрока()
	;
	МодельСостояния.ПараметрСостояния( , "ПараметрыСостояния.ТекущиеДанные").НаКлиенте()
		.Параметр("ПараметрыСостояния")
		.Параметр("ТекущаяСтрока", "ПараметрыСостояния.ТекущаяСтрока")
		.Выражение("?(Параметры.ТекущаяСтрока <> Неопределено, ОбщийКлиентСервер.СтруктураСвойств('ИД, Выражение', Параметры.ПараметрыСостояния.НайтиПоИдентификатору(Параметры.ТекущаяСтрока)), Неопределено)")
	;
	МодельСостояния.ПараметрСостояния( , "ЭлементыФормы.ТекущиеДанные").НаКлиенте()
		.Параметр("ЭлементыФормы")
		.Параметр("ТекущаяСтрока", "ЭлементыФормы.ТекущаяСтрока")
		.Выражение("?(Параметры.ТекущаяСтрока <> Неопределено, ОбщийКлиентСервер.СтруктураСвойств('ИД', Параметры.ЭлементыФормы.НайтиПоИдентификатору(Параметры.ТекущаяСтрока)), Неопределено)")
	;
	МодельСостояния.ПараметрСостояния("Выражение").НаКлиенте()
		.Параметр("ТекущиеДанные", "ПараметрыСостояния.ТекущиеДанные")
		.Выражение("Параметры.ТекущиеДанные.Выражение")
	;
	МодельСостояния.ЭлементФормы("СвязиПараметров").НаКлиенте()
		.Свойство("ОтборСтрок")
			.Параметр("ТекущиеДанные", "ПараметрыСостояния.ТекущиеДанные")
			.Параметр("СвязатьПараметры")
			.Выражение("?(Параметры.СвязатьПараметры И ЗначениеЗаполнено(Параметры.ТекущиеДанные), Новый ФиксированнаяСтруктура('ИДПараметраСостояния', Параметры.ТекущиеДанные.ИД), Неопределено)")
	;
	МодельСостояния.ЭлементФормы("ПараметрыЭлементов").НаКлиенте()
		.Свойство("ОтборСтрок")
			.Параметр("ТекущиеДанные", "ЭлементыФормы.ТекущиеДанные")
			.Параметр("СвязатьЭлементы")
			.Выражение("?(Параметры.СвязатьЭлементы И ЗначениеЗаполнено(Параметры.ТекущиеДанные), Новый ФиксированнаяСтруктура('ИДЭлемента', Параметры.ТекущиеДанные.ИД), Неопределено)")
	;
	МодельСостояния.ЭлементФормы("КомандаСвязатьПараметры").НаКлиенте()
		.Свойство("Пометка", "СвязатьПараметры")
	;
	МодельСостояния.ЭлементФормы("КомандаСвязатьЭлементы").НаКлиенте()
		.Свойство("Пометка", "СвязатьЭлементы")
	;
	//  Инициализация модели объекта
	МодельСостояния.ПрименитьМодель();
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	МакетКомпоненты = ОбработкаОбъект.ПолучитьМакет("GraphViz1C");
	АдресКомпоненты = ПоместитьВоВременноеХранилище(МакетКомпоненты, УникальныйИдентификатор);
	СкриптJS = ОбработкаОбъект.ПолучитьМакет("svg_pan_zoom_js");
	АдресСкриптаJS = ПоместитьВоВременноеХранилище(СкриптJS, УникальныйИдентификатор);
КонецПроцедуры


&НаКлиенте
Процедура КомандаОбновитьГрафЗависимостей(Команда)
	ТекстГрафа = ПолучитьТекстГрафа();
	ОписаниеОповещения = Новый ОписаниеОповещения("ПолученаКартинка", ЭтотОбъект);
	ВнешняяКомпонента.НачатьВызовСформировать(ОписаниеОповещения, ТекстГрафа, "svg");
КонецПроцедуры

&НаКлиенте
Асинх Процедура ВыполнитьПодключениеВнешнейКомпоненты() Экспорт
	ИдентификаторКомпоненты = ОбщийКлиентСервер.ИмяПоУникальномуИдентификатору();
	КомпонентаПодключена = Ждать ПодключитьВнешнююКомпонентуАсинх(АдресКомпоненты, ИдентификаторКомпоненты, ТипВнешнейКомпоненты.Native);
	Если КомпонентаПодключена Тогда
		ВнешняяКомпонента = Новый("AddIn." + ИдентификаторКомпоненты + ".GraphViz1C");
		Возврат;
	КонецЕсли;
	Ждать УстановитьВнешнююКомпонентуАсинх(АдресКомпоненты);
	КомпонентаПодключена = Ждать ПодключитьВнешнююКомпонентуАсинх(АдресКомпоненты, ИдентификаторКомпоненты, ТипВнешнейКомпоненты.Native);
	Если КомпонентаПодключена Тогда
		ВнешняяКомпонента = Новый("AddIn." + ИдентификаторКомпоненты + ".GraphViz1C");
		Возврат;
	КонецЕсли;
	Сообщить("Не удалось установить компоненту GraphViz1C!");
КонецПроцедуры

&НаКлиенте
Процедура ПодключениеВнешнейКомпонентыЗавершение(Подключение, ДополнительныеПараметры) Экспорт
	Если Подключение Тогда
		ВнешняяКомпонента = Новый("AddIn." + ИдентификаторКомпоненты + ".GraphViz1C");
	ИначеЕсли ДополнительныеПараметры = Истина Тогда
		ОписаниеОповещения = Новый ОписаниеОповещения("ВыполнитьПодключениеВнешнейКомпоненты", ЭтаФорма, Ложь);
		НачатьУстановкуВнешнейКомпоненты(ОписаниеОповещения, АдресКомпоненты);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьПодключениеСриптаJS()
	СкриптJS = ПолучитьИзВременногоХранилища(АдресСкриптаJS);
	АдресСкриптаJS = ПолучитьИмяВременногоФайла("js");
	СкриптJS.Записать(АдресСкриптаJS);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ВыполнитьПодключениеВнешнейКомпоненты();
	ВыполнитьПодключениеСриптаJS();
	ОбновитьФормуНаКлиенте();
КонецПроцедуры

&НаКлиенте
Процедура ПолученаКартинка(РезультатВызова, ПараметрыВызова, ДополнительныеПараметры) Экспорт
	Если ТипЗнч(РезультатВызова) = Тип("ДвоичныеДанные") Тогда
		СформироватьHTML(РезультатВызова);
	ИначеЕсли ТипЗнч(РезультатВызова) = Тип("Строка") Тогда
		Сообщить(РезультатВызова);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Функция СвойстваПараметра(МодельОбъекта, Параметр)
	Если НЕ СтрНачинаетсяС(Параметр.Имя, "_") Тогда
		Возврат Новый Структура("Представление, Тип", Параметр.Имя, 0);
	КонецЕсли;
	//  Это признак
	Если Параметр.ЗависимыеПараметры.Количество() = 1 Тогда
		ИдентификаторСвязи = Параметр.ЗависимыеПараметры[0];
		Связь = МодельОбъекта.СвязиПараметров[ИдентификаторСвязи];
		Возврат Новый Структура("Представление, Тип", Связь.ПутьКДанным, 1);
	КонецЕсли;
	//  Это свойство
	Если Параметр.ЗависимыеЭлементы.Количество() = 1 Тогда
		ИдентификаторПараметраЭлемента = Параметр.ЗависимыеЭлементы[0];
		ПараметрЭлемента = МодельОбъекта.ПараметрыЭлементов[ИдентификаторПараметраЭлемента];
		Если ЗначениеЗаполнено(ПараметрЭлемента.Свойство) Тогда
			Возврат Новый Структура("Представление, Тип", ПараметрЭлемента.Свойство, 2);
		КонецЕсли;
	КонецЕсли;
	//  Это параметр
	Возврат Новый Структура("Представление, Тип", Параметр.Имя, 0);
КонецФункции

&НаКлиенте
Асинх Процедура КомандаВыбратьОкно(Команда)
	Перем ПараметрыСостояния;
	Перем ЭлементыФормы;
	ПараметрыСостояния = Новый Соответствие;
	ЭлементыФормы = Новый Соответствие;
	СписокОкон = Новый СписокЗначений();
	Для Каждого ТекущееОкно Из ПолучитьОкна() Цикл
		Если ТекущееОкно.Содержимое.ВГраница() = -1 Тогда
			Продолжить;
		КонецЕсли;
		СписокОкон.Добавить(ТекущееОкно, ТекущееОкно.Заголовок);
	КонецЦикла;
	Выбор = Ждать СписокОкон.ВыбратьЭлементАсинх();
	Если Выбор = Неопределено Тогда
		Возврат;
	КонецЕсли;
	ВыбраннаяФорма = Выбор.Значение.Содержимое[0];
	ЗаголовокВыбранногоОкна = Выбор.Значение.Заголовок;
	Объект.ПараметрыСостояния.Очистить();
	Объект.СвязиПараметров.Очистить();
	МодельОбъекта = РаботаСМодельюОбъектаКлиентСервер.ПолучитьМодель(ВыбраннаяФорма);
	//  ТипПараметра: 0 - Параметр, 1 - признак, 2 - свойство
	//  Параметры состояния		
	Для Каждого ЭлементПараметра Из МодельОбъекта.ПараметрыСостояния Цикл
		Параметр = ЭлементПараметра.Значение;
		СтрокаПараметрыСостояния = Объект.ПараметрыСостояния.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаПараметрыСостояния, Параметр);
		ЗаполнитьЗначенияСвойств(СтрокаПараметрыСостояния, СвойстваПараметра(МодельОбъекта, Параметр));
		СтрокаПараметрыСостояния.ИД = СтрокаПараметрыСостояния.ПолучитьИдентификатор();
		СтрокаПараметрыСостояния.ПриведенноеИмя = СтрЗаменить(СтрокаПараметрыСостояния.Имя, ".", "");
		ПараметрыСостояния[ЭлементПараметра.Значение.Имя] = СтрокаПараметрыСостояния;
	КонецЦикла;
	//  Связи параметров
	Для Каждого ЭлементСвязи Из МодельОбъекта.СвязиПараметров Цикл
		Связь = ЭлементСвязи.Значение;
		СтрокаСвязи = Объект.СвязиПараметров.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаСвязи, Связь);
		СтрокаСвязи.ПараметрСостояния = ЭлементСвязи.Значение.ПараметрСостояния.Имя;
		СтрокаСвязи.Параметр = ЭлементСвязи.Значение.Параметр.Имя;
		Если ПараметрыСостояния[СтрокаСвязи.Параметр].Тип = 0 Тогда
			СтрокаСвязи.Представление = ?(СтрокаСвязи.Параметр = СтрокаСвязи.ПутьКДанным, "", СтрокаСвязи.ПутьКДанным);
		КонецЕсли;		
		СтрокаСвязи.ИДПараметраСостояния = ПараметрыСостояния[СтрокаСвязи.ПараметрСостояния].ИД;
		СтрокаСвязи.ИДПараметра = ПараметрыСостояния[СтрокаСвязи.Параметр].ИД;
		Если Связь.ПараметрИспользование <> Неопределено Тогда
			СтрокаСвязи.ПараметрИспользование = Связь.ПараметрИспользование.Имя;
		КонецЕсли;
	КонецЦикла;
	//  Элементы формы
	Для Каждого ЭлементЭлементаФормы Из МодельОбъекта.ЭлементыФормы Цикл
		ЭлементФормы = ЭлементЭлементаФормы.Значение;
		СтрокаЭлементаФормы = Объект.ЭлементыФормы.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаЭлементаФормы, ЭлементФормы);
		Если ЗначениеЗаполнено(ЭлементФормы.Параметр) Тогда
			СтрокаЭлементаФормы.Параметр = ЭлементФормы.Параметр.Имя;
			СтрокаЭлементаФормы.ИДПараметра = ПараметрыСостояния[СтрокаЭлементаФормы.Параметр].ИД;
		КонецЕсли;
		СтрокаЭлементаФормы.ИД = СтрокаЭлементаФормы.ПолучитьИдентификатор();
		СтрокаЭлементаФормы.ПриведенноеИмя = СтрЗаменить(СтрокаЭлементаФормы.Имя, ".", "");
		ЭлементыФормы[СтрокаЭлементаФормы.Имя] = СтрокаЭлементаФормы;
	КонецЦикла;
	//  Параметры элементов
	Для Каждого ЭлементПараметраЭлементов Из МодельОбъекта.ПараметрыЭлементов Цикл
		ПараметрЭлемента = ЭлементПараметраЭлементов.Значение;
		СтрокаЭлементаПараметраЭлементов = Объект.ПараметрыЭлементов.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаЭлементаПараметраЭлементов, ПараметрЭлемента);
		СтрокаЭлементаПараметраЭлементов.Параметр = ПараметрЭлемента.Параметр.Имя;
		СтрокаЭлементаПараметраЭлементов.ИДПараметра = ПараметрыСостояния[СтрокаЭлементаПараметраЭлементов.Параметр].ИД;
		Если ПустаяСтрока(СтрокаЭлементаПараметраЭлементов.Свойство) Тогда
			СтрокаЭлементаПараметраЭлементов.Представление = ?(СтрокаЭлементаПараметраЭлементов.Параметр = СтрокаЭлементаПараметраЭлементов.ПутьКДанным, "", СтрокаЭлементаПараметраЭлементов.ПутьКДанным);						
		КонецЕсли;
		СтрокаЭлементаПараметраЭлементов.Элемент = ЭлементПараметраЭлементов.Значение.Элемент.Имя;
		СтрокаЭлементаПараметраЭлементов.ИДЭлемента = ЭлементыФормы[СтрокаЭлементаПараметраЭлементов.Элемент].ИД;
	КонецЦикла;
	Объект.ПараметрыСостояния.Сортировать("Имя");
	Объект.СвязиПараметров.Сортировать("ПараметрСостояния, Параметр");
	Объект.ЭлементыФормы.Сортировать("Имя");
	Объект.ПараметрыЭлементов.Сортировать("Элемент, Свойство, Параметр");
КонецПроцедуры

&НаКлиенте
Процедура КомандаСинхронизироватьПараметры(Команда)
	ШаблонОбъекта = Новый Структура;
	ШаблонОбъекта.Вставить("СвязатьПараметры", НЕ СвязатьПараметры);
	ИзмененныеПараметры = РаботаСМодельюОбъектаКлиентСервер.Заполнить(ЭтотОбъект, ШаблонОбъекта);
	ПриИзмененииНаСервере(ИзмененныеПараметры);
КонецПроцедуры

&НаКлиенте
Процедура КомандаСинхронизироватьЭлементы(Команда)
	ШаблонОбъекта = Новый Структура;
	ШаблонОбъекта.Вставить("СвязатьЭлементы", НЕ СвязатьЭлементы);
	ИзмененныеПараметры = РаботаСМодельюОбъектаКлиентСервер.Заполнить(ЭтотОбъект, ШаблонОбъекта);
	ПриИзмененииНаСервере(ИзмененныеПараметры);
КонецПроцедуры

&НаКлиенте
Процедура КомандаНайтиСоответствиеПараметра(Команда)
	ТекущаяСтрока = Элементы.СвязиПараметров.ТекущаяСтрока;
	Если ТекущаяСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;
	ДанныеСтроки = Объект.СвязиПараметров.НайтиПоИдентификатору(ТекущаяСтрока);
	ИДПараметраСостояния = ДанныеСтроки.ИДПараметраСостояния;
	НайденныеСтроки = Объект.ПараметрыСостояния.НайтиСтроки(Новый Структура("ИД", ИДПараметраСостояния));
	Элементы.ПараметрыСостояния.ТекущаяСтрока = НайденныеСтроки[0].ПолучитьИдентификатор(); 
КонецПроцедуры

&НаКлиенте
Процедура КомандаНайтиСоответствиеЭлемента(Команда)
	ТекущаяСтрока = Элементы.ПараметрыЭлементов.ТекущаяСтрока;
	Если ТекущаяСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;
	ДанныеСтроки = Объект.ПараметрыЭлементов.НайтиПоИдентификатору(ТекущаяСтрока);
	ИДЭлемента = ДанныеСтроки.ИДЭлемента;
	НайденныеСтроки = Объект.ЭлементыФормы.НайтиСтроки(Новый Структура("ИД", ИДЭлемента));
	Элементы.ЭлементыФормы.ТекущаяСтрока = НайденныеСтроки[0].ПолучитьИдентификатор(); 
КонецПроцедуры

&НаКлиенте
Процедура КомандаТест(Команда)
	КомандаТестНаСервере();
КонецПроцедуры

&НаСервере
Функция НайтиПодчиненныеЭлементы(Родитель)
	НайденныеЭлементы = Новый Массив;
	Для Каждого Элемент Из Родитель.ПодчиненныеЭлементы Цикл
		ТипЭлемента = ТипЗнч(Элемент);
		Если ТипЭлемента = Тип("ПолеФормы") Тогда
			НайденныеЭлементы.Добавить(Элемент.Имя);
			Продолжить;
		КонецЕсли;
		ОбщегоНазначенияКлиентСервер.ДополнитьМассив(НайденныеЭлементы, НайтиПодчиненныеЭлементы(Элемент), Истина);
	КонецЦикла;
	Возврат НайденныеЭлементы;
КонецФункции

&НаСервере
Процедура НайтиЭлементы()
	НайденныеЭлементы = Новый Массив;
	Для Каждого Элемент Из Элементы Цикл
		ТипЭлемента = ТипЗнч(Элемент);
		Если ТипЭлемента = Тип("ТаблицаФормы") Тогда
			ОбщегоНазначенияКлиентСервер.ДополнитьМассив(НайденныеЭлементы, НайтиПодчиненныеЭлементы(Элемент), Истина);
		КонецЕсли;
	КонецЦикла;
	Сообщить(НайденныеЭлементы);
КонецПроцедуры

&НаСервере
Процедура КомандаТестНаСервере()
	НайтиЭлементы();
КонецПроцедуры




