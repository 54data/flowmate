
    $(document).ready(function() {
    	const centerTextPlugin = {
    		    id: 'centerText',
    		    beforeDraw: function(chart) {
    		        let width = chart.width,
    		            height = chart.height,
    		            ctx = chart.ctx;

    		        // 상태 복원
    		        ctx.restore();

    		        // 범례와 툴팁의 위치를 고려하여 텍스트가 중앙에 위치하도록 설정
    		        let fontSize = (height / 200).toFixed(2);  // 중앙 텍스트 크기 조정
    		        ctx.font = fontSize + "em sans-serif";
    		        ctx.fillStyle = 'rgba(0, 0, 0, 1)';
    		        ctx.textBaseline = "middle";

    		        let text = chart.data.datasets[0].data[0] + "%";

    		        // 범례의 위치를 확인하고 텍스트 위치 조정
    		        let legendHeight = 0;
    		        if (chart.legend) {
    		            legendHeight = chart.legend.height || 0; // 범례 높이
    		        }

    		        // 범례 높이를 고려한 텍스트의 Y 위치
    		        let textX = Math.round((width - ctx.measureText(text).width) / 2);
    		        let textY = (height + legendHeight) / 2;

    		        ctx.fillText(text, textX, textY);

    		        // 상태 저장
    		        ctx.save();
    		    }
    		};

    		// 플러그인 등록
    		Chart.register(centerTextPlugin);

    		// 차트 생성 및 데이터 설정
    		const steps = [
    		    { name: "Step 1", completed: 80, planned: 10, onHold: 5, inProgress: 5 },
    		    { name: "Step 2", completed: 50, planned: 20, onHold: 10, inProgress: 20 },
    		    { name: "Step 3", completed: 60, planned: 30, onHold: 5, inProgress: 5 },
    		    { name: "Step 4", completed: 90, planned: 5, onHold: 3, inProgress: 2 }
    		];

    		// 각 스텝을 위한 차트를 생성하는 함수
    		function createChart(step, index) {
    		    const total = step.completed + step.planned + step.onHold + step.inProgress;
    		    const completionRate = (step.completed / total * 100).toFixed(2);

    		    const chartData = {
    		        datasets: [{
    		            data: [step.completed, step.planned, step.onHold, step.inProgress],
    		            backgroundColor: ['#28a745', '#ffc107', '#dc3545', '#17a2b8'],
    		            borderWidth: 1
    		        }],
    		        labels: ['Completed', 'Planned', 'On Hold', 'In Progress']
    		    };

    		    const chartOptions = {
    		        responsive: true,
    		        maintainAspectRatio: false,
    		        cutout: '70%',  // 중앙을 70% 비워서 도넛 차트로 만들기
    		        animation: {
    		            duration: 1000  // 애니메이션 속도
    		        },
    		        plugins: {
    		            datalabels: {
    		                display: false  // 데이터 레이블은 표시하지 않음
    		            }
    		        }
    		    };

    		    const chartContainer = document.createElement('div');
    		    chartContainer.classList.add('col-md-3', 'mb-4');
    		    const canvas = document.createElement('canvas');
    		    chartContainer.appendChild(canvas);

    		    document.getElementById('charts-container').appendChild(chartContainer);

    		    // 차트를 그립니다.
    		    const myChart = new Chart(canvas, {
    		        type: 'doughnut', // 도넛 차트
    		        data: chartData,
    		        options: chartOptions,
    		        plugins: [centerTextPlugin]  // 중앙 텍스트 플러그인 추가
    		    });
    		}

    		// 각 스텝에 대해 차트를 생성
    		steps.forEach((step, index) => createChart(step, index));

    		// 데이터 업데이트를 위한 AJAX 요청
    		setInterval(function () {
    		    fetch('/system/cpuData')
    		        .then(response => response.json())
    		        .then(data => {
    		            steps.forEach((step, index) => {
    		                // 예시로 Step 1 데이터 업데이트
    		                if (index === 0) {
    		                    step.completed = data.value; // 예시로 값을 업데이트
    		                    step.planned = 100 - data.value;
    		                }
    		                // 해당 스텝 차트의 데이터 업데이트
    		                const updatedChart = document.getElementsByTagName('canvas')[index].chart;
    		                updatedChart.data.datasets[0].data[0] = step.completed;
    		                updatedChart.data.datasets[0].data[1] = step.planned;
    		                updatedChart.update();
    		            });
    		        });
    		}, 5000);  // 5초마다 실행
    });