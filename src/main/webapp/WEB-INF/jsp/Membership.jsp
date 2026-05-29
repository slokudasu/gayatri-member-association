<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Membership Details</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="/css/bootstrap.min.css">
  <script src="/js/jquery.min.js"></script>
  <script src="/js/bootstrap.min.js"></script>
  <style>
    :root {
      --member-primary: #6f42c1;
      --member-primary-dark: #5b33a6;
      --member-primary-light: #f3eefb;
      --member-border: #d8c8f3;
    }

    body {
      background: #f4f6fb;
      color: #2f3340;
    }

    .page-shell {
      max-width: 1380px;
      margin: 0 auto;
      padding: 16px 12px 28px;
    }

    .alert-stack {
      position: fixed;
      top: 20px;
      right: 20px;
      z-index: 1060;
      min-width: 250px;
      padding: 0;
    }

    .panel.panel-primary {
      border-color: var(--member-primary);
      box-shadow: 0 2px 10px rgba(35, 39, 47, 0.08);
    }

    .panel-primary > .panel-heading {
      border-color: var(--member-primary-dark);
      background: var(--member-primary-dark);
      color: #ffffff;
    }

    .heading-content {
      display: flex;
      align-items: center;
      gap: 10px;
      flex-wrap: wrap;
    }

    .heading-title {
      font-size: 16px;
      font-weight: 600;
      line-height: 1.3;
    }

    .panel-primary > .panel-heading .btn-info {
      background-color: rgba(255, 255, 255, 0.2);
      border-color: rgba(255, 255, 255, 0.35);
      color: #ffffff;
    }

    .panel-primary > .panel-heading .btn-info:hover,
    .panel-primary > .panel-heading .btn-info:focus {
      background-color: rgba(255, 255, 255, 0.3);
      border-color: rgba(255, 255, 255, 0.45);
      color: #ffffff;
    }

    .required-marker {
      color: #d9534f;
      margin-left: 2px;
    }

    .panel-body .form-group label {
      font-weight: 600;
    }

    .form-control:focus {
      border-color: var(--member-primary);
      box-shadow: 0 0 0 0.2rem rgba(111, 66, 193, 0.18);
    }

    .form-group.has-error .form-control {
      border-color: #d9534f;
    }

    .action-bar .btn,
    .action-bar .btn-link,
    .action-bar a.btn {
      margin-right: 8px;
      margin-bottom: 8px;
      min-width: 100px;
    }

    .table > thead > tr > th {
      background: var(--member-primary-light);
      color: #4a2d79;
      border-color: var(--member-border);
      white-space: nowrap;
    }

    .table > tbody > tr > td {
      vertical-align: middle;
    }

    .table-action-buttons .btn {
      margin-right: 6px;
      margin-bottom: 4px;
    }

    .modal-header {
      background: #f7f2ff;
      border-bottom: 1px solid #e2d5fa;
    }

    .modal-title {
      color: #4c2c7f;
      font-weight: 600;
    }

    .modal-footer .btn {
      min-width: 96px;
    }

    .delete-confirm-modal .modal-dialog {
      position: fixed;
      top: 16px;
      left: 50%;
      transform: translateX(-50%) !important;
      margin: 0;
      width: calc(100% - 20px);
      max-width: 420px;
    }

    .delete-confirm-modal {
      overflow: hidden !important;
    }

    .delete-confirm-modal .modal-content {
      overflow: hidden;
    }

    .delete-confirm-modal .modal-footer .btn {
      min-width: 90px;
    }

    @media (max-width: 767px) {
      .page-shell {
        padding: 10px 8px 18px;
      }

      .alert-stack {
        left: 10px;
        right: 10px;
        min-width: 0;
      }

      .action-bar .btn,
      .action-bar a.btn {
        width: 100%;
        margin-right: 0;
      }

      .delete-confirm-modal .modal-dialog {
        top: 10px;
        width: calc(100% - 16px);
      }
    }
  </style>
