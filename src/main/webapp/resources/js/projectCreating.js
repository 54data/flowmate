$(document).ready(function() {
	$(document).on('click', '.add-attachment', function () {
		$('.project-file-input').trigger('click');
	});
	
	$(document).on('click', '.file-input-btn', function() {
		$('.project-file-input').trigger('click');
	});
	
	handler.init();
	handler.removeFile();
	
	$('#startDatepicker').datepicker({
		calendarWeeks: false,
		todayHighLight: true,
		autoclose: true,
		format: 'yyyy-mm-dd',
		language: 'ko'
	});
	
	$('#endDatepicker').datepicker({
		calendarWeeks: false,
		todayHighLight: true,
		autoclose: true,
		format: 'yyyy-mm-dd',
		language: 'ko'
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

var multipleCancelButton = new Choices('#choices-multiple-remove-button', {
	removeItemButton: true,
	maxItemCount: 3,
	searchResultLimit: 5,
	renderChoiceLimit: 5 
});