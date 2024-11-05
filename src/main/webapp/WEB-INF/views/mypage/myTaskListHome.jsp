<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div style="height: 158px; overflow-y: auto;"> 
<ul>
    <c:forEach items="${tasks}" var="task" >
        <li class="d-flex justify-content-between align-items-center">
            <a href="${pageContext.request.contextPath}/project/projectBoard?projectId=${task.projectId}&taskId=${task.taskId}" class="d-flex justify-content-between align-items-center w-100 text-decoration-none">
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
                    <span class="projectDate me-3">${taskDueDate}</span>
                </div>
            </a>
        </li>
    </c:forEach>
</ul>
</div>
