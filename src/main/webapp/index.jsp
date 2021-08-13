<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>코로나현황</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>


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
</style>

<script>
	// 전국현황 시작
	$.ajax({
		url : 'PublicData.do',
		type : 'get',
		dataType : 'json',
		success : function(data) {
			console.log(data);
			console.log(data.response.body.items.item);
			var myItem = data.response.body.items.item;

			//createDt의 날짜를 나눔
			var date = myItem.updateDt;
			console.log(date);
			var year = date.substring(2, 4);
			console.log(year);
			var month = date.substring(5, 7);
			console.log(month);
			var day = date.substring(8, 10);
			console.log(day);
			var time = date.substring(11, 19);
			console.log(time);

			//<데이터 콤마 표시>
			//확진자(decideCnt=cn1), 치료중(careCnt=cn2), 격리해제자(clearCnt=cn3), 사망자(deathCnt=cn4)
			var comma1 = myItem.decideCnt;
			var comma2 = myItem.careCnt;
			var comma3 = myItem.clearCnt;
			var comma4 = myItem.deathCnt;
			var cn1 = comma1.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
			var cn2 = comma2.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
			var cn3 = comma3.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
			var cn4 = comma4.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
			
			console.log(cn1);
			console.log(cn2);
			console.log(cn3);
			console.log(cn4);
			
			
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
			console.log(data);
			console.log(data.response.body.items.item[12]);
			var myItem = data.response.body.items.item[12];

			//createDt의 날짜를 나눔
			var date = myItem.createDt;
			console.log(date);
			var year = date.substring(2, 4);
			console.log(year);
			var month = date.substring(5, 7);
			console.log(month);
			var day = date.substring(8, 10);
			console.log(day);
			var time = date.substring(11, 19);
			console.log(time);
			
			
			//<데이터 콤마 표시>
			//확진자(defCnt=cn1), 격리자(isolIngCnt=cn2), 격리해제자(isolClearCnt=cn3), 사망자(deathCnt=cn4)
			var comma1 = myItem.defCnt;
			var comma2 = myItem.isolIngCnt;
			var comma3 = myItem.isolClearCnt;
			var comma4 = myItem.deathCnt;
			var cn1 = comma1.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
			var cn2 = comma2.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
			var cn3 = comma3.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
			var cn4 = comma4.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
			
			console.log(cn1);
			console.log(cn2);
			console.log(cn3);
			console.log(cn4);
			
			
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
</script>
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
</body>
</html>