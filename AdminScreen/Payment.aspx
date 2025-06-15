<%@ Page Title="" Language="C#" MasterPageFile="~/AdminScreen/Admin.master" AutoEventWireup="true" CodeFile="Payment.aspx.cs" Inherits="AdminScreen_Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="main-body">
            <div class="page-wrapper">
                <div class="page-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-header">
                                    <div class="container">
                                        <div class="form-row">
                                            <div class="form-group col-md-4">
                                                <label>From Date</label>
                                                <asp:requiredfieldvalidator id="rfvFromDate" runat="server" forecolor="Red" errormessage="*" setfocusonerror="true" display="Dynamic" controltovalidate="txtFromDate"></asp:requiredfieldvalidator>
                                                <asp:textbox id="txtFromDate" runat="server" textmode="Date" cssclass="form-control"></asp:textbox>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label>To Date</label>
                                                <asp:requiredfieldvalidator id="rfvToDate" runat="server" forecolor="Red" errormessage="*" setfocusonerror="true" display="Dynamic" controltovalidate="txtToDate"></asp:requiredfieldvalidator>
                                                <asp:textbox id="txtToDate" runat="server" textmode="Date" cssclass="form-control"></asp:textbox>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <asp:button id="btnSearch" runat="server" text="Search" cssclass="btn btn-primary mt-md-4" onclick="btnSearch_Click" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-block">
                                    <div class="row">

                                        <div class="col-12 mobile-inputs">
                                            <h4 class="sub-title">Payments Report</h4>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">

                                                    <asp:repeater id="rReport" runat="server">
                                                        <HeaderTemplate>
                                                            <table class="table data-table-export table-hover nowrap">
                                                                <thead>
                                                                    <tr>
                                                                        <th class="table-plus">SrNo</th>
                                                                        <th>Product Name</th>
                                                                        <th>User ID</th>
                                                                        <th>Date</th>
                                                                        <th>Pay Mode</th>
                                                                        <th>Amount</th>
                                                                        <th>Status</th>
                                                                        <th>Order No.</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td class="table-plus"><%# Eval("SrNo") %></td>
                                                                <td><%# Eval("ProductName") %></td>
                                                                <td><%# Eval("UserId") %></td>
                                                                <td><%# Eval("PayDate") %></td>
                                                                <td><%# Eval("PaymentMode") %></td>
                                                                <td><%# Eval("Amount") %></td>
                                                                <td><%# Eval("PayStatus") %></td>
                                                                <td><%# Eval("OrderNo") %></td>
                                                            </tr>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            </tbody>
                                                            </table>
                                                        </FooterTemplate>
                                                    </asp:repeater>

                                                </div>
                                            </div>
                                        </div>

                                    </div>

                                    <div class="row pl-4">
                                        <asp:label id="lblTotal" runat="server" font-bold="true" font-size="Small"></asp:label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>