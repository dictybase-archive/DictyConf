$(function(){
	$('#conference-info').editable({
		url: '/post',
		title: 'Enter conference info',
		rows: 10
	});
});

$.mockjax({
	url: '/post',
	responseTime: 200,
	response: function(settings) {
		console.log(settings);
	}
}); 
