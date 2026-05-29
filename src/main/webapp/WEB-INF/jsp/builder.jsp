<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Builders</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="/css/bootstrap.min.css">
  <link rel="stylesheet" href="/css/association-common.css">
  <script src="/js/jquery.min.js"></script>
  <script src="/js/bootstrap.min.js"></script>
  <style>
    :root {
      --builder-primary: #1f8d7b;
      --builder-primary-dark: #177667;
      --builder-primary-light: #e8f8f4;
      --builder-border: #c4ece3;
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
      border-color: var(--builder-primary);
      box-shadow: 0 2px 10px rgba(35, 39, 47, 0.08);
    }

    .panel-primary > .panel-heading {
      border-color: var(--builder-primary-dark);
      background: var(--builder-primary-dark);
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
      border-color: var(--builder-primary);
      box-shadow: 0 0 0 0.2rem rgba(31, 141, 123, 0.16);
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
      background: var(--builder-primary-light);
      color: #196e60;
      border-color: var(--builder-border);
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
      background: #ebfaf7;
      border-bottom: 1px solid #cff0e8;
    }

    .modal-title {
      color: #1b7163;
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
            <span class="heading-title">Builders</span>
          </div>
        </div>
        <div class="panel-body">
          <form id="builderForm" autocomplete="off">
            <div class="row">
              <div class="form-group col-sm-6 col-md-3">
                <label for="builderName">Builder Name <span class="required-marker">*</span></label>
                <input type="text" class="form-control" id="builderName" name="builderName">
              </div>
              <div class="form-group col-sm-6 col-md-3">
                <label for="amount">Amount <span class="required-marker">*</span></label>
                <input type="number" class="form-control" id="amount" name="amount" min="0">
              </div>
              <div class="form-group col-sm-6 col-md-3">
                <label for="plotNumber">Construction Plot No <span class="required-marker">*</span></label>
                <input type="text" class="form-control" id="plotNumber" name="plotNumber">
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
              <a id="downloadExcel" href="/builder/downloadExcel" class="btn btn-default" role="button">Download Excel</a>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>

  <div class="row" id="builderListDiv">
    <div class="col-xs-12">
      <div class="panel panel-primary">
        <div class="panel-heading">
          Builder Details
          <label id="totalBuilderAmount" style="color: #ffef73; margin-bottom: 0;"></label>
        </div>
        <div class="panel-body">
          <div class="table-responsive">
            <table class="table table-bordered table-striped table-hover">
              <thead>
              <tr>
                <th>Sl.No</th>
                <th>Builder Name</th>
                <th>Amount</th>
                <th>Status</th>
                <th>Construction Plot No</th>
                <th>Updated Date</th>
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

<div id="editBuilderModal" class="modal fade" role="dialog" aria-labelledby="editBuilderTitle">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" id="editBuilderTitle">Edit Builder</h4>
      </div>
      <div class="modal-body">
        <form id="editBuilderForm" autocomplete="off">
          <input type="hidden" id="editBuilderId" name="editBuilderId">
          <div class="row">
            <div class="form-group col-sm-6 col-md-4">
              <label for="editBuilderName">Builder Name <span class="required-marker">*</span></label>
              <input type="text" class="form-control" id="editBuilderName" name="editBuilderName">
            </div>
            <div class="form-group col-sm-6 col-md-4">
              <label for="editAmount">Amount <span class="required-marker">*</span></label>
              <input type="number" class="form-control" id="editAmount" name="editAmount" min="0">
            </div>
            <div class="form-group col-sm-6 col-md-4">
              <label for="editPlotNumber">Construction Plot No <span class="required-marker">*</span></label>
              <input type="text" class="form-control" id="editPlotNumber" name="editPlotNumber">
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
        <button type="button" class="btn btn-primary" id="updateBuilderBtn">Update</button>
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

  function resetCreateForm() {
    $("#builderForm")[0].reset();
    clearValidation("#builderForm");
    updateDownloadExcelHref();
  }

  function resetEditForm() {
    $("#editBuilderForm")[0].reset();
    $("#editBuilderId").val("");
    clearValidation("#editBuilderForm");
  }

  function buildCreatePayload() {
    return {
      builderName: $.trim($("#builderName").val()),
      amount: $.trim($("#amount").val()),
      status: $("#status").val(),
      plotNumber: $.trim($("#plotNumber").val())
    };
  }

  function buildEditPayload() {
    return {
      id: $("#editBuilderId").val(),
      builderName: $.trim($("#editBuilderName").val()),
      amount: $.trim($("#editAmount").val()),
      status: $("#editStatus").val(),
      plotNumber: $.trim($("#editPlotNumber").val())
    };
  }

  function updateDownloadExcelHref() {
    var status = $("#status").val();
    var href = "/builder/downloadExcel";
    if (status !== null && status !== "") {
      href += "?status=" + encodeURIComponent(status);
    }
    $("#downloadExcel").attr("href", href);
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

  function loadBuilders() {
    $.ajax({
      url: "/builder/fetch",
      type: "GET",
      contentType: "application/json"
    }).done(function (data) {
      var trHTML = "";
      var totalBuilderAmount = 0;
      $("#tbdata").empty();

      if (data && data.length > 0) {
        $.each(data, function (index, item) {
          var amount = Number(item.amount || 0);
          var status = item.status || "Unpaid";
          var paidStatus = status === "Paid"
            ? '<span class="label label-success">Paid</span>'
            : '<span class="label label-danger">Unpaid</span>';

          if (status === "Paid") {
            totalBuilderAmount += amount;
          }

          trHTML += '<tr>'
            + '<td>' + (index + 1) + '</td>'
            + '<td>' + escapeHtml(item.builderName) + '</td>'
            + '<td>' + amount + '</td>'
            + '<td>' + paidStatus + '</td>'
            + '<td>' + escapeHtml(item.plotNumber) + '</td>'
            + '<td>' + escapeHtml(item.creationDateTime) + '</td>'
            + '<td class="table-action-buttons">'
            + '<button type="button" class="btn btn-success btn-sm js-edit-builder"'
            + ' data-id="' + item.id + '"'
            + ' data-builder-name="' + encodeURIComponent(item.builderName || "") + '"'
            + ' data-amount="' + amount + '"'
            + ' data-status="' + encodeURIComponent(status) + '"'
            + ' data-plot-number="' + encodeURIComponent(item.plotNumber || "") + '">'
            + '<span class="glyphicon glyphicon-pencil"></span></button>'
            + '<button type="button" class="btn btn-danger btn-sm js-delete-builder" data-id="' + item.id + '"><span class="glyphicon glyphicon-trash"></span></button>'
            + '</td>'
            + '</tr>';
        });
      } else {
        trHTML = '<tr><td colspan="7" class="text-center text-danger">No search found</td></tr>';
      }

      $("#tbdata").append(trHTML);
      $("#totalBuilderAmount").text("( Total Builders Amount : " + totalBuilderAmount + " )");
      $("#builderListDiv").show();
    }).fail(function (jqXHR) {
      showMessage(extractErrorMessage(jqXHR, "Unable to fetch builder details"), "error");
    });
  }

  var createValidationRules = [
    { selector: "#builderName", label: "Builder name" },
    {
      selector: "#amount",
      label: "Amount",
      validator: function (value) { return Number(value) > 0; },
      message: "Amount should be greater than zero"
    },
    { selector: "#plotNumber", label: "Construction plot number" },
    { selector: "#status", label: "Status" }
  ];

  var editValidationRules = [
    { selector: "#editBuilderName", label: "Builder name" },
    {
      selector: "#editAmount",
      label: "Amount",
      validator: function (value) { return Number(value) > 0; },
      message: "Amount should be greater than zero"
    },
    { selector: "#editPlotNumber", label: "Construction plot number" },
    { selector: "#editStatus", label: "Status" }
  ];

  $(document).on("input change", ".form-control", function () {
    $(this).closest(".form-group").removeClass("has-error");
  });

  $("#status").on("change", function () {
    updateDownloadExcelHref();
  });

  $("#save").on("click", function () {
    clearValidation("#builderForm");
    if (!validateFields(createValidationRules)) {
      return;
    }

    $.ajax({
      url: "/builder/save",
      type: "POST",
      contentType: "application/json",
      dataType: "json",
      data: JSON.stringify(buildCreatePayload())
    }).done(function () {
      showMessage("Builder details saved successfully", "success");
      resetCreateForm();
      loadBuilders();
    }).fail(function (jqXHR) {
      showMessage(extractErrorMessage(jqXHR, "Unable to save builder details"), "error");
    });
  });

  $("#search").on("click", function () {
    loadBuilders();
  });

  $("#downloadExcel").on("click", function () {
    updateDownloadExcelHref();
  });

  $(document).on("click", ".js-edit-builder", function () {
    clearValidation("#editBuilderForm");

    $("#editBuilderId").val($(this).data("id"));
    $("#editBuilderName").val(decodeURIComponent($(this).attr("data-builder-name") || ""));
    $("#editAmount").val($(this).attr("data-amount"));
    $("#editStatus").val(decodeURIComponent($(this).attr("data-status") || ""));
    $("#editPlotNumber").val(decodeURIComponent($(this).attr("data-plot-number") || ""));
    $("#editBuilderModal").modal("show");
  });

  $("#updateBuilderBtn").on("click", function () {
    clearValidation("#editBuilderForm");
    if (!validateFields(editValidationRules)) {
      return;
    }

    $.ajax({
      url: "/builder/save",
      type: "POST",
      contentType: "application/json",
      dataType: "json",
      data: JSON.stringify(buildEditPayload())
    }).done(function () {
      showMessage("Builder details updated successfully", "success");
      $("#editBuilderModal").modal("hide");
      loadBuilders();
    }).fail(function (jqXHR) {
      showMessage(extractErrorMessage(jqXHR, "Unable to update builder details"), "error");
    });
  });

  $(document).on("click", ".js-delete-builder", function () {
    var id = $(this).data("id");
    showDeleteConfirmModal("Delete this builder record?", function () {
      $.ajax({
        url: "/builder/delete/" + id,
        type: "GET",
        contentType: "application/json"
      }).done(function () {
        showMessage("Builder details deleted successfully", "success");
      }).fail(function (jqXHR) {
        showMessage(extractErrorMessage(jqXHR, "Unable to delete builder record"), "error");
      }).always(function () {
        loadBuilders();
      });
    });
  });

  $("#editBuilderModal").on("hidden.bs.modal", function () {
    resetEditForm();
  });

  updateDownloadExcelHref();
  loadBuilders();
});
</script>
</body>
</html>
