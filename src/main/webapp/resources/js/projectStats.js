$(document).ready(function() {
	let resolvedIsu = 0;
	let unresolvedIsu = 0;
    let steps = [];
    let projectTaskStats = [];
    
    const centerTextPlugin = {
        id: 'centerText',
        beforeDraw: function(chart) {
            let width = chart.width,
                height = chart.height,
                ctx = chart.ctx;
            
            ctx.restore();

            let fontSize = (height / 230).toFixed(2);
            ctx.font = fontSize + "em Pretendard, sans-serif";
            ctx.fillStyle = 'rgba(0, 0, 0, 1)';
            ctx.textBaseline = "middle";
            ctx.textAlign = 'center';
            
            const stepIndex = chart.canvas.getAttribute('data-index');
            const stepName = steps[stepIndex].name;
            const progressText = steps[stepIndex].progress + "%";

            let legendHeight = 0;
            if (chart.legend) {
                legendHeight = chart.legend.height || 0;
            }
            let textX = width / 2;
            let textY = (height + legendHeight) / 2;
            let stepNameY = textY - 15;
            let progressTextY = textY + 15;

            ctx.fillText(stepName, textX, stepNameY);
            ctx.fillText(progressText, textX, progressTextY);

            ctx.save();
        }
    };

    $.ajax({
        url: '../../flowmate/project/getProjectStats',
        success: function(response) {
            steps = response.map(step => {
                return {
                    name: step.stepName,
                    completed: step.doneTaskCnt,
                    planned: step.tbTaskCnt,
                    onHold: step.holdTaskCnt,
                    inProgress: step.inprogressTaskCnt,
                    progress: step.stepProgress
                };
            });
            steps.forEach((step, index) => {
                createChart(step, index);
            });
            createCommonLegend();
        }
    });
    
    $.ajax({
        url: '../../flowmate/project/getIssueStats',
        success: function(response) {
            resolvedIsu = response.resolvedIsu;
            unresolvedIsu = response.unresolvedIsu;
            createBarChart();
        }
    });
    
    $.ajax({
        url: '../../flowmate/project/getProjectTaskStats',
        success: function(response) {
        	projectTaskStats = [
        		response.inprogressProjTaskCnt,
        		response.doneProjTaskCnt,
        		response.tbProjTaskCnt,
        		response.holdProjTaskCnt,
        		response.delayProjTaskCnt
        	];
        	createHalfChart(projectTaskStats);
        }
    });

    function createChart(step, index) {
        const data = [
            step.completed || 0,
            step.planned || 0,
            step.onHold || 0,
            step.inProgress || 0
        ];

        const chartData = {
            datasets: [{
                data: data,
                backgroundColor: [
                    'rgba(75, 191, 115, 0.8)', 
                    'rgba(52, 58, 64, 0.8)', 
                    'rgba(255, 171, 0, 0.8)',
                    'rgba(29, 122, 252, 0.8)'
                ],
                borderWidth: 1
            }],
            labels: ['완료', '예정', '보류', '진행 중']
        };

        const chartOptions = {
            responsive: true,
            maintainAspectRatio: false,
            cutout: '80%',
            animation: {
                duration: 1000
            },
            plugins: {
                datalabels: {
                    display: true
                },
                legend: {
                    display: false
                },
            },
            tooltip: {
                enabled: true,
                backgroundColor: 'rgba(0, 0, 0, 0.7)',
                titleFont: {
                    family: 'Pretendard, sans-serif',
                    size: 14
                },
                bodyFont: {
                    family: 'Pretendard, sans-serif',
                    size: 12
                }
            }
        };

        const chartContainer = document.createElement('div');
        chartContainer.classList.add('col-md-2', 'm-1');

        const cardBody = document.createElement('div');
        cardBody.classList.add('p-0');
        const canvas = document.createElement('canvas');
        canvas.style.height = '250px';
        canvas.style.width = '100%';
        canvas.setAttribute('data-index', index);
        cardBody.append(canvas);
        chartContainer.append(cardBody);
        
        $('#charts-container').append(chartContainer);

        const myChart = new Chart(canvas, {
            type: 'doughnut',
            data: chartData,
            options: chartOptions,
            plugins: [centerTextPlugin]
        });
    }
    
    function createHalfChart(projectTaskStats) {
    	const ctx = document.createElement('canvas');
        $('#bar-container > .delayTasks').append(ctx);
        const chartData = {
            datasets: [{
                data: projectTaskStats,
                backgroundColor: [
                    'rgba(29, 122, 252, 0.8)', 
                    'rgba(75, 191, 115, 0.8)', 
                    'rgba(52, 58, 64, 0.8)',
                    'rgba(255, 171, 0, 0.8)',
                    'rgba(255, 89, 89, 0.8)'
                ],
                borderWidth: 1
            }],
            labels: ['진행 중', '완료', '예정', '보류', '지연']
        };

        const chartOptions = {
            maintainAspectRatio: false,
            cutout: '80%',
            rotation: -90,
            circumference: 180,
            responsive: true,
            animation: {
                duration: 1000
            },
            plugins: {
            	datalabels: {
                    display: (context) => {
                        const value = context.dataset.data[context.dataIndex];
                        return value !== 0;
                    },
                    color: 'white',
                    font: {
                        family: 'Pretendard, sans-serif',
                        size: 12,
                        weight: 'bold'
                    },
                    formatter: (value, context) => {
                        const label = context.chart.data.labels[context.dataIndex];
                        return `${label}: ${value}건`;
                    },
                    backgroundColor: (context) => {
                        const bgColor = [
                            'rgba(29, 122, 252, 1)', 
                            'rgba(75, 191, 115, 1)', 
                            'rgba(52, 58, 64, 1)',
                            'rgba(255, 171, 0, 1)',
                            'rgba(255, 89, 89, 1)'
                        ];
                        return bgColor;
                    },
                    borderColor: 'white', 
                    borderWidth: 1,
                    borderRadius: 50,
                    textAlign: 'center',
                    align: 'center',
                    padding: 5,
                },
                legend: {
                    display: false
                },
                title: {
                    display: true,
                    text: '프로젝트 작업 처리 현황',
                    font: {
                        family: 'Pretendard, sans-serif',
                        size: 16,
                    },
                    color: 'rgba(0, 0, 0, 1)'
                },
            },
            tooltip: {
                enabled: false
            },
            afterDraw: function(chart) {
                const {ctx, chartArea: {top, bottom, left, right, width, height}} = chart;
                
                // 데이터가 모두 0인 경우
                const totalData = chart.data.datasets[0].data.reduce((a, b) => a + b, 0);
                
                if (totalData === 0) {
                    ctx.save();
                    ctx.font = '16px Pretendard, sans-serif';
                    ctx.fillStyle = 'rgba(0, 0, 0, 0.6)';
                    ctx.textAlign = 'center';
                    ctx.textBaseline = 'middle';
                    ctx.fillText('데이터 없음', width / 2, height / 2);
                    ctx.restore();
                }
            }
        };

        const myChart = new Chart(ctx, {
            type: 'doughnut',
            data: chartData,
            options: chartOptions,
            plugins: [ChartDataLabels, legendMargin]
        });
    }
    
    function createCommonLegend() {
        const legendContainer = document.createElement('div');
        legendContainer.classList.add('legend-container', 'p-2');
        legendContainer.style.display = 'flex';
        legendContainer.style.justifyContent = 'center';

        const legendLabels = ['완료', '예정', '보류', '진행 중'];
        const legendColors = [
            'rgba(75, 191, 115, 0.8)', 
            'rgba(52, 58, 64, 0.8)', 
            'rgba(255, 171, 0, 0.8)', 
            'rgba(29, 122, 252, 0.8)'
        ];

        legendLabels.forEach((label, index) => {
            const legendItem = document.createElement('div');
            legendItem.classList.add('legend-item');
            legendItem.style.display = 'flex';
            legendItem.style.alignItems = 'center';
            legendItem.style.marginLeft = '10px';
            legendItem.style.marginRight = '10px';

            const colorBox = document.createElement('div');
            colorBox.style.width = '20px';
            colorBox.style.height = '20px';
            colorBox.style.backgroundColor = legendColors[index];
            colorBox.style.marginRight = '8px';

            const labelText = document.createElement('span');
            labelText.innerText = label;
            labelText.style.fontFamily = 'Pretendard, sans-serif';
            labelText.style.fontSize = '14px';

            legendItem.append(colorBox, labelText);
            legendContainer.append(legendItem);
        });

        $('#charts-container').before(legendContainer);
    }
    
    const legendMargin = {
		id: 'legendMargin',
		beforeInit(chart, legend, options) {
			const fitValue = chart.legend.fit;
			const spacing = 20;
			chart.legend.fit = function fit() {
				fitValue.bind(chart.legend)()
				return (this.height += spacing)
			}
		},
    }
    
    function createBarChart() {
        const ctx = document.createElement('canvas');
        $('#bar-container > .isu-bar').append(ctx);
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['해결', '미해결'],
                datasets: [{
                    data: [resolvedIsu, unresolvedIsu], 
                    backgroundColor: ['rgba(12, 102, 228, 0.8)', 'rgba(255, 89, 89, 0.8)'],
                    borderWidth: 1,
                },
               ],
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    x: {
                        beginAtZero: true,
                        grid: {
                            display: false
                        },
                        ticks: {
                            font: {
                                family: 'Pretendard, sans-serif',
                                size: 14
                            }
                        }
                    },
                    y: {
                        beginAtZero: true,
                        grid: {
                            display: false
                        },
                        ticks: {
                            display: false
                        },
                        border: {
                            display: false
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        enabled: true,
                        backgroundColor: 'rgba(0, 0, 0, 0.7)',
                        titleFont: {
                            family: 'Pretendard, sans-serif',
                            size: 14
                        },
                        bodyFont: {
                            family: 'Pretendard, sans-serif',
                            size: 12
                        }
                    },
                    datalabels: {
                        display: true,
                        color: '#fff',
                        font: {
                            family: 'Pretendard, sans-serif',
                            size: 13
                        },
                        anchor: 'center', 
                        align: 'center'
                    },
                    title: {
                        display: true,
                        text: '이슈 처리 현황',
                        font: {
                            family: 'Pretendard, sans-serif',
                            size: 16,
                        },
                        color: 'rgba(0, 0, 0, 1)'
                    }
                },
            },
            plugins: [ChartDataLabels, legendMargin], 
        });
    }
    
    let columns = $('#projectStatsMembers thead th').map(function() {
        return { data: $(this).text().trim() };
    }).get();
    
    let projectIssueTable = $('#projectStatsMembers').DataTable({
		order: [3, 'desc'],
		orderClasses: true,
		columns: columns,
		scrollX: false,
		scrollY: 249.32,
		scrollCollapse: true,
		info: false,
        paging: false,
		initComplete: function() {
		    const columnsToApplyFilter = [1, 2]; 

		    columnsToApplyFilter.forEach((columnIndex) => {
		        this.api()
		        .columns([columnIndex])
		        .every(function () {
		            let column = this;
		            let dropdownId = '';
		            switch (columnIndex) {
		                case 1:
		                    dropdownId = 'projectMemberStatsDeptMenu';
		                    break;
		                case 2:
		                    dropdownId = 'projectMemberStatsRankMenu';
		                    break;
		            }

		            let dropdown = $('#' + dropdownId);
		            dropdown.append(`<li><a class="dropdown-item" id="${dropdownId}Item" href="#" data-value="전체">전체</a></li>`);
		            column
		                .data()
		                .unique()
		                .sort()
		                .each(function (d) {
		                    dropdown.append(`<li><div class="dropdown-item" id="${dropdownId}Item" data-value="${d}">${d}</div></li>`);
		                });

		            dropdown.on('click', `#${dropdownId}Item`, function () {
		                const dropdownVal = $(this).data('value');
		                if (dropdownVal == '전체') {
		                    column.search('').draw();
		                } else {
		                    column.search('^' + dropdownVal + '$', true, false).draw();
		                }
		            });
		        });
		    });
		},
		columnDefs: [
			{targets: [1, 2], orderable: false},
		],
	});
});