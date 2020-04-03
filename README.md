# README

Заготовка для разработки

Функцинальные возможности:

* User - аутентификация через Device, с подтверждением почтового аккаунта.

* Аутентификация через социальные сети с использованием модуля omniauth. Сейчас работает аутентификация через VK, GitHub, FaceBook

* Раздача прав доступа через cancan. Настройка на изменение собственных объектов и просмотр всех остальных кроме User. User просматривает только создатель.

* Настройка routes на различный набор маршрутов при аутентификации пользователя и без неё

* Подключен active_store

* Модели Gallery + Picture с сохранением картинок в active_store

* Тэгирование объектов. Модель Tag и концерн taggable_concern

* Модель Blog для построения любых текстовых заметок

* Модель Article для постороения списка товаров и услуг

* Подключен ElasticSearch для организации полнотекстового поиска. Настроены модели Blog и Article

* Выставление оценок и оставление отзывов о любом объекте. Модели Grade, GradeAverage (усреднённая оценка по разным пользователям)
grade_concern для подключения к объектам возможности выставлять оценки

* ActiveAdmin для управления и администрирования

* Базовый контроллер ApplicationController. Обрабатывает основные критические ошибки, предоставляет CRUD.

* Контроллер Grade для расчёта средних значений по оценкам объектов

* Контроллер Article, предоставлет CRUD

* Контроллеры Gallery, Picture, User

* HomeController - root страница для не аутентифицированного доступа

* SecretController - root страница после аутентификации

* React, подключен react-rails. Пример компонента в javascript/components

## React
Для создание нового компонента проще использовать генератор 
  rails g react:component HelloWorld greeting:string

The generator also accepts options:

  --es6: use class ComponentName extends React.Component
  
  --coffee: use CoffeeScript

## GradeAverage и Grade
Подробно описаны в исходниках.

К модели, на которую хотим выставлять оценки подключить концерн GradeConcern

Типы оценок выставить под требования в массие GRADE_TYPES в GradeConstConcern.
Для того, чтобы типы оценок выводить в нужной локали нужно выставить в файле human_attribute_value.ru.yml 
их соответствия.

## Tag
Тэги также имеют типы.

Для использования тэгов для пометки объектов используются тэги с типом ordinal

Также тэги могут быть использованы для группировки объектов по каким-либо признакам. Например по категориям.
Список типов надо отредактировать под требования в массиве Tags::TAG_TYPES. Тип ordinal надо в массиве оставить.

Для подключения тэгирования к любой модели нужно подключить к ней концерн TaggableConcern

## Article
Модель для описания представляемого товара или услуги
Типы Article устанавливаются в массиве ARTICLE_TYPES и сейчас имеют два типа - услуга и товар
Для их локализованного вывода надо использовать human_attribute_value(:article_type)

Article имеет состояние. 
Список состояний, при необходимости, нужно актуализовать в массиве ARTICLE_STATES. 
Сейчас состояния: 

* активно
* удалено
* черновик

Для их локализованного вывода надо использовать human_attribute_value(:state)

Позволяет устанавливать аттрибуты:
* min/max количество
* min/max возраст участсников
* продолжительность

Подключен поиск по русскому тексту через ElasticSearch по полям name, main_description, short_description
Поиск настроен на максимальное совпадение с введённой строкой
Для поиска надо использовать Article.search(строка для поиска)

Может иметь одну основную картинку main_image
Также, можно подключить gallery, содержащую дополнительные картинки.

Если требуется выставлять оценки на Article, то подключите к модели 
include GradeConcern

## Sproket и натягивание шаблона

Если шаблон специально не адаптирован под Webpacker, то быстрее использовать Sproket
Порядок действий примерно следующий:
* Берём чистый мастер без добавления туда JQuery или Bootstrap. У шаблона их версия может отличаться.
* Всю директорию шаблона копируем в app\assets без изменений. Т. е. вместо с картинками и java скриптами.
* В файл assets/stylesheets/application.css добавляем зависимости, а именно, указываем путь к 
директории шаблона. Маршрут относительно директории assets/stylesheets
Например:

  *= require_tree .
   
  *= require_tree ../corlate_assets
  
  *= require_self
  
* Ф файл application.html.erb присоединяем эти стили через хелпер
 
 <%= stylesheet_link_tag 'application', media: "all" %>
 
 Этого достаточно. Все завсимости указываются в файле application.css, сюда не надо копировать все
 \<link href="css/ из файла шаблона
 
* В файл assets/config/manifest.js добавляем две ссылки на директории со стилями и js

//= link_directory ../corlate_assets/css .css

//= link_directory ../corlate_assets/js .js

 _возможно это не обязательно._
 

* Все java скрипты, указанные в шаблоне, подключаются к нужным view 
(в первую очередь к application.html.erb) через хелпер

<%= javascript_include_tag('js/jquery.js') %>

* Также, все java скрипты надо добавить в файл config/initializers/assets.rb в массив Rails.application.config.assets.precompile

Например:

Rails.application.config.assets.precompile += %w( js/jquery.js js/bootstrap.min.js js/jquery.prettyPhoto.js js/owl.carousel.min.js js/jquery.isotope.min.js js/main.js)

* Во view все img заменяем на image_tag

* Все ссылки во view на статические ресурсы типа url('image.png') дополняем asset_url, т. е. получится
url(<%= asset_url('image.png') %>)


## WebPacker

### Подключение картинок

* Весь статический медиа контент кладём в папку images. Можно разбить её на подпапки.

* Для формирования правильных URL из view нужно использовать хелпер asset_pack_path

Например:

<link rel="shortcut icon" type="image/x-icon" href="<% asset_pack_path 'media/images/favicon.ico' %>" />

При этом, префикс маршрута media/ надо добавлять в ручную.

* Для вывода картинок использовать хелпер image_pack_tag
Например:

<%= image_pack_tag 'media/images/libra/libra-logo1.png', title: 'Libra',  alt: 'Libra' %>

Правильный маршрут до картинки можно найтив файле manifest.json


### Подключение css

* Сам файл со стилями клад]м в папку javascript/styles. Можно в ней сделать вложенные папки для структурированного представления

* В файл application.js добавляет строчку для включения этого стиля в процесс компиляции

Например: import('../styles/libra/css/reset');
          import('../styles/libra/css/bootstrap');
При этом, расширение файла не указываем.

* Можно включать css, scss, sass

* В файл view, например application.html.erb, подключаем эти файлы с использованием хелперов stylesheet_pack_tag

Например: 

<%= stylesheet_pack_tag 'libra/css/reset', media: 'all', 'data-turbolinks-track': 'reload' %>

* Чтобы проверить, что файлы нормально подключены можно запустить компиляцию:

bundle exec rails assets:precompile

Если всё хорошо, то процесс не выдаст ошибок

### Маршруты к медиа ресурсам в файлах css

* Если в файлах стилей встречаются маршруты вида url('маршрут'), то их, при необходимости, надо модифицировать

Никаких хелперов добавлять не надо. Просто сам маршрут до требуемого объекта должен быть относительным и строиться от 
места, где лежит сам файл стиля.

Например:

background: url('../../images/libra/slider/slider-shadow.png') no-repeat scroll center top transparent;
     