
///------------------------------------------------------------------------///
///-------------------------------about------------------------------------///
$(function(){

$(".modalOpen").click(function(){
    var navClass = $(this).attr("class"),
    href = $(this).attr("href");

    $(href).fadeIn();
    $(this).addClass("open");
    //cssアニメーションの記述を追加する
    $(href).children(".inner").css("animation","modal 0.5s forwards");
    return false;
});

$(".modalClose").click(function(){
     $(this).parents(".modal").fadeOut();
     //$(".inner").fadeOut();
     $(".modalOpen").removeClass("open");
     //cssアニメーションの記述を追加する
      $(this).parents(".modal").children(".inner").css("animation","modalClose 0.5s forwards");
      return false;
});
});


///------------------------------------------------------------------------///
///-------------------------------works------------------------------------///
$(function() {
  var $win = $(window),
      $header = $('header'),
      animationClass = 'active';

  $win.on('load scroll', function() {
    var value = $(this).scrollTop();
    if ( value > 100 ) {
      $header.addClass(animationClass);
    } else {
      $header.removeClass(animationClass);
    }
  });
});
