<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- 화폐 표시 tag lib -->

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>Insert title here</title>
<style>
* {
	margin: auto;
}
input{
	width:20px;
	height:100%;
}
</style>
</head>
<body>
<c:choose>
<c:when test="${list.size() == 0}">
	<div align=center style="margin:100px;">장바구니 내역이 없습니다.</div>
	<div align=center><a href=${pageContext.request.contextPath}/Cart/index.jsp>쇼핑 페이지 이동</a></div>
</c:when>
<c:otherwise>
<p align=center>담은 결과
<c:forEach items="${list }" var="dto">
	<table bordercolor=black border=1 cellspacing=1>
		<!-- <caption>담은결과</caption> -->
		<!-- 
		<tr align=center>
			<td colspan=2>${dto.seq}번 장바구니  
		</tr> -->
		<input type=hidden name="seq">
		<tr align=center>
			<td>품명</td>
			<td colspan=2>${dto.prod_name}</td>
			
		</tr>
		<tr align=center>
			<td>가격</td>
			<td colspan=2>${dto.price}</td>
		</tr>
		<tr align=center>
			<td>수량</td>
			<td><input type="text" class="count${dto.seq}" value="${dto.prod_quantity}"></td>
			<td><button id="updateBtn" onclick ="updateCart(${dto.seq})">변경</button></td>
		</tr>	
		<tr align=center>
			<td>합계</td>
			<td colspan=2><fmt:formatNumber value="${dto.price*dto.prod_quantity }" pattern="#,###" />
			<c:set var= "sum" value="${sum + dto.price*dto.prod_quantity}"/>
			</td>
		</tr>
		<tr align=center>
			<td colspan=3><button onclick ="deleteCart(${dto.seq})">삭제</button></td>
		</tr>
	</table>
</c:forEach>
	
	<table>
		<tr>
			<td>총 합계</td>
			<td><fmt:formatNumber value="${sum}" pattern="#,###" /> <!-- cout 대신에 formatNumber -->		
		</tr>
	</table>
		<div align=center><button id="deleteAll">전체 삭제</button></div>
		<div align=center><a href=${pageContext.request.contextPath}/Cart/index.jsp>쇼핑 페이지 이동</a></div>
		<div align=center><a href="#">주문하기</a></div>
	</c:otherwise>
</c:choose>
	<script>
		
		function deleteCart(seq){
		var cf = confirm("삭제할까요?");
            if(cf){
                location.href="delete.ca?seq="+seq;
            }
        }
		
		function updateCart(seq){
			var countval = $(".count"+seq).val();
			location.href="update.ca?prod_quantity="+countval+"&seq="+seq;
        }
		
        $("#deleteAll").on("click",function(){
            location.href="deleteAll.ca";
        })
    </script>
</body>
</html>