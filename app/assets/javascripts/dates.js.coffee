$ ->
  date = new Date
  year = date.getFullYear.toString
  month = date.getMonth.toString
  day = date.getDate.toString
  dateString = month + '/' + day + '/' + year

  $("[data-behaviour~=datepicker]").datepicker
    altFormat: "yy-mm-dd"
    dateFormat: "mm/dd/yy"
    altField: $(this).next()
    autoclose: true
    startView: 'decade'
    endDate: dateString
    language: 'ru'
