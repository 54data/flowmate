$(document).ready(function() {
	if ($('.project-progress-bar-width').data('rate') === '0.0') {
		$('.project-progress-bar-width').css('width', '100%');
		$('.project-progress-bar-width').attr('style', function(i, style) {
		    return style + 'background-color: #c7c7c7 !important;';
		});
		$('.project-progress-bar-width').text('0%');
	};
});