</head>
<body>
<div class="container-fluid page-shell">
  <div class="col-md-3 alert-stack" id="alertBox"></div>

  <div class="row">
    <div class="col-xs-12">
      <div class="panel panel-primary">
        <div class="panel-heading">
          <div class="heading-content">
            <a href="home" class="btn btn-info btn-sm">
              <span class="glyphicon glyphicon-home"></span>
            </a>
            <span class="heading-title">Membership</span>
          </div>
        </div>
        <div class="panel-body">
          <form id="memberForm" autocomplete="off">
            <div class="row">
              <div class="form-group col-sm-6 col-md-3">
                <label for="firstName">First Name <span class="required-marker">*</span></label>
                <input type="text" class="form-control" id="firstName" name="firstName">
              </div>
              <div class="form-group col-sm-6 col-md-3">
                <label for="lastName">Last Name <span class="required-marker">*</span></label>
                <input type="text" class="form-control" id="lastName" name="lastName">
              </div>
              <div class="form-group col-sm-6 col-md-3">
                <label for="mobileNumber">Mobile Number <span class="required-marker">*</span></label>
                <input type="text" class="form-control" id="mobileNumber" name="mobileNumber" maxlength="10">
              </div>
              <div class="form-group col-sm-6 col-md-3">
                <label for="memberType">Member Type <span class="required-marker">*</span></label>
                <select class="form-control" id="memberType" name="memberType">
                  <option value="">--Select--</option>
                  <option value="Owner">Owner</option>
                  <option value="Open Plot">Open Plot</option>
                </select>
              </div>
              <div class="form-group col-sm-6 col-md-3">
                <label for="memberShipFlag">Membership <span class="required-marker">*</span></label>
                <select class="form-control" id="memberShipFlag" name="memberShipFlag">
                  <option value="">--Select--</option>
                  <option value="true">Yes</option>
                  <option value="false">No</option>
                </select>
              </div>
              <div class="form-group col-sm-6 col-md-3">
                <label for="memberShipAmount">Membership Amount <span class="required-marker">*</span></label>
                <input type="number" class="form-control" id="memberShipAmount" name="memberShipAmount" min="0">
              </div>
              <div class="form-group col-sm-12 col-md-6">
                <label for="fullAddress">Full Address <span class="required-marker">*</span></label>
                <textarea class="form-control" id="fullAddress" name="fullAddress" rows="2"></textarea>
              </div>
            </div>
            <div class="form-group col-xs-12 action-bar">
              <button type="button" class="btn btn-success" id="save">Save</button>
              <button type="button" class="btn btn-primary" id="search">Search</button>
              <a id="downloadExcel" href="/member/downloadExcel" class="btn btn-default" role="button">Download Excel</a>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>

  <div class="row" id="investorListDiv">
    <div class="col-xs-12">
      <div class="panel panel-primary">
        <div class="panel-heading">
          Membership Details
          <label id="totalMembershipAmount" style="color: #ffef73; margin-bottom: 0;"></label>
        </div>
        <div class="panel-body">
          <div class="table-responsive">
            <table class="table table-bordered table-striped table-hover">
              <thead>
              <tr>
                <th>Sl.No</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Mobile Number</th>
                <th>Member Type</th>
                <th>Membership</th>
                <th>Membership Amount</th>
                <th>Actions</th>
              </tr>
              </thead>
              <tbody id="tbdata"></tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="editMemberModal" class="modal fade" role="dialog" aria-labelledby="editMemberTitle">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" id="editMemberTitle">Edit Member</h4>
      </div>
      <div class="modal-body">
        <form id="editMemberForm" autocomplete="off">
          <input type="hidden" id="editMemberId" name="editMemberId">
          <div class="row">
            <div class="form-group col-sm-6 col-md-4">
              <label for="editFirstName">First Name <span class="required-marker">*</span></label>
              <input type="text" class="form-control" id="editFirstName" name="editFirstName">
            </div>
            <div class="form-group col-sm-6 col-md-4">
              <label for="editLastName">Last Name <span class="required-marker">*</span></label>
              <input type="text" class="form-control" id="editLastName" name="editLastName">
            </div>
            <div class="form-group col-sm-6 col-md-4">
              <label for="editMobileNumber">Mobile Number <span class="required-marker">*</span></label>
              <input type="text" class="form-control" id="editMobileNumber" name="editMobileNumber" maxlength="10">
            </div>
            <div class="form-group col-sm-6 col-md-4">
              <label for="editMemberType">Member Type <span class="required-marker">*</span></label>
              <select class="form-control" id="editMemberType" name="editMemberType">
                <option value="">--Select--</option>
                <option value="Owner">Owner</option>
                <option value="Open Plot">Open Plot</option>
              </select>
            </div>
            <div class="form-group col-sm-6 col-md-4">
              <label for="editMemberShipFlag">Membership <span class="required-marker">*</span></label>
              <select class="form-control" id="editMemberShipFlag" name="editMemberShipFlag">
                <option value="">--Select--</option>
                <option value="true">Yes</option>
                <option value="false">No</option>
              </select>
            </div>
            <div class="form-group col-sm-6 col-md-4">
              <label for="editMemberShipAmount">Membership Amount <span class="required-marker">*</span></label>
              <input type="number" class="form-control" id="editMemberShipAmount" name="editMemberShipAmount" min="0">
            </div>
            <div class="form-group col-xs-12">
              <label for="editFullAddress">Full Address <span class="required-marker">*</span></label>
              <textarea class="form-control" id="editFullAddress" name="editFullAddress" rows="3"></textarea>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="updateMemberBtn">Update</button>
      </div>
    </div>
  </div>
