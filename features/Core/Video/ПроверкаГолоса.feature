﻿# language: ru
# encoding: utf-8
#parent uf:
@UF6_текстовые_и_видео_инструкции
#parent ua:
@UA40_проверять_формирование_видеоинструкций

@tree
@IgnoreOn82Builds
@IgnoreOnOFBuilds
@IgnoreOn836
@IgnoreOn837
@IgnoreOn838
@IgnoreOn839
@IgnoreOnWeb
@Video


Функционал: Проверка возможности сгенерировать mp3, чтобы тут же его прослушать


Сценарий: Проверка возможности сгенерировать mp3, чтобы тут же его прослушать
	Дано Я убедился что работает звуковой движок по созданию TTS
	Дано Я открываю VanessaAutomation в режиме TestClient
	
	
	И я перехожу к закладке с именем "ГруппаНастройки"
	И В открытой форме я изменяю флаг "Создавать видеоинструкцию"
	
	И Я заполняю настройки записи видео в TestClient
	
	И я нажимаю на кнопку с именем 'ТестГолосаОткрытьФалйTTS_В_ОС'
		
	И пауза 40

	И я завершаю выполнение процесса ОС "mpc-hc.exe"
	И я завершаю выполнение процесса ОС "mpc-hc64.exe"

	И я перехожу к закладке с именем "СтраницаСервисОсновные"
	И я устанавливаю флаг с именем 'ИспользоватьКомпонентуVanessaExt'
	И я перехожу к закладке с именем "СтраницаАвтоИнструкции"
	И Пауза 1
	
	И я нажимаю на кнопку с именем 'ТестГолосаПроизнести'
	И Пауза 20
		