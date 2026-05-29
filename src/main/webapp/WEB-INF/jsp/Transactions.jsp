<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Transactions</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="/css/bootstrap.min.css">
  <link rel="stylesheet" href="/css/association-common.css">
  <script src="/js/jquery.min.js"></script>
  <script src="/js/bootstrap.min.js"></script>
  <style>
    :root {
      --transactions-primary: #2f86c1;
      --transactions-primary-dark: #1e75b0;
      --transactions-primary-light: #eaf5fd;
      --transactions-border: #c7e2f5;
    }

    body {
      background: #f4f6fb;
      color: #2f3340;
    }

    .page-shell {
      max-width: 1280px;
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
      border-color: var(--transactions-primary);
      box-shadow: 0 2px 10px rgba(35, 39, 47, 0.08);
    }

    .panel-primary > .panel-heading {
      border-color: var(--transactions-primary-dark);
      background: var(--transactions-primary-dark);
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
      border-color: var(--transactions-primary);
      box-shadow: 0 0 0 0.2rem rgba(47, 134, 193, 0.18);
    }

    .form-group.has-error .form-control {
      border-color: #d9534f;
    }

    .action-bar .btn {
      margin-right: 8px;
      margin-bottom: 8px;
      min-width: 100px;
    }

    .table > thead > tr > th {
      background: var(--transactions-primary-light);
      color: #245b82;
      border-color: var(--transactions-border);
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
      background: #edf7ff;
      border-bottom: 1px solid #d4eaff;
    }

    .modal-title {
      color: #24689b;
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

      .action-bar .btn {
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
            <span class="heading-title">Transactions</span>
          </div>
        </div>
        <div class="panel-body">
          <form id="transactionForm" autocomplete="off">
            <div class="row">
              <div class="form-group col-sm-6 col-md-4">
                <label for="transactionType">Transaction Type <span class="required-marker">*</span></label>
                <select class="form-control" id="transactionType" name="transactionType">
                  <option value="">--Select--</option>
                  <option value="Credit">Credit</option>
                  <option value="Debit">Debit</option>
                </select>
              </div>
              <div class="form-group col-sm-6 col-md-4">
                <label for="amount">Transaction Amount <span class="required-marker">*</span></label>
                <input type="number" class="form-control" id="amount" name="amount" min="0">
              </div>
              <div class="form-group col-sm-12 col-md-4">
                <label for="purposeOfTransaction">Purpose of Transaction <span class="required-marker">*</span></label>
                <textarea class="form-control" id="purposeOfTransaction" name="purposeOfTransaction" rows="2"></textarea>
              </div>
            </div>
            <div class="form-group col-xs-12 action-bar">
              <button type="button" class="btn btn-success" id="save">Save</button>
              <button type="button" class="btn btn-primary" id="search">Search</button>
              <a id="downloadExcel" href="/transactions/downloadExcel" class="btn btn-default" role="button">Download Excel</a>
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
          Transactions Details
          <label id="totalTransactionAmount" style="color: #ffef73; margin-bottom: 0;"></label>
        </div>
        <div class="panel-body">
          <div class="table-responsive">
            <table class="table table-bordered table-striped table-hover">
              <thead>
              <tr>
                <th>Sl.No</th>
                <th>Transaction Type</th>
                <th>Transaction Amount</th>
                <th>Purpose of Transaction</th>
                <th>Transaction Date</th>
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

<div id="editTransactionModal" class="modal fade" role="dialog" aria-labelledby="editTransactionTitle">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" id="editTransactionTitle">Edit Transaction</h4>
      </div>
      <div class="modal-body">
        <form id="editTransactionForm" autocomplete="off">
          <input type="hidden" id="editTransactionId" name="editTransactionId">
          <div class="row">
            <div class="form-group col-sm-6 col-md-4">
              <label for="editTransactionType">Transaction Type <span class="required-marker">*</span></label>
              <select class="form-control" id="editTransactionType" name="editTransactionType">
                <option value="">--Select--</option>
                <option value="Credit">Credit</option>
                <option value="Debit">Debit</option>
              </select>
            </div>
            <div class="form-group col-sm-6 col-md-4">
              <label for="editAmount">Transaction Amount <span class="required-marker">*</span></label>
              <input type="number" class="form-control" id="editAmount" name="editAmount" min="0">
            </div>
            <div class="form-group col-sm-12 col-md-4">
              <label for="editPurposeOfTransaction">Purpose of Transaction <span class="required-marker">*</span></label>
              <textarea class="form-control" id="editPurposeOfTransaction" name="editPurposeOfTransaction" rows="2"></textarea>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="updateTransactionBtn">Update</button>
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
    $("#transactionForm")[0].reset();
    clearValidation("#transactionForm");
    updateDownloadExcelHref();
  }

  function resetEditForm() {
    $("#editTransactionForm")[0].reset();
    $("#editTransactionId").val("");
    clearValidation("#editTransactionForm");
  }

  function buildCreatePayload() {
    return {
      transactionType: $("#transactionType").val(),
      amount: $.trim($("#amount").val()),
      purposeOfTransaction: $.trim($("#purposeOfTransaction").val())
    };
  }

  function buildEditPayload() {
    return {
      transactionType: $("#editTransactionType").val(),
      amount: $.trim($("#editAmount").val()),
      purposeOfTransaction: $.trim($("#editPurposeOfTransaction").val()),
      transactionId: $("#editTransactionId").val()
    };
  }

  function updateDownloadExcelHref() {
    var transactionType = $("#transactionType").val();
    var href = "/transactions/downloadExcel";
    if (transactionType !== null && transactionType !== "") {
      href += "?transactionType=" + encodeURIComponent(transactionType);
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

  function loadTransactions() {
    var transactionType = $("#transactionType").val();
    var url = "/transactions/fetch";
    if (transactionType !== null && transactionType !== "") {
      url = "/transactions/fetch/" + transactionType;
    }

    $.ajax({
      url: url,
      type: "GET",
      contentType: "application/json"
    }).done(function (data) {
      var trHTML = "";
      var totalTransactionAmount = 0;
      $("#tbdata").empty();

      if (data && data.length > 0) {
        $.each(data, function (index, item) {
          var amount = Number(item.amount || 0);
          var transactionBadge;
          if (item.transactionType === "Credit") {
            totalTransactionAmount += amount;
            transactionBadge = '<span class="label label-success">Credit</span>';
          } else {
            totalTransactionAmount -= amount;
            transactionBadge = '<span class="label label-danger">Debit</span>';
          }

          trHTML += '<tr>'
            + '<td>' + (index + 1) + '</td>'
            + '<td>' + transactionBadge + '</td>'
            + '<td>' + amount + '</td>'
            + '<td>' + escapeHtml(item.purposeOfTransaction) + '</td>'
            + '<td>' + escapeHtml(item.creationDateTime) + '</td>'
            + '<td class="table-action-buttons">'
            + '<button type="button" class="btn btn-success btn-sm js-edit-transaction" data-id="' + item.transactionId + '"><span class="glyphicon glyphicon-pencil"></span></button>'
            + '<button type="button" class="btn btn-danger btn-sm js-delete-transaction" data-id="' + item.transactionId + '"><span class="glyphicon glyphicon-trash"></span></button>'
            + '</td>'
            + '</tr>';
        });
      } else {
        trHTML = '<tr><td colspan="6" class="text-center text-danger">No search found</td></tr>';
      }

      $("#tbdata").append(trHTML);
      $("#totalTransactionAmount").text("( Total Transactions Amount : " + totalTransactionAmount + " )");
      $("#investorListDiv").show();
    }).fail(function (jqXHR) {
      showMessage(extractErrorMessage(jqXHR, "Unable to fetch transactions"), "error");
    });
  }

  var createValidationRules = [
    { selector: "#transactionType", label: "Transaction type" },
    {
      selector: "#amount",
      label: "Transaction amount",
      validator: function (value) { return Number(value) > 0; },
      message: "Transaction amount should be greater than zero"
    },
    { selector: "#purposeOfTransaction", label: "Purpose of transaction" }
  ];

  var editValidationRules = [
    { selector: "#editTransactionType", label: "Transaction type" },
    {
      selector: "#editAmount",
      label: "Transaction amount",
      validator: function (value) { return Number(value) > 0; },
      message: "Transaction amount should be greater than zero"
    },
    { selector: "#editPurposeOfTransaction", label: "Purpose of transaction" }
  ];

  $(document).on("input change", ".form-control", function () {
    $(this).closest(".form-group").removeClass("has-error");
  });

  $("#transactionType").on("change", function () {
    updateDownloadExcelHref();
  });

  $("#save").on("click", function () {
    clearValidation("#transactionForm");
    if (!validateFields(createValidationRules)) {
      return;
    }

    $.ajax({
      url: "/transactions/save",
      type: "POST",
      contentType: "application/json",
      dataType: "json",
      data: JSON.stringify(buildCreatePayload())
    }).done(function () {
      showMessage("Transaction saved successfully", "success");
      resetCreateForm();
      loadTransactions();
    }).fail(function (jqXHR) {
      showMessage(extractErrorMessage(jqXHR, "Unable to save transaction"), "error");
    });
  });

  $("#search").on("click", function () {
    loadTransactions();
  });

  $("#downloadExcel").on("click", function () {
    updateDownloadExcelHref();
  });

  $(document).on("click", ".js-delete-transaction", function () {
    var id = $(this).data("id");
    showDeleteConfirmModal("Delete this transaction?", function () {
      $.ajax({
        url: "/transactions/delete/" + id,
        type: "GET",
        contentType: "application/json"
      }).done(function () {
        showMessage("Transaction deleted successfully", "success");
      }).fail(function (jqXHR) {
        showMessage(extractErrorMessage(jqXHR, "Unable to delete transaction"), "error");
      }).always(function () {
        loadTransactions();
      });
    });
  });

  $(document).on("click", ".js-edit-transaction", function () {
    var id = $(this).data("id");
    clearValidation("#editTransactionForm");

    $.ajax({
      url: "/transactions/edit/" + id,
      type: "GET",
      contentType: "application/json"
    }).done(function (data) {
      $("#editTransactionType").val(data.transactionType);
      $("#editAmount").val(data.amount);
      $("#editPurposeOfTransaction").val(data.purposeOfTransaction);
      $("#editTransactionId").val(data.transactionId);
      $("#editTransactionModal").modal("show");
    }).fail(function (jqXHR) {
      showMessage(extractErrorMessage(jqXHR, "Unable to load transaction details"), "error");
    });
  });

  $("#updateTransactionBtn").on("click", function () {
    clearValidation("#editTransactionForm");
    if (!validateFields(editValidationRules)) {
      return;
    }

    $.ajax({
      url: "/transactions/save",
      type: "POST",
      contentType: "application/json",
      dataType: "json",
      data: JSON.stringify(buildEditPayload())
    }).done(function () {
      showMessage("Transaction updated successfully", "success");
      $("#editTransactionModal").modal("hide");
      loadTransactions();
    }).fail(function (jqXHR) {
      showMessage(extractErrorMessage(jqXHR, "Unable to update transaction"), "error");
    });
  });

  $("#editTransactionModal").on("hidden.bs.modal", function () {
    resetEditForm();
  });

  updateDownloadExcelHref();
  loadTransactions();
});
</script>
</body>
</html>
