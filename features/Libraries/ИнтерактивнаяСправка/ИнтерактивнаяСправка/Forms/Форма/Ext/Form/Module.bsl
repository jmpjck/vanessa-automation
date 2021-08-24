﻿
///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

&НаКлиенте
// контекст фреймворка Vanessa-Automation
Перем Ванесса;
 
&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Automation.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,ОписаниеШага,ТипШага,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯСпрашиваюИмяУченикаЕслиОноНеЗадано()","ЯСпрашиваюИмяУченикаЕслиОноНеЗадано","И я спрашиваю имя ученика если оно не задано","","");

	Возврат ВсеТесты;
КонецФункции
	
&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции
	
&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Функция выполняется перед началом каждого сценария
Функция ПередНачаломСценария() Экспорт
	
КонецФункции

&НаКлиенте
// Функция выполняется перед окончанием каждого сценария
Функция ПередОкончаниемСценария() Экспорт
	
КонецФункции



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//И я спрашиваю имя ученика если оно не задано
//@ЯСпрашиваюИмяУченикаЕслиОноНеЗадано()
Процедура ЯСпрашиваюИмяУченикаЕслиОноНеЗадано() Экспорт
	
	Если КонтекстСохраняемый.Свойство("ИмяУченика") Тогда
		Если ЗначениеЗаполнено(КонтекстСохраняемый.ИмяУченика) Тогда
			Возврат;
		КонецЕсли;	 
	КонецЕсли;	 
	
	Ванесса.ВоспроизвестиФразуАсинхронно("Чтобы продолжить укажите ваше имя, пожалуйста.");
	
	Ванесса.ЗапретитьВыполнениеШагов();
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПослеВводаИмениУченика", ЭтаФорма);
	ПоказатьВводСтроки(ОписаниеОповещения, , "Введите ваше имя");
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВводаИмениУченика(ИмяУченика, ДопПараметры) Экспорт
	
	Если ЗначениеЗаполнено(ИмяУченика) Тогда
		КонтекстСохраняемый.Вставить("ИмяУченика", ИмяУченика);
	Иначе	
		КонтекстСохраняемый.Вставить("ИмяУченика", "Ученик");
	КонецЕсли;	 
	
	Ванесса.ПродолжитьВыполнениеШагов();
	
КонецПроцедуры
