$(function(){
   $(".btn-menu").sideNav({
        menuWidth: 300, // Default is 300
        edge: 'right', // Choose the horizontal origin
        closeOnClick: true, // Closes side-nav on <a> clicks, useful for Angular/Meteor
        draggable: true
   }); 
   
   $('.slider').slider({
      indicators: false
   });
   
   $('.slider').slider('start');
});