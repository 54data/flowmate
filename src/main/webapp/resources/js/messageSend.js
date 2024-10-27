$(document).ready(function() {
    $(document).on('click', '.send', function() {
		window.open('/flowmate/message/messageSend','_blank', 'width=600, height=400, scrollbars=no');
    });
	
	$(document).on('click', '.add-attachment', function () {
		$('.message-file-input').trigger('click');
	});
	
	$(document).on('click', '.file-input-btn', function() {
		$('.message-file-input').trigger('click');
	});
	
	handler.init();
	handler.removeFile();

	
	$('.reciver-select').select2({
		width: '100%',
        placeholder: '할당되지 않음',
        allowClear: true,
        dropdownParent: $('#sendMessage'),
        closeOnSelect: false
	});
	

});

const handler = {
		init() {
			const fileInput = $('.message-file-input');
			const preview = $('.file-preview');
			
			$(document).on('change', '.message-file-input', function() {
				console.dir(fileInput);
				const files = Array.from(this.files);
				console.log(files)
				files.forEach(file => {
					console.log(file.name)
					console.log('Last Modified:', file.lastModified);
					preview.append(
						`<div class="message-file d-inline-flex me-2 mt-2 align-items-center p-2 px-3 border" id="${file.lastModified}">
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
				const files = $('.message-file-input')[0].files;
				const dataTransfer = new DataTransfer();
				
		        Array.from(files)
		            .filter(file => file.lastModified != removeTargetId)
		            .forEach(file => {
		                dataTransfer.items.add(file);
		            });
		        $('.message-file-input')[0].files = dataTransfer.files;
		        removeTarget.remove();
			});
		}
};		