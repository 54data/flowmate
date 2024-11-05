<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<ul>
    <c:forEach items="${tasks}" var="task" begin="0" end="2">
    		<a href="${pageContext.request.contextPath}/project/projectBoard?projectId=${task.projectId}&taskId=${task.taskId}">
	        <li class="d-flex justify-content-between align-items-center">
	            <div class="d-flex align-items-center">
	                <c:if test="${task.taskState == '진행 중'}">
	                    <i class="bi bi-circle-fill"></i>
	                </c:if>
	                <c:if test="${task.taskState == '예정'}">
	                    <i class="bi bi-circle-fill plannedCircle"></i>
	                </c:if>
	                <span class="d-flex projectState">${task.taskState}</span>
	                <span class="projectContent">${task.taskName}</span>
	            </div>
	            <div class="d-flex align-items-center">
				    <fmt:parseDate var="taskDueDate" value="${task.taskDueDate}" pattern="yyyyMMddHHmmss"/>
					<fmt:formatDate value="${taskDueDate}" pattern="yyyy.MM.dd" var="taskDueDate"/>
			        <span class="projectDate">${taskDueDate}</span>
	            </div>
	        </li>
        </a>
    </c:forEach>
</ul>
