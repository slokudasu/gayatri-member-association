<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Maintenance</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="/css/bootstrap.min.css">
  <link rel="stylesheet" href="/css/association-common.css">
  <script src="/js/jquery.min.js"></script>
  <script src="/js/bootstrap.min.js"></script>
  <style>
    :root {
      --maintenance-primary: #5b6fd2;
      --maintenance-primary-dark: #4a5fc2;
      --maintenance-primary-light: #eef1ff;
      --maintenance-border: #ccd5ff;
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
      border-color: var(--maintenance-primary);
      box-shadow: 0 2px 10px rgba(35, 39, 47, 0.08);
    }

    .panel-primary > .panel-heading {
      border-color: var(--maintenance-primary-dark);
      background: var(--maintenance-primary-dark);
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
      border-color: var(--maintenance-primary);
      box-shadow: 0 0 0 0.2rem rgba(91, 111, 210, 0.16);
    }

    .form-group.has-error .form-control {
      border-color: #d9534f;
    }

    .action-bar .btn,
    .action-bar a.btn {
      margin-right: 8px;
      margin-bottom: 8px;
      min-width: 100px;
    }

    .table > thead > tr > th {
      background: var(--maintenance-primary-light);
      color: #38498e;
      border-color: var(--maintenance-border);
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
      background: #f2f5ff;
      border-bottom: 1px solid #dce3ff;
    }

    .modal-title {
      color: #3e4f9c;
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
            <span class="heading-title">Maintenance</span>
          </div>
        </div>
        <div class="panel-body">
          <form id="maintenanceForm" autocomplete="off">
            <div class="row">
              <div class="form-group col-sm-6 col-md-3">
                <label for="memberId">Member Name <span class="required-marker">*</span></label>
                <select class="form-control" id="memberId" name="memberId">
                  <option value="">--Select--</option>
                </select>
              </div>
              <div class="form-group col-sm-6 col-md-3">
                <label for="year">Year <span class="required-marker">*</span></label>
                <select class="form-control" id="year" name="year">
                  <option value="">--Select--</option>
                </select>
              </div>
              <div class="form-group col-sm-6 col-md-3">
                <label for="month">Month <span class="required-marker">*</span></label>
                <select class="form-control" id="month" name="month">
                  <option value="">--Select--</option>
                  <option value="January">January</option>
                  <option value="February">February</option>
                  <option value="March">March</option>
                  <option value="April">April</option>
                  <option value="May">May</option>
                  <option value="June">June</option>
                  <option value="July">July</option>
                  <option value="August">August</option>
                  <option value="September">September</option>
                  <option value="October">October</option>
                  <option value="November">November</option>
                  <option value="December">December</option>
                </select>
              </div>
              <div class="form-group col-sm-6 col-md-3">
                <label for="amount">Amount <span class="required-marker">*</span></label>
                <input type="number" class="form-control" id="amount" name="amount" min="0" value="300">
              </div>
              <div class="form-group col-sm-6 col-md-3">
                <label for="status">Status <span class="required-marker">*</span></label>
                <select class="form-control" id="status" name="status">
                  <option value="">--Select--</option>
                  <option value="Paid">Paid</option>
                  <option value="Unpaid">Unpaid</option>
                </select>
              </div>
            </div>
            <div class="form-group col-xs-12 action-bar">
              <button type="button" class="btn btn-success" id="save">Save</button>
              <button type="button" class="btn btn-primary" id="search">Search</button>
              <a id="downloadExcel" href="/maintenance/downloadExcel" class="btn btn-default" role="button">Download Excel</a>
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
          Maintenance Details
          <label id="totalMembershipAmount" style="color: #ffef73; margin-bottom: 0;"></label>
        </div>
        <div class="panel-body">
          <div class="table-responsive">
            <table class="table table-bordered table-striped table-hover">
              <thead>
              <tr>
                <th>Sl.No</th>
                <th>Member Name</th>
                <th>Year</th>
                <th>Month</th>
                <th>Amount</th>
                <th>Status</th>
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

<div id="editMaintenanceModal" class="modal fade" role="dialog" aria-labelledby="editMaintenanceTitle">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" id="editMaintenanceTitle">Edit Maintenance</h4>
      </div>
      <div class="modal-body">
        <form id="editMaintenanceForm" autocomplete="off">
          <input type="hidden" id="editId" name="editId">
          <div class="row">
            <div class="form-group col-sm-6 col-md-4">
              <label for="editMemberId">Member Name <span class="required-marker">*</span></label>
              <select class="form-control" id="editMemberId" name="editMemberId">
                <option value="">--Select--</option>
              </select>
            </div>
            <div class="form-group col-sm-6 col-md-4">
              <label for="editYear">Year <span class="required-marker">*</span></label>
              <select class="form-control" id="editYear" name="editYear">
                <option value="">--Select--</option>
              </select>
            </div>
            <div class="form-group col-sm-6 col-md-4">
              <label for="editMonth">Month <span class="required-marker">*</span></label>
              <select class="form-control" id="editMonth" name="editMonth">
                <option value="">--Select--</option>
                <option value="January">January</option>
                <option value="February">February</option>
                <option value="March">March</option>
                <option value="April">April</option>
                <option value="May">May</option>
                <option value="June">June</option>
                <option value="July">July</option>
                <option value="August">August</option>
                <option value="September">September</option>
                <option value="October">October</option>
                <option value="November">November</option>
                <option value="December">December</option>
              </select>
            </div>
            <div class="form-group col-sm-6 col-md-4">
              <label for="editAmount">Amount <span class="required-marker">*</span></label>
              <input type="number" class="form-control" id="editAmount" name="editAmount" min="0">
            </div>
            <div class="form-group col-sm-6 col-md-4">
              <label for="editStatus">Status <span class="required-marker">*</span></label>
              <select class="form-control" id="editStatus" name="editStatus">
                <option value="">--Select--</option>
                <option value="Paid">Paid</option>
                <option value="Unpaid">Unpaid</option>
              </select>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="updateMaintenanceBtn">Update</button>
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

  function parseMemberSelection(value) {
    if (!value) {
      return null;
    }
    var parts = value.split("~");
    if (parts.length < 2) {
      return null;
    }
    return {
      memberId: parts[0],
      memberName: parts.slice(1).join("~")
    };
  }

  function updateDownloadExcelHref() {
    var memberSelection = parseMemberSelection($("#memberId").val());
    var memberId = memberSelection ? memberSelection.memberId : "";
    var year = $("#year").val() || "";
    var month = $("#month").val() || "";
    var status = $("#status").val() || "";
    var queryParams = [];
    if (memberId !== "") {
      queryParams.push("memberId=" + encodeURIComponent(memberId));
    }
    if (year !== "") {
      queryParams.push("year=" + encodeURIComponent(year));
    }
    if (month !== "") {
      queryParams.push("month=" + encodeURIComponent(month));
    }
    if (status !== "") {
      queryParams.push("status=" + encodeURIComponent(status));
    }

    var href = "/maintenance/downloadExcel";
    if (queryParams.length > 0) {
      href += "?" + queryParams.join("&");
    }
    $("#downloadExcel").attr("href", href);
  }

  function ensureMemberOption($select, value, text) {
    var exists = false;
    $select.find("option").each(function () {
      if ($(this).val() === value) {
        exists = true;
        return false;
      }
      return true;
    });
    if (!exists) {
      $select.append($("<option/>", { value: value, text: text }));
    }
  }

  function populateYearOptions(selector) {
    var $select = $(selector);
    var currentYear = new Date().getFullYear();
    var startYear = Math.max(currentYear - 5, 2020);
    $select.empty().append('<option value="">--Select--</option>');
    for (var year = currentYear; year >= startYear; year--) {
      $select.append($("<option/>", { value: year, text: year }));
    }
  }

  function resetCreateForm() {
    $("#maintenanceForm")[0].reset();
    $("#amount").val("300");
    clearValidation("#maintenanceForm");
  }

  function resetEditForm() {
    $("#editMaintenanceForm")[0].reset();
    $("#editId").val("");
    clearValidation("#editMaintenanceForm");
  }

  function buildCreatePayload() {
    var selectedMember = parseMemberSelection($("#memberId").val());
    return {
      memberId: selectedMember ? selectedMember.memberId : "",
      memberName: selectedMember ? selectedMember.memberName : "",
      year: $("#year").val(),
      month: $("#month").val(),
      amount: $.trim($("#amount").val()),
      status: $("#status").val()
    };
  }

  function buildEditPayload() {
    var selectedMember = parseMemberSelection($("#editMemberId").val());
    return {
      id: $("#editId").val(),
      memberId: selectedMember ? selectedMember.memberId : "",
      memberName: selectedMember ? selectedMember.memberName : "",
      year: $("#editYear").val(),
      month: $("#editMonth").val(),
      amount: $.trim($("#editAmount").val()),
      status: $("#editStatus").val()
    };
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

  function loadMemberOptions(callback) {
    $.ajax({
      url: "/member/fetch",
      type: "GET",
      contentType: "application/json"
    }).done(function (data) {
      var $memberSelect = $("#memberId");
      var $editMemberSelect = $("#editMemberId");
      $memberSelect.empty().append('<option value="">--Select--</option>');
      $editMemberSelect.empty().append('<option value="">--Select--</option>');

      if (data && data.length > 0) {
        $.each(data, function (_, item) {
          var memberName = $.trim((item.firstName || "") + " " + (item.lastName || ""));
          var optionValue = item.memberId + "~" + memberName;
          var $option = $("<option/>", { value: optionValue, text: memberName });
          $memberSelect.append($option);
          $editMemberSelect.append($option.clone());
        });
      }
    }).fail(function (jqXHR) {
      showMessage(extractErrorMessage(jqXHR, "Unable to load members"), "error");
    }).always(function () {
      if (typeof callback === "function") {
        callback();
      }
    });
  }

  function loadMaintenanceList() {
    var memberSelection = parseMemberSelection($("#memberId").val());
    var memberId = memberSelection ? memberSelection.memberId : "";
    var year = $("#year").val();
    var month = $("#month").val() || "";
    var status = $("#status").val() || "";
    var queryParams = [];
    if (memberId !== "") {
      queryParams.push("memberId=" + encodeURIComponent(memberId));
    }
    if (year !== "") {
      queryParams.push("year=" + encodeURIComponent(year));
    }
    if (month !== "") {
      queryParams.push("month=" + encodeURIComponent(month));
    }
    if (status !== "") {
      queryParams.push("status=" + encodeURIComponent(status));
    }

    var url = "/maintenance/search";
    if (queryParams.length > 0) {
      url += "?" + queryParams.join("&");
    }

    $.ajax({
      url: url,
      type: "GET",
      contentType: "application/json"
    }).done(function (data) {
      var trHTML = "";
      var totalMaintenanceAmount = 0;
      $("#tbdata").empty();

      if (data && data.length > 0) {
        $.each(data, function (index, item) {
          var amount = Number(item.amount || 0);
          totalMaintenanceAmount += amount;
          var hasRecordId = item.id !== null && item.id !== undefined && String(item.id).trim() !== "";

          var statusBadge = item.status === "Paid"
            ? '<span class="label label-success">Paid</span>'
            : '<span class="label label-danger">' + escapeHtml(item.status || "Unpaid") + '</span>';

          var actionButtons = "";
          if (hasRecordId) {
            actionButtons = '<button type="button" class="btn btn-success btn-sm js-edit-maintenance" data-id="' + item.id + '"><span class="glyphicon glyphicon-pencil"></span></button>'
              + '<button type="button" class="btn btn-danger btn-sm js-delete-maintenance" data-id="' + item.id + '"><span class="glyphicon glyphicon-trash"></span></button>'
              + '<button type="button" class="btn btn-info btn-sm js-print-maintenance" data-id="' + item.id + '"><span class="glyphicon glyphicon-print"></span></button>';
          }

          trHTML += '<tr>'
            + '<td>' + (index + 1) + '</td>'
            + '<td>' + escapeHtml(item.memberName) + '</td>'
            + '<td>' + escapeHtml(item.year) + '</td>'
            + '<td>' + escapeHtml(item.month) + '</td>'
            + '<td>' + amount + '</td>'
            + '<td>' + statusBadge + '</td>'
            + '<td class="table-action-buttons">'
            + actionButtons
            + '</td>'
            + '</tr>';
        });
      } else {
        trHTML = '<tr><td colspan="7" class="text-center text-danger">No search found</td></tr>';
      }

      $("#tbdata").append(trHTML);
      $("#totalMembershipAmount").text("( Total Maintenance Amount : " + totalMaintenanceAmount + " )");
      $("#investorListDiv").show();
    }).fail(function (jqXHR) {
      showMessage(extractErrorMessage(jqXHR, "Unable to fetch maintenance details"), "error");
    });
  }

  var createValidationRules = [
    { selector: "#memberId", label: "Member name" },
    { selector: "#year", label: "Year" },
    { selector: "#month", label: "Month" },
    {
      selector: "#amount",
      label: "Amount",
      validator: function (value) { return Number(value) > 0; },
      message: "Amount should be greater than zero"
    },
    { selector: "#status", label: "Status" }
  ];

  var editValidationRules = [
    { selector: "#editMemberId", label: "Member name" },
    { selector: "#editYear", label: "Year" },
    { selector: "#editMonth", label: "Month" },
    {
      selector: "#editAmount",
      label: "Amount",
      validator: function (value) { return Number(value) > 0; },
      message: "Amount should be greater than zero"
    },
    { selector: "#editStatus", label: "Status" }
  ];

  $(document).on("input change", ".form-control", function () {
    $(this).closest(".form-group").removeClass("has-error");
  });

  $("#save").on("click", function () {
    clearValidation("#maintenanceForm");
    if (!validateFields(createValidationRules)) {
      return;
    }

    $.ajax({
      url: "/maintenance/save",
      type: "POST",
      contentType: "application/json",
      dataType: "json",
      data: JSON.stringify(buildCreatePayload())
    }).done(function () {
      showMessage("Maintenance saved successfully", "success");
      resetCreateForm();
      loadMaintenanceList();
    }).fail(function (jqXHR) {
      showMessage(extractErrorMessage(jqXHR, "Unable to save maintenance"), "error");
    });
  });

  $("#search").on("click", function () {
    loadMaintenanceList();
  });

  $(document).on("click", ".js-delete-maintenance", function () {
    var id = $(this).data("id");
    showDeleteConfirmModal("Delete this maintenance record?", function () {
      $.ajax({
        url: "/maintenance/delete/" + id,
        type: "GET",
        contentType: "application/json"
      }).done(function () {
        showMessage("Maintenance record deleted successfully", "success");
      }).fail(function (jqXHR) {
        showMessage(extractErrorMessage(jqXHR, "Unable to delete maintenance record"), "error");
      }).always(function () {
        loadMaintenanceList();
      });
    });
  });

  $(document).on("click", ".js-edit-maintenance", function () {
    var id = $(this).data("id");
    clearValidation("#editMaintenanceForm");

    $.ajax({
      url: "/maintenance/edit/" + id,
      type: "GET",
      contentType: "application/json"
    }).done(function (data) {
      var memberValue = data.memberId + "~" + data.memberName;
      ensureMemberOption($("#editMemberId"), memberValue, data.memberName);

      $("#editId").val(data.id);
      $("#editMemberId").val(memberValue);
      $("#editYear").val(data.year);
      $("#editMonth").val(data.month);
      $("#editAmount").val(data.amount);
      $("#editStatus").val(data.status);
      $("#editMaintenanceModal").modal("show");
    }).fail(function (jqXHR) {
      showMessage(extractErrorMessage(jqXHR, "Unable to load maintenance details"), "error");
    });
  });

  $("#updateMaintenanceBtn").on("click", function () {
    clearValidation("#editMaintenanceForm");
    if (!validateFields(editValidationRules)) {
      return;
    }

    $.ajax({
      url: "/maintenance/save",
      type: "POST",
      contentType: "application/json",
      dataType: "json",
      data: JSON.stringify(buildEditPayload())
    }).done(function () {
      showMessage("Maintenance updated successfully", "success");
      $("#editMaintenanceModal").modal("hide");
      loadMaintenanceList();
    }).fail(function (jqXHR) {
      showMessage(extractErrorMessage(jqXHR, "Unable to update maintenance"), "error");
    });
  });

  $("#downloadExcel").on("click", function () {
    updateDownloadExcelHref();
  });

  $(document).on("click", ".js-print-maintenance", function () {
    var id = $(this).data("id");
    window.open("paymentReceipt/" + id);
  });

  $("#editMaintenanceModal").on("hidden.bs.modal", function () {
    resetEditForm();
  });

  populateYearOptions("#year");
  populateYearOptions("#editYear");
  $("#memberId, #year, #month, #status").on("change", function () {
    updateDownloadExcelHref();
  });
  updateDownloadExcelHref();
  loadMemberOptions(function () {
    loadMaintenanceList();
  });
});
</script>
</body>
</html>
