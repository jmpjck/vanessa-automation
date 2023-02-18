﻿#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВыполнитьКодКлиент(Команда)
	
	Если Прав(НРег(СокрП(ПутьКОбработке)), 4) = ".epf" Тогда
		ЭтоОбработка = Истина;
	КонецЕсли;	
	
	ПомещаемыеФайлы = Новый Массив;
	ИменаФайлов = Новый Соответствие;
	ПутьКФайлу = ПутьКОбработке;
	ПомещаемыйФайл = Новый ОписаниеПередаваемогоФайла(ПутьКФайлу);
	ПомещаемыеФайлы.Добавить(ПомещаемыйФайл);
	ИменаФайлов.Вставить("ИмяФайла",ПутьКФайлу);
	
	ПараметрыЗавершения = Новый Структура();
	ПараметрыЗавершения.Вставить("ИменаФайлов",ИменаФайлов);
	ОписаниеОповещения = Новый ОписаниеОповещения("ОбработчикПодключенияПриОткрытии", ЭтаФорма, ПараметрыЗавершения);
	НачатьПомещениеФайлов(ОписаниеОповещения, ПомещаемыеФайлы,, Ложь, ЭтаФорма.УникальныйИдентификатор);

КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьФорму(Команда)
	Закрыть();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОбработчикПодключенияПриОткрытии(Знач ПомещенныеФайлы, Знач ДополнительныеПараметры) Экспорт
	
	ЕстьЗащитаОтОпасныхДействий = ЕстьЗащитаОтОпасныхДействий();
	
	Для Каждого ПомещенныйФайл Из ПомещенныеФайлы Цикл
		ДополнительныеПараметрыПодключения = Новый Структура;
		ДополнительныеПараметрыПодключения.Вставить("АдресХранилища",ПомещенныйФайл.Хранение);
		ДополнительныеПараметрыПодключения.Вставить("ИмяФайла",ДополнительныеПараметры.ИменаФайлов["ИмяФайла"]);
		ИмяОбработки = ПодключитьВнешнююОбработкуСервер(ПомещенныйФайл.Хранение,ЕстьЗащитаОтОпасныхДействий,ДополнительныеПараметрыПодключения);
		
		ПодключениеОбработкиПродолжение(ИмяОбработки);
	КонецЦикла;	 
КонецПроцедуры

&НаСервере
Функция ПодключитьВнешнююОбработкуСервер(Знач АдресХранилища,ИспользуетсяЗащитаОтОпасныхДействий,ДополнительныеПараметры = Неопределено) Экспорт
	ИмяОбработки = Неопределено;
	
	Если ЭтоОбработка Тогда
		ОМ = ВнешниеОбработки;
	Иначе	
		ОМ = ВнешниеОтчеты;
	КонецЕсли;	
	
	Если ИспользуетсяЗащитаОтОпасныхДействий Тогда
		ОписаниеЗащитыОтОпасныхДействий = Вычислить("Новый ОписаниеЗащитыОтОпасныхДействий");
		ОписаниеЗащитыОтОпасныхДействий.ПредупреждатьОбОпасныхДействиях = Ложь;
		
		Если ТипЗнч(ДополнительныеПараметры) = Тип("Структура") Тогда
			Если ДополнительныеПараметры.Свойство("АдресХранилища") Тогда
				ИмяОбработки = ОМ.Подключить(ДополнительныеПараметры.АдресХранилища, , Ложь, ОписаниеЗащитыОтОпасныхДействий);
			Иначе	
				ИмяОбработки = ОМ.Подключить(АдресХранилища, , Ложь, ОписаниеЗащитыОтОпасныхДействий);
			КонецЕсли;	 
		КонецЕсли;	 
		
		Возврат ИмяОбработки;
	Иначе	
		Если ДополнительныеПараметры.Свойство("АдресХранилища") Тогда
			ИмяОбработки = ОМ.Подключить(ДополнительныеПараметры.АдресХранилища, , Ложь); 
		Иначе	
			ИмяОбработки = ОМ.Подключить(АдресХранилища, , Ложь); 
		КонецЕсли;	 
		Возврат ИмяОбработки;
	КонецЕсли;	 
КонецФункции 

&НаСервереБезКонтекста
Функция ЕстьЗащитаОтОпасныхДействий()
	СистемнаяИнформация = Новый СистемнаяИнформация;
	Массив1 = СтрРазделить(СистемнаяИнформация.ВерсияПриложения, ".");
	Массив2 = СтрРазделить("8.3.9.2033", ".");
	
	Версия1БольшеИлиРавно = Истина;
	Для Ккк = 0 По Массив1.Количество() - 1 Цикл
		Элем1 = Массив1.Получить(Ккк);
		Элем2 = Массив2.Получить(Ккк);
		
		Если Число(Элем2) > Число(Элем1) Тогда
			Версия1БольшеИлиРавно = Ложь;
		КонецЕсли;	 
	КонецЦикла;
	
	Возврат Версия1БольшеИлиРавно;
КонецФункции

&НаКлиенте
Процедура ПодключениеОбработкиПродолжение(ИмяОбработки)
	
	ПараметрыОбработки = Новый Структура;
	Если ЗначениеЗаполнено(ЗначениеИмяФормы) Тогда
		ОткрытьФорму("ВнешняяОбработка." + ИмяОбработки + ".Форма" + ЗначениеИмяФормы, ПараметрыОбработки);
	Иначе	
		ОткрытьФорму("ВнешняяОбработка." + ИмяОбработки + ".Форма", ПараметрыОбработки);
	КонецЕсли;
	
	Закрыть();
	
КонецПроцедуры 

#КонецОбласти