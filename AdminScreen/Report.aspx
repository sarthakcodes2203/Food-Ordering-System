<%@ Page Title="" Language="C#" MasterPageFile="~/AdminScreen/Admin.master" AutoEventWireup="true" CodeFile="Report.aspx.cs" Inherits="AdminScreen_Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="pcoded-inner-content pt-0">

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
                                            <h4 class="sub-title">Sales Report</h4>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">

                                                    <asp:repeater id="rReport" runat="server">
                                                        <HeaderTemplate>
                                                            <table class="table data-table-export table-hover nowrap">
                                                                <thead>
                                                                    <tr>
                                                                        <th class="table-plus">SrNo</th>
                                                                        <th>Full Name</th>
                                                                        <th>Email</th>
                                                                        <th>Item Orders</th>
                                                                        <th>Total Price</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td class="table-plus"><%# Eval("SrNo") %></td>
                                                                <td><%# Eval("Name") %></td>
                                                                <td><%# Eval("Email") %></td>
                                                                <td><%# Eval("TotalOrders") %></td>
                                                                <td><%# Eval("TotalPrice") %></td>
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