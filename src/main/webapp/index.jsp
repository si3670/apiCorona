<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>코로나현황</title>

<style>
@font-face {
	font-family: 'paybooc-Bold';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-07@1.0/paybooc-Bold.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-07@1.0/paybooc-Bold.woff')
		format('woff');
}

.flex {
	display: flex;
}

body {
	margin: 0;
	font-family: 'paybooc-Bold';
	font-style: normal;
}

/*전국현황 시작*/
.content {
	margin: 0 auto;
	max-width: 1300px;
}

.con {
	background-color: #f4f4f4;
	width: 300px;
	border-radius: 10px;
	font-size: 20px;
}

.con1 {
	padding: 15px;
	justify-content: space-between;
}

.con1>h3 {
	font-size: 30px;
}

.con-h3 {
	justify-content: space-between;
}
/*전국현황 끝*/
/*헤더 시작*/
.header {
	background-color: rgb(0, 73, 132);
	height: 350px;
	position: relative;
}

.header::before {
	content: '';
	display: block;
	background:
		url(	https://corona.daejeon.go.kr/images/drh/corona/main-top-back-01.png)
		no-repeat;
	position: absolute;
	left: 0;
	bottom: 0;
	width: 303px;
	height: 248px;
}

.header::after {
	content: '';
	display: block;
	background:
		url(https://corona.daejeon.go.kr/images/drh/corona/main-top-back-02.png)
		no-repeat;
	position: absolute;
	right: 0;
	bottom: 0;
	width: 361px;
	height: 315px;
}

.header>.header-con {
	margin: 0 auto;
	height: 100%;
	width: 1440px;
	height: 100%;
	position: relative;
}

.header>.header-con>h1 {
	color: white;
	font-size: 50px;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}

.header>.header-con>.logo>img {
	width: 172px;
	height: 40px;
	margin-top: 20px;
}
/*헤더 끝*/

.chart{
margin-top: 20px;
}
</style>


<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>

</head>






<body>
	<div class="header">
		<div class="header-con">
			<a href="#" class="logo img-box"> <img alt=""
				src="https://corona.daejeon.go.kr/images/drh/corona/logo.png">
			</a>
			<h1>대전광역시 코로나19 현황</h1>
		</div>
	</div>

	<div class="content chart"  style="width: 800px">
		<canvas id="myChart"></canvas>
	</div>

</body>

<script>
	// 전국현황 시작

	$.ajax({
		url : 'PublicData.do',
		type : 'get',
		dataType : 'json',
		success : function(data) {
			//console.log(data);
			console.log(data.response.body.items.item[0]);
			var myItem = data.response.body.items.item[0];

			//createDt의 날짜를 나눔
			var date = myItem.createDt;
			//console.log(date);
			var year = date.substring(2, 4);
			//console.log(year);
			var month = date.substring(5, 7);
			//console.log(month);
			var day = date.substring(8, 10);
			//console.log(day);
			var time = date.substring(11, 19);
			//console.log(time);

			//<데이터 콤마 표시>
			//확진자(decideCnt=cn1), 치료중(careCnt=cn2), 격리해제자(clearCnt=cn3), 사망자(deathCnt=cn4)
			var comma1 = myItem.decideCnt;
			var comma2 = myItem.careCnt;
			var comma3 = myItem.clearCnt;
			var comma4 = myItem.deathCnt;
			var cn1 = comma1.toString().replace(
					/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
			var cn2 = comma2.toString().replace(
					/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
			var cn3 = comma3.toString().replace(
					/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
			var cn4 = comma4.toString().replace(
					/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");

			var output = '';
			output += '<div class="content" style="text-align:center;">';
			output += '<div class="flex con1"><h3>' + '코로나19 전국 현황' + '</h3>';
			output += '<h5>' + year + '.' + month + '.' + day + '. ' + time
					+ '시 기준' + '</h5></div>';
			output += '<div class="flex con-h3">';
			output += '<div class="con"><h3>확진자</h3>'
			output += '<h4>' + cn1 + '</h4></div>';
			output += '<div class="con"><h3>치료 중</h3>'
			output += '<h4>' + cn2 + '</h4></div>';
			output += '<div class="con"><h3>격리해제자</h3>'
			output += '<h4>' + cn3 + '</h4></div>';
			output += '<div class="con"><h3>사망자</h3>'
			output += '<h4>' + cn4 + '</h4></div>';
			output += '</div>';
			output += '</div>';
			document.body.innerHTML += output;

		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("Status: " + textStatus);
			alert("Error: " + errorThrown);
		}
	});
	// 전국현황 끝

	// 대전현황 시작

	$.ajax({
		url : 'SidoData.do',
		type : 'get',
		dataType : 'json',
		success : function(data) {
			//console.log(data);
			//console.log(data.response.body.items.item[12]);
			var myItem = data.response.body.items.item[12];

			//createDt의 날짜를 나눔
			var date = myItem.createDt;
			//console.log(date);
			var year = date.substring(2, 4);
			//console.log(year);
			var month = date.substring(5, 7);
			//console.log(month);
			var day = date.substring(8, 10);
			//console.log(day);
			var time = date.substring(11, 19);
			//console.log(time);

			//<데이터 콤마 표시>
			//확진자(defCnt=cn1), 격리자(isolIngCnt=cn2), 격리해제자(isolClearCnt=cn3), 사망자(deathCnt=cn4)
			var comma1 = myItem.defCnt;
			var comma2 = myItem.isolIngCnt;
			var comma3 = myItem.isolClearCnt;
			var comma4 = myItem.deathCnt;
			var cn1 = comma1.toString().replace(
					/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
			var cn2 = comma2.toString().replace(
					/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
			var cn3 = comma3.toString().replace(
					/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
			var cn4 = comma4.toString().replace(
					/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");

			var output = '';
			output += '<div class="content" style="text-align:center;">';
			output += '<div class="flex con1"><h3>' + '코로나19 대전 현황' + '</h3>';
			output += '<h5>' + year + '.' + month + '.' + day + '. ' + time
					+ '시 기준' + '</h5></div>';
			output += '<div class="flex con-h3">';
			output += '<div class="con"><h3>확진자</h3>'
			output += '<h4>' + cn1 + '</h4></div>';
			output += '<div class="con"><h3>격리자</h3>'
			output += '<h4>' + cn2 + '</h4></div>';
			output += '<div class="con"><h3>격리해제자</h3>'
			output += '<h4>' + cn3 + '</h4></div>';
			output += '<div class="con"><h3>사망자</h3>'
			output += '<h4>' + cn4 + '</h4></div>';
			output += '</div>';
			output += '</div>';
			document.body.innerHTML += output;

		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("Status: " + textStatus);
			alert("Error: " + errorThrown);
		}
	});

	// 대전현황 끝
	
	
	//차트
	$.ajax({
		url : 'PublicData.do',
		type : 'get',
		dataType : 'json',
		success : function(data) {
			console.log(data);
			console.log(myItem);
			var myItem = data.response.body.items.item;
			
			//7일 전 ~ 현재 날짜 데이터 불러오기
			var day1 =  data.response.body.items.item[0]; //13일
			var day2 =  data.response.body.items.item[1]; //12일
			var day3 =  data.response.body.items.item[2]; //11일
			var day4 =  data.response.body.items.item[3]; //10일
			var day5 =  data.response.body.items.item[4]; //9일
			var day6 =  data.response.body.items.item[5]; //8일
			var day7 =  data.response.body.items.item[6]; //7일
			
			//확진자 수만 불러오기
			var date1 = day1.decideCnt
			var date2 = day2.decideCnt
			var date3 = day3.decideCnt
			var date4 = day4.decideCnt
			var date5 = day5.decideCnt
			var date6 = day6.decideCnt
			var date7 = day7.decideCnt

			//현재 확진자 수 - 어제 확진자 수
			var decideCnt1 = date1-date2;
			var decideCnt2 = date2-date3;
			var decideCnt3 = date3-date4;
			var decideCnt4 = date4-date5;
			var decideCnt5 = date5-date6;
			var decideCnt6 = date6-date7;

			
			var ctx = document.getElementById("myChart").getContext('2d');

			var myChart = new Chart(ctx, {

				type : 'bar',

				data : {

					labels : [ "08-08", "08-09", "08-10", "08-11", "08-12",
							"08-13" ],

					datasets : [ {

						label : '일일 확진자',

						data : [
							
							decideCnt6,
							decideCnt5,
							decideCnt4,
							decideCnt3,
							decideCnt2,
							decideCnt1
						],

						backgroundColor : [
						'rgba(54, 162, 235, 1)',
						'rgba(54, 162, 235, 1)',
						'rgba(54, 162, 235, 1)',
						'rgba(54, 162, 235, 1)',
						'rgba(54, 162, 235, 1)',
						'rgba(54, 162, 235, 1)'

						]

					} ]

				},

				options : {

					maintainAspectRatio : true, // default value. false일 경우 포함된 div의 크기에 맞춰서 그려짐.

					scales : {

						yAxes : [ {

							ticks : {

								beginAtZero : true,
								fontSize : 15

							}

						} ],
						xAxes : [ {

							ticks : {

								beginAtZero : true,
								fontSize : 15

							}

						} ]

					}

				}

			});
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("Status: " + textStatus);
			alert("Error: " + errorThrown);
		}
	});
</script>



</html>