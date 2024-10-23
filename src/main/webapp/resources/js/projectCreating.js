$(document).ready(function() {
	$(document).on('click', '.add-attachment', function () {
		$('.project-file-input').trigger('click');
	});
	
	$(document).on('click', '.file-input-btn', function() {
		$('.project-file-input').trigger('click');
	});
	
	handler.init();
	handler.removeFile();
	
	$('.project-team-select').select2({
		width: '100%',
        placeholder: '할당되지 않음',
        allowClear: true,
        dropdownParent: $('#projectCreating'),
        closeOnSelect: false
	});
	
	$('.project-step').select2({
		width: '100%',
        dropdownParent: $('#projectCreating'),
        tags: true
	});
	
	$('[id$=daterangepicker]').daterangepicker({
        "locale": {
            "format": "YYYY-MM-DD",
            "separator": " ~ ",
            "applyLabel": "확인",
            "cancelLabel": "취소",
            "fromLabel": "From",
            "toLabel": "To",
            "customRangeLabel": "Custom",
            "weekLabel": "W",
            "daysOfWeek": ["월", "화", "수", "목", "금", "토", "일"],
            "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
            "firstDay": 1
        },
        "startDate": "2024-10-07",
        "endDate": "2024-11-25",
        "drops": "down"
    }, function (start, end, label) {
        console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
    });
	
    $('[id$=issueState]').click(function() {
        const status = $(this).text();
        $('.issue-state-btn').text(status);

        const color = $(this).data('color');
        $('.issue-state-btn').css('color', color);
    });
    
    $('[id$=projectStatus]').on('click', function() {
        var status = $(this).data('status');
        var color = $(this).data('color');
        
        $('#projectStatusButton').text(status); 
        $('#projectStatusButton').removeClass('btn-info btn-warning btn-success').addClass('btn-' + color);
    });
    
    $(document).on('click', '.project-step-close', function() {
        $(this).closest('.d-flex').remove();
    });
});

const handler = {
	init() {
		const fileInput = $('.project-file-input');
		const preview = $('.file-preview');
		
		$(document).on('change', '.project-file-input', function() {
			console.dir(fileInput);
			const files = Array.from(this.files);
			files.forEach(file => {
				preview.append(
					`<div class="project-file d-inline-flex me-2 mt-2 align-items-center p-2 px-3 border" id="${file.lastModified}">
						${file.name}
						<button type="button" class="file-remove btn-close ms-2" data-index="${file.lastModified}"></button>
					</div>`);
			});
		});
	},
	 
	removeFile() {
		$(document).on('click', (e) => {
			if (!$(e.target).hasClass('file-remove')) return;
			const removeTargetId = $(e.target).data('index');
			const removeTarget = $('#' + removeTargetId);
			const files = $('.project-file-input')[0].files;
			const dataTransfer = new DataTransfer();
			
	        Array.from(files)
	            .filter(file => file.lastModified != removeTargetId)
	            .forEach(file => {
	                dataTransfer.items.add(file);
	            });
	        $('.project-file-input')[0].files = dataTransfer.files;
	        removeTarget.remove();
		});
	}
};