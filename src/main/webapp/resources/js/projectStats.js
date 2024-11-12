$(document).ready(function() {
    let steps = [];

    // AJAX 요청에서 step_progress 값을 포함한 데이터 수신
    $.ajax({
        url: '../../flowmate/project/getProjectStats',
        success: function(response) {
            steps = response.map(step => {
                console.log(step);
                return {
                    name: step.stepName,
                    completed: step.doneTaskCnt,
                    planned: step.tbTaskCnt,
                    onHold: step.holdTaskCnt,
                    inProgress: step.inprogressTaskCnt,
                    progress: step.stepProgress
                };
            });
            steps.forEach((step, index) => createChart(step, index));
            createCommonLegend(); // 공통 레전드 생성 함수 호출
        }
    });

    // 중앙 텍스트 플러그인
    const centerTextPlugin = {
        id: 'centerText',
        beforeDraw: function(chart) {
            let width = chart.width,
                height = chart.height,
                ctx = chart.ctx;

            ctx.restore();

            let fontSize = (height / 270).toFixed(2);
            ctx.font = fontSize + "em Pretendard, sans-serif";
            ctx.fillStyle = 'rgba(0, 0, 0, 1)';
            ctx.textBaseline = "middle";  // 텍스트 중앙 정렬
            ctx.textAlign = 'center';  // 텍스트 수평 중앙 정렬

            // 현재 차트의 index에 맞는 step progress 값
            const stepIndex = chart.canvas.getAttribute('data-index');
            const stepName = steps[stepIndex].name; // 단계 이름
            const progressText = steps[stepIndex].progress + "%"; // 진행률 텍스트

            // 범례 높이 계산
            let legendHeight = 0;
            if (chart.legend) {
                legendHeight = chart.legend.height || 0; // 범례 높이
            }

            // 중앙 텍스트 위치 계산 (범례 높이를 고려하여 Y 좌표 조정)
            let textX = width / 2; // 차트 너비의 절반
            let textY = (height + legendHeight) / 2; // 범례를 제외한 중앙

            // 텍스트 간격을 조금 더 잘 조정하기 위해 두 텍스트의 Y 위치 차이를 설정
            let stepNameY = textY - 15;
            let progressTextY = textY + 15;

            // 단계 이름과 진행률 텍스트 그리기
            ctx.fillText(stepName, textX, stepNameY);
            ctx.fillText(progressText, textX, progressTextY);

            ctx.save();
        }
    };

    // 플러그인 등록
    Chart.register(centerTextPlugin);

    // 각 스텝을 위한 차트를 생성하는 함수
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
                    display: false // 각 차트 내에서 레전드 숨기기
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
        chartContainer.classList.add('col-md-2');

        const cardBody = document.createElement('div');
        cardBody.classList.add('p-0');
        const canvas = document.createElement('canvas');
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

    // 공통 레전드 생성 함수
    function createCommonLegend() {
        const legendContainer = document.createElement('div');
        legendContainer.classList.add('legend-container', 'p-2');
        legendContainer.style.display = 'flex'; // 가로로 배치하기 위해 flex 사용
        legendContainer.style.justifyContent = 'center'; // 가운데 정렬

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
            legendItem.style.marginRight = '20px';

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

        $('#charts-container').before(legendContainer); // 차트 앞에 공통 레전드 추가
    }
});