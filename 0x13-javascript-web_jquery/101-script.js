$(document).ready(function(){
  let counter = 0;
  $('#add_item').click(function(){
    counter += 1;
    $('.my_list').append('<LI>Item</LI>');
  });
  $('#remove_item').click(function(){
    $('.my_list li').eq(counter).remove();
    counter -= 1;
  });
  $('#clear_list').click(function(){
    counter = 0;
    $('.my_list').empty();
  });
});
