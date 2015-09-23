function sign_up_premium(){
  console.log("hello world2");
  Cookies.set('sign_up', 'premium', { expires: 1 });
  window.location.replace("/users/sign_up");
}

$(document).ready(function(){
  console.log(Cookies.get('sign_up'));
  $("a#sign_up_premium").click(sign_up_premium);
});
