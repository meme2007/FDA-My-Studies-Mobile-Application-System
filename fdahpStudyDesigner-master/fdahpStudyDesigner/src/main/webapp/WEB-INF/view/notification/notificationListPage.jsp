<!-- 
  Copyright � 2017-2018 Harvard Pilgrim Health Care Institute (HPHCI) and its Contributors.
  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
  associated documentation files (the "Software"), to deal in the Software without restriction, including
  without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
  of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
  following conditions:
 
  The above copyright notice and this permission notice shall be included in all copies or substantial
  portions of the Software.
 
  Funding Source: Food and Drug Administration ("Funding Agency") effective 18 September 2014 as Contract no.
  HHSF22320140030I/HHSF22301006T (the "Prime Contract").
 
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
  OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
  ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  OTHER DEALINGS IN THE SOFTWARE. 
-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<style>
<!--
.sorting, .sorting_asc, .sorting_desc {
    background : none !important;
}
-->
</style>
	
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 p-none mb-md">
     <div>
         <!-- widgets section-->        
         <div class="col-sm-12 col-md-12 col-lg-12 p-none">
            <div class="black-lg-f">
                Manage Notifications
            </div>          
            <div class="dis-line pull-right ml-md">
             	<c:if test="${fn:contains(sessionObject.userPermissions,'ROLE_MANAGE_APP_WIDE_NOTIFICATION_EDIT')}">
	                 <div class="form-group mb-none mt-xs">
	                     <button type="button" class="btn btn-primary blue-btn notificationDetailsToEdit" actionType="add">
	                      Create Notification</button>
	                 </div>
                 </c:if>
             </div>
         </div>         
    </div>
    <div  class="clearfix"></div>
</div>

<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 p-none"> 
    <div class="white-bg">
        <div>
            <table id="app_Wide_Notification_list" class="table table-right tbl">
            <thead>
              <tr>
                <th>TITLE</th>
                <th class="linkDis">Status</th>
                <th class="linkDis">ACTIONS</th>  
              </tr>
            </thead>
            <tbody>
            <c:forEach items="${notificationList}" var="notification" varStatus="status">
              <tr>
                <td><div class="dis-ellipsis lg-ellipsis" title="${fn:escapeXml(notification.notificationText)}">${fn:escapeXml(notification.notificationText)}</div></td>                
                <td>${notification.checkNotificationSendingStatus}</td>
                <td>
                	<span class="sprites_icon preview-g mr-lg notificationDetailsToView" actionType="view" notificationId="${notification.notificationId}" data-toggle="tooltip" data-placement="top" title="View"></span>
                    <c:if test="${fn:contains(sessionObject.userPermissions,'ROLE_MANAGE_APP_WIDE_NOTIFICATION_EDIT')}">
                    	<c:if test="${notification.notificationSent}">
	                    	<span class="sprites-icons-2 send mr-lg notificationDetailsToEdit" actionType="resend" notificationId="${notification.notificationId}" data-toggle="tooltip" data-placement="top" title="Resend"></span>
	                    </c:if>
	                    <c:if test="${not notification.notificationSent}">
	                    	<span class="sprites_icon edit-g mr-lg notificationDetailsToEdit" actionType="edit" notificationId="${notification.notificationId}" data-toggle="tooltip" data-placement="top" title="Edit"></span>
	                    </c:if>
	                    <span class="sprites_icon copy notificationDetailsToEdit" actionType="add" notificationText="${fn:escapeXml(notification.notificationText)}" data-toggle="tooltip" data-placement="top" title="Copy"></span>                    
                    </c:if>
                  </td>        
               </tr> 
              </c:forEach>
			  </tbody>
          </table>
        </div>
  </div>
</div>
<form:form action="/fdahpStudyDesigner/adminNotificationEdit/getNotificationToEdit.do" id="getNotificationEditPage" name="getNotificationEditPage" method="post">
		<input type="hidden" id="notificationId" name="notificationId">
		<input type="hidden" id="notificationText" name="notificationText">
		<input type="hidden" id="actionType" name="actionType">
		<input type="hidden" name="chkRefreshflag" value="y">
</form:form>
<form:form action="/fdahpStudyDesigner/adminNotificationView/getNotificationToView.do" id="getNotificationViewPage" name="getNotificationViewPage" method="post">
		<input type="hidden" id="notificationIdToView" name="notificationId">
		<input type="hidden" id="actionTypeToView" name="actionType">
		<input type="hidden" name="chkRefreshflag" value="y">
</form:form>

<script>
	//notificationTable();
	$(document).ready(function(){
		$('#rowId').parent().removeClass('white-bg');
		
		$('#notification').addClass('active');
		
		$('[data-toggle="tooltip"]').tooltip();  
		 
		$('.notificationDetailsToEdit').on('click',function(){
			$('.notificationDetailsToEdit').prop('disabled', true);
			$('#notificationId').val($(this).attr('notificationId'));
			$('#notificationText').val($(this).attr('notificationText'));
			$('#actionType').val($(this).attr('actionType'));
			$('#getNotificationEditPage').submit();
		});
		
		$('.notificationDetailsToView').on('click',function(){
			$('.notificationDetailsToView').prop('disabled', true);
			$('#notificationIdToView').val($(this).attr('notificationId'));
			$('#actionTypeToView').val($(this).attr('actionType'));
			$('#getNotificationViewPage').submit();
		});
		
		$('#app_Wide_Notification_list').DataTable( {
		    "paging":   true,
		    "order": [],
		    "columnDefs": [ { orderable: false, orderable: false, targets: [0] } ],
		    "info" : false, 
		    "lengthChange": false, 
		    "searching": false, 
		    "pageLength": 15,
		});
		
});
</script>
