<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>testjQueryAjax</title>
<script type="text/javascript" src="resources/js/jquery-3.3.1.min.js"></script>
</head>
<body>
<h1>jQuery 로 ajax 테스트</h1>
<hr>
<h2>1. 서버로 보내는 전송값 없고, 결과로 문자열 받아 처리하는 방법 : get 방식</h2>
<p id="p1" style="width:300px;height:50px;border:1px solid red;"></p>
<button id="test1">테스트</button> <br>

<script type="text/javascript">
	$(function(){
		$("#test1").click(function(){
			//컨트롤러(서블릿)로 서비스 요청하고, 결과로 문자열만 받는 경우에는 jQuery.get(); 사용할 수 있음
			//전송방식은 get 방식임
			//jQuery.get("연결 요청할 url(여기서는 컨트롤러 가짜 이름)", {전달이름: 전달값}, 리턴받아 처리할 콜백함수-성공했을 때 실행할 동작 서술);
			$.get("test1.do", function(data){
				$("#p1").text(data);
			});

			//또는 jQuery.ajax() 사용해도 됨
			$.ajax({
				url: "/testa/test1.do", //절대경로로 요청한 거
				type: "get",
				success: function(data){
					$("#p1").html($("#p1").text() + "<br>" + data);
				}
			});

		});
	});
</script>

<hr>
<h2>2. 서버로 값을 전송하고, 결과로 문자열을 받아서 처리하는 방법 : get 방식 </h2>
<p id="p2" style="width:300px;height:50px;border:1px solid red;"></p>
<button id="test2">테스트</button><br>
아이디 : <input type="text" id="userid"> <br>
암 호 : <input type="password" id="userpwd"> <br>

<script type="text/javascript">
	$(function(){
		$("#test2").click(function(){
		//jQuery.get() 과 jQuery.ajax() 두 가지 중 선택 사용
		//$.get() 사용시
		$.get("test2.do",
			{userid: $("#userid").val(), userpwd: $("#userpwd").val()},
			function(data){
			$("#p2").text(data);
			}); //get

			//$.ajax() 사용
			$.ajax({
				url: "test2.do",
				data: {userid: $("#userid").val(), userpwd: $("#userpwd").val()},
				type: "get",
				success: function(data){
					$("#p2").html($("#p2").text() + "<br>" + data);
				}
			}); //ajax

		}); //click
	});
</script>

<hr>
<h2>3. 서버로 값들을 전송하고, 결과가를 안 받는경우 : post 방식</h2>
제 목 : <input type="text" id="title"> <br>
작성자 : <input type="text" id="writer"> <br>
내 용 : <textarea id="content" rows="3" cols="50"></textarea>
<button id="test3">테스트</button>

<script type="text/javascript">
	$(function(){
		$("#test3").click(function(){
			//jQuery.post() 와 jQuery.ajax() 두 가지 중 선택
			//$.post() 사용
			$.post("test3.do", {
				title: $("#title").val(),
				writer: $("#writer").val(),
				content: $("#content").val()
			});

			//$.ajax() 사용
			$.ajax({
				url: "test3.do",
				data: {title: $("#title").val(),
					   writer: $("#writer").val(),
					   content: $("#content").val()
					  },
				type: "post"
			});

		});
	});
</script>

<hr>
<h2>4. 서버로 값 전송하고, 결과로 JSON 객체를 받아서 처리하는 방법</h2>
<p id="p4" style="width:500px;height:150px;border:1px solid red;"></p>
번호 : <input type="number" id="no"> <br>
<button id="test4">테스트</button><br>

<script type="text/javascript">
	$(function(){
		$("#test4").click(function(){
			//jQuery.getJSON() 와 jQuery.ajax() 두 가지 중 선택
			//$.getJSON() 사용
			$.getJSON("test4.do",
					{no: $("#no").val()},
					function(data){
						//data type : json임.
						console.log("data : " + data);

					//전송 온 json 객체가 한 개이면 바로 사용해도 됨
					//서버측에서 한글깨짐을 막기 위해 문자인코딩 처리한 json 객체의 값은 디코딩 처리함
					//자바스크립트의 decodeURIComponent() 함수 사용함
					$("#p4").text(data.no + ", " + decodeURIComponent(data.title).replace(/\+/gi, " ")+ ", " + data.writer + ", "
							+ decodeURIComponent(data.content).replace(/\+/gi, " ") + ", " + data.date);
					});	//getJSON

					$.ajax({
						url: "test4.do",
						data: {no: $("#no").val()},
						type: "get",
						dataType: "json",
						success: function(data){
							$("#p4").html($("#p4").text() + "<br>" + data.no + ", " + decodeURIComponent(data.title).replace(/\+/gi, " ")  + ", " + data.writer + ", "
									+ decodeURIComponent(data.content).replace(/\+/gi, " ") + ", " + data.date);},
						error: function(jqXHR, testStatus, errorThrown){
								console.log("error : " + textStatus);
						}
					});
		});
	})
</script>
<hr>
<h2>5. 서버로 값 전송하고, 결과로 list 나 map 을 json 배열에 담아 응답받아 처리하는 방법</h2>
<p id="p5" style="width:500px;height:300px;border:1px solid red;"></p>
번호 : <input type="number" id="no2"> <br>
<button id="test5">테스트</button><br>

<script type ="text/javascript">
$(function(){
	$("#test5").click(function(){
		//jQuery.getJSON() 와 jQuery.ajax() 두 가지중 선택
		//$.getJSON() 사용
		$.getJSON("test5.do",
				{no: $("#no2").val()},
				function(data){
					//data type : json 임.
					console.log("data : " + data);

					//전송온 jsonString 을 json 객체로 바꾸는작업
					var jsonStr = JSON.stringify(data);
					//string을 json 객체로 바꿈
					var json = JSON.parse(jsonStr);

					for (var i in json.list){

					$("#p5").html($("#p5").html()+"<br>"+
							json.list[i].no + ", " +
							decodeURIComponent(json.list[i].title).replace(/\+/gi," ")+", "+
							data.writer + ", " +
							decodeURIComponent(json.list[i].content).replace(/\+/gi," ") + ", "+
							json.list[i].date);
					}
				});

		$.ajax({
			url: "test5.do",
			data: {no: $("#no2").val() },
			type: "post",
			dataType: "json",
			success: function(data){
				//전송온 jsonString 을 json 객체로 바꾸는작업
				var jsonStr = JSON.stringify(data);
				//string을 json 객체로 바꿈
				var json = JSON.parse(jsonStr);

				for (var i in json.list){

				$("#p5").html($("#p5").html()+"<br>"+
						json.list[i].no + ", " +
						decodeURIComponent(json.list[i].title).replace(/\+/gi," ")+", "+
						data.writer + ", " +
						decodeURIComponent(json.list[i].content).replace(/\+/gi," ") + ", "+
						json.list[i].date);
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				console.log("error : " + textStatus);
			}
		});
	});
});
</script>


<br><br><br><br><br><br><br><br><br><br><br>
<br><br><br><br><br><br><br><br><br><br><br>
</body>
</html>