</div>

<div id="deleteConfirmModal" class="modal delete-confirm-modal" role="dialog" aria-labelledby="deleteConfirmTitle">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="deleteConfirmTitle">Delete Confirmation</h4>
      </div>
      <div class="modal-body">
        <p id="deleteConfirmMessage">Are you sure you want to delete?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-danger" id="deleteConfirmOkBtn">Delete</button>
      </div>
    </div>
  </div>
</div>

<script>
$(function () {
  function showMessage(message, type) {
    var alertClass = "alert-success";
    if (type === "error") {
      alertClass = "alert-danger";
    } else if (type === "warning") {
      alertClass = "alert-warning";
    }

    var html = '<div class="alert ' + alertClass + '"><strong>' + message + '</strong></div>';
    $("#alertBox").html(html);
    setTimeout(function () {
      $("#alertBox").html("");
    }, 3000);
  }

  function extractErrorMessage(jqXHR, fallbackMessage) {
    if (jqXHR && jqXHR.responseJSON) {
      if (jqXHR.responseJSON.message) {
        return jqXHR.responseJSON.message;
      }
      if (jqXHR.responseJSON.errorMessage) {
        return jqXHR.responseJSON.errorMessage;
      }
      if (jqXHR.responseJSON.error) {
        return jqXHR.responseJSON.error;
      }
    }
    if (jqXHR && jqXHR.responseText && $.trim(jqXHR.responseText) !== "") {
      return jqXHR.responseText;
    }
    return fallbackMessage;
  }

  function escapeHtml(value) {
    return $("<div/>").text(value == null ? "" : value).html();
  }

  function clearValidation(formSelector) {
    $(formSelector).find(".form-group").removeClass("has-error");
  }

  function validateFields(rules) {
    for (var i = 0; i < rules.length; i++) {
      var rule = rules[i];
      var $field = $(rule.selector);
      var value = $.trim($field.val());
      if (value === "") {
        $field.closest(".form-group").addClass("has-error");
        showMessage(rule.label + " is required", "error");
        $field.focus();
        return false;
      }
      if (rule.validator && !rule.validator(value)) {
        $field.closest(".form-group").addClass("has-error");
        showMessage(rule.message, "error");
        $field.focus();
        return false;
      }
    }
    return true;
  }

  function syncMembershipAmount(flagSelector, amountSelector) {
    var memberShipFlag = $(flagSelector).val();
    if (memberShipFlag === "true") {
      $(amountSelector).val("3000.00");
    } else if (memberShipFlag === "false") {
      $(amountSelector).val("0.00");
    }
  }

  function buildCreatePayload() {
    return {
      firstName: $.trim($("#firstName").val()),
      lastName: $.trim($("#lastName").val()),
      mobileNumber: $.trim($("#mobileNumber").val()),
      memberShipFlag: $("#memberShipFlag").val(),
      memberType: $("#memberType").val(),
      memberShipAmount: $.trim($("#memberShipAmount").val()),
      fullAddress: $.trim($("#fullAddress").val())
    };
  }

  function buildEditPayload() {
    return {
      firstName: $.trim($("#editFirstName").val()),
      lastName: $.trim($("#editLastName").val()),
      mobileNumber: $.trim($("#editMobileNumber").val()),
      memberShipFlag: $("#editMemberShipFlag").val(),
      memberType: $("#editMemberType").val(),
      memberShipAmount: $.trim($("#editMemberShipAmount").val()),
      fullAddress: $.trim($("#editFullAddress").val()),
      memberId: $("#editMemberId").val()
    };
  }

  function updateDownloadExcelHref() {
    var memberShipFlag = $("#memberShipFlag").val();
    var href = "/member/downloadExcel";
    if (memberShipFlag !== null && memberShipFlag !== undefined && memberShipFlag !== "") {
      href += "?memberShipFlag=" + encodeURIComponent(memberShipFlag);
    }
    $("#downloadExcel").attr("href", href);
  }

  function resetCreateForm() {
    $("#memberForm")[0].reset();
    clearValidation("#memberForm");
    updateDownloadExcelHref();
  }

  function resetEditForm() {
    $("#editMemberForm")[0].reset();
    clearValidation("#editMemberForm");
    $("#editMemberId").val("");
  }

  function showDeleteConfirmModal(message, onConfirm) {
    $("#deleteConfirmMessage").text(message || "Are you sure you want to delete?");
    $("#deleteConfirmOkBtn")
      .off("click.deleteConfirm")
      .on("click.deleteConfirm", function () {
        $("#deleteConfirmModal").modal("hide");
        if (typeof onConfirm === "function") {
          onConfirm();
        }
      });

    $("#deleteConfirmModal")
      .off("hidden.bs.modal.deleteConfirm")
      .on("hidden.bs.modal.deleteConfirm", function () {
        $("#deleteConfirmOkBtn").off("click.deleteConfirm");
      });

    $("#deleteConfirmModal").modal("show");
  }

  function loadMembers() {
    var memberShipFlag = $("#memberShipFlag").val();
    var url = "/member/fetch";
    if (memberShipFlag !== null && memberShipFlag !== undefined && memberShipFlag !== "") {
      url = "/member/fetch/" + memberShipFlag;
    }

    $.ajax({
      url: url,
      type: "GET",
      contentType: "application/json"
    }).done(function (data) {
      var trHTML = "";
      var totalMembershipAmount = 0;
      $("#tbdata").empty();

      if (data && data.length > 0) {
        $.each(data, function (index, item) {
          var memberAmount = Number(item.memberShipAmount || 0);
          totalMembershipAmount += memberAmount;

          var membershipBadge = item.memberShipFlag === true
            ? '<span class="label label-success">Yes</span>'
            : '<span class="label label-danger">No</span>';

          trHTML += '<tr>'
            + '<td>' + (index + 1) + '</td>'
            + '<td>' + escapeHtml(item.firstName) + '</td>'
            + '<td>' + escapeHtml(item.lastName) + '</td>'
            + '<td>' + escapeHtml(item.mobileNumber) + '</td>'
            + '<td>' + escapeHtml(item.memberType) + '</td>'
            + '<td>' + membershipBadge + '</td>'
            + '<td>' + memberAmount + '</td>'
            + '<td class="table-action-buttons">'
            + '<button type="button" class="btn btn-success btn-sm js-edit-member" data-id="' + item.memberId + '"><span class="glyphicon glyphicon-pencil"></span></button>'
            + '<button type="button" class="btn btn-danger btn-sm js-delete-member" data-id="' + item.memberId + '"><span class="glyphicon glyphicon-trash"></span></button>'
            + '<button type="button" class="btn btn-info btn-sm js-print-member" data-id="' + item.memberId + '"><span class="glyphicon glyphicon-print"></span></button>'
            + '</td>'
            + '</tr>';
        });
      } else {
        trHTML = '<tr><td colspan="8" class="text-center text-danger">No search found</td></tr>';
      }

      $("#tbdata").append(trHTML);
      $("#totalMembershipAmount").text("( Total Membership Amount : " + totalMembershipAmount + " )");
      $("#investorListDiv").show();
    }).fail(function (jqXHR) {
      showMessage(extractErrorMessage(jqXHR, "Unable to fetch membership details"), "error");
    });
  }

  var createValidationRules = [
    { selector: "#firstName", label: "First name" },
    { selector: "#lastName", label: "Last name" },
    {
      selector: "#mobileNumber",
      label: "Mobile number",
      validator: function (value) { return /^\d{10}$/.test(value); },
      message: "Mobile number must be exactly 10 digits"
    },
    { selector: "#memberType", label: "Member type" },
    { selector: "#memberShipFlag", label: "Membership" },
    { selector: "#memberShipAmount", label: "Membership amount" },
    { selector: "#fullAddress", label: "Full address" }
  ];

  var editValidationRules = [
    { selector: "#editFirstName", label: "First name" },
    { selector: "#editLastName", label: "Last name" },
    {
      selector: "#editMobileNumber",
      label: "Mobile number",
      validator: function (value) { return /^\d{10}$/.test(value); },
      message: "Mobile number must be exactly 10 digits"
    },
    { selector: "#editMemberType", label: "Member type" },
    { selector: "#editMemberShipFlag", label: "Membership" },
    { selector: "#editMemberShipAmount", label: "Membership amount" },
    { selector: "#editFullAddress", label: "Full address" }
  ];

  $(document).on("input change", ".form-control", function () {
    $(this).closest(".form-group").removeClass("has-error");
  });

  $("#memberShipFlag").on("change", function () {
    syncMembershipAmount("#memberShipFlag", "#memberShipAmount");
    updateDownloadExcelHref();
  });

  $("#editMemberShipFlag").on("change", function () {
    syncMembershipAmount("#editMemberShipFlag", "#editMemberShipAmount");
  });

  $("#save").on("click", function () {
    clearValidation("#memberForm");
    if (!validateFields(createValidationRules)) {
      return;
    }

    $.ajax({
      url: "/member/save",
      type: "POST",
      contentType: "application/json",
      dataType: "json",
      data: JSON.stringify(buildCreatePayload())
    }).done(function () {
      showMessage("Member saved successfully", "success");
      resetCreateForm();
      loadMembers();
    }).fail(function (jqXHR) {
      showMessage(extractErrorMessage(jqXHR, "Unable to save member"), "error");
    });
  });

  $("#search").on("click", function () {
    loadMembers();
  });

  $("#downloadExcel").on("click", function () {
    updateDownloadExcelHref();
  });

  $(document).on("click", ".js-delete-member", function () {
    var memberId = $(this).data("id");
    showDeleteConfirmModal("Delete this member?", function () {
      $.ajax({
        url: "/member/delete/" + memberId,
        type: "GET",
        contentType: "application/json"
      }).done(function () {
        showMessage("Member deleted successfully", "success");
      }).fail(function (jqXHR) {
        showMessage(extractErrorMessage(jqXHR, "Unable to delete member"), "error");
      }).always(function () {
        loadMembers();
      });
    });
  });

  $(document).on("click", ".js-edit-member", function () {
    var memberId = $(this).data("id");
    clearValidation("#editMemberForm");

    $.ajax({
      url: "/member/edit/" + memberId,
      type: "GET",
      contentType: "application/json"
    }).done(function (data) {
      $("#editFirstName").val(data.firstName);
      $("#editLastName").val(data.lastName);
      $("#editMobileNumber").val(data.mobileNumber);
      $("#editFullAddress").val(data.fullAddress);
      $("#editMemberType").val(data.memberType);
      $("#editMemberShipAmount").val(data.memberShipAmount);
      $("#editMemberShipFlag").val(data.memberShipFlag === true ? "true" : "false");
      $("#editMemberId").val(data.memberId);
      $("#editMemberModal").modal("show");
    }).fail(function (jqXHR) {
      showMessage(extractErrorMessage(jqXHR, "Unable to load member details"), "error");
    });
  });

  $("#updateMemberBtn").on("click", function () {
    clearValidation("#editMemberForm");
    if (!validateFields(editValidationRules)) {
      return;
    }

    $.ajax({
      url: "/member/save",
      type: "POST",
      contentType: "application/json",
      dataType: "json",
      data: JSON.stringify(buildEditPayload())
    }).done(function () {
      showMessage("Member updated successfully", "success");
      $("#editMemberModal").modal("hide");
      loadMembers();
    }).fail(function (jqXHR) {
      showMessage(extractErrorMessage(jqXHR, "Unable to update member"), "error");
    });
  });

  $(document).on("click", ".js-print-member", function () {
    var id = $(this).data("id");
    window.open("membershipCard/" + id);
  });

  $("#editMemberModal").on("hidden.bs.modal", function () {
    resetEditForm();
  });

  updateDownloadExcelHref();
  loadMembers();
});
</script>
</body>
</html>
