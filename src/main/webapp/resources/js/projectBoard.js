$(document).ready(function() {
	if ($('.project-progress-bar-width').data('rate') === '0.0') {
		$('.project-progress-bar-width').css('width', '100%');
		$('.project-progress-bar-width').attr('style', function(i, style) {
		    return style + 'background-color: #c7c7c7 !important;';
		});
		$('.project-progress-bar-width').text('0%');
	};
	
	const urlParams = new URLSearchParams(window.location.search);
    const issueId = urlParams.get('issueId');

    if (issueId) {
    	$('.show-issue-modal').data('triggeredBy', 'read');
        $('.show-issue-modal').data('issueId', issueId);
        $('.show-issue-modal').trigger('click');
        const newUrl = `${window.location.origin}${window.location.pathname}?projectId=${projectId}`;  // URL을 projectId를 포함한 형태로 업데이트
        window.history.replaceState(null, null, newUrl);
    }
});