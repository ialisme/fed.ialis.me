jQuery(document).ready(function ($) {
  var browserLang = (navigator.language || navigator.userLanguage || 'en-US').split('-')[0]
  var currentLang = $("meta[http-equiv=Content-Language]")[0].content
  var langs = $("link[hreflang]");
  var translations = $.map(langs, function(e) { return e.hreflang });
  if (browserLang !== currentLang) {
    if ($.inArray(browserLang, langs)) {
      var translation = $("link[hreflang=" + browserLang + "]")
      console.log("Lang has a translation!!", translation)
    }
  }
});
