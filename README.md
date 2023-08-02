# Задание:
## Суть:
Небольшой сайт, который состоит из текстовых страниц, организованных в иерархию. То есть, одна страница может быть подстраницей другой страницы.

## На главной странице расположено дерево страниц сайта:
- страница
  - подстраница
  - подстраница
    - подподстраница
- страница

## Каждая страница описывается следующими полями:
- имя страницы - строка, удовлетворяет условию [a-zA-Z0-9_], ДОПУСТИМЫ РУССКИЕ СИМВОЛЫ
- заголовок страницы - произвольная строка
- текст страницы - произвольный текст, в котором может присутствовать html-разметка.

## Адресная схема мини-сайта:

[site]/name1/name2/name3
  - открывается страница с именем name3, которая является под-странице страницы name2, которая является под-страницей страницы name1. На странице виден её текст и заголовок, а также поддерево всех её подстраниц.

[site]/name1/name2/name3/edit
  - страница открывается в режиме редактирования - можно редактировать заголовок и текст. После сохранения нужно делать редирект на адрес [site]/name1/name2/name3.

[site]/name1/name2/name3/add
  - форма добавления подстраницы к текущей странице, можно задать имя, заголовок и текст. После добавления нужно делать редирект на адрес [site]/name1/name2/name3/[новое имя].

[site]/add
  - форма добавления корневой страницы.

## Форматирование
При сохранении или добавлении текст страниц должен подвергаться следующим преобразованиям:
  - *[строка]* => <b>[строка]</b> (выделение жирным)
  - \\[строка]\\ => <i>[строка]</i> (выделение курсивом)
  - ((name1/name2/name3 [строка])) преобразовывать в ссылку на страницу [site]name1/name2/name3: <a href="[site]name1/name2/name3">[строка]</a>. Однако, при редактировании страницы пользователь должен править неформатированный текст.

Реализовать это всё нужно на Rails >= 4.0, Ruby >= 2.2.
Время отдачи любой из страниц вида [site]/name1/name2/ не должно превышать 100ms.

## Обращать внимание на:
  - архитектуру приложения
  - читаемость кода
  - комментирование кода
  - безопасность кода
  - дизайн не важен
