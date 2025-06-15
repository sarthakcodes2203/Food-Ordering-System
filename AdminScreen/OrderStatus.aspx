<%@ Page Title="Order Status" Language="C#" MasterPageFile="~/AdminScreen/Admin.master" AutoEventWireup="true" CodeFile="OrderStatus.aspx.cs" Inherits="AdminScreen_OrderStatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>
        /*For displaying Alert messages*/
        window.onload = function () {
            var seconds = 5; // Example: wait for 5 seconds
            setTimeout(function () {
                var msgElement = document.getElementById("<%= lblMsg.ClientID %>");
                if (msgElement) { // Check if the element exists
                    msgElement.style.display = "none";
                }
            }, seconds * 1000);
        };
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div class="pcoded-inner-content pt-0">
        <div class="align-self-end">
            <asp:label id="lblMsg" runat="server" visible="false"></asp:label>
        </div>
        <div class="main-body">
            <div class="page-wrapper">
                <div class="page-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-header">
                                </div>
                                <div class="card-block">
                                    <div class="row">

                                        <div class="col-sm-6 col-md-8 co1-lg-8">
                                            <h4 class="sub-title">Order List</h4>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">

                                                    <asp:repeater id="rOrderStatus" runat="server" onitemcommand="rOrderStatus_ItemCommand">
                                                        <HeaderTemplate>
                                                            <table class="table data-table-export table-hover nowrap">
                                                                <thead>
                                                                    <tr>
                                                                        <th class="table-plus">Order No.</th>
                                                                        <th>Order Date</th>
                                                                        <th>Status</th>
                                                                        <th>Product Name</th>
                                                                        <th>Total Price</th>
                                                                        <th>Payment Mode</th>
                                                                        <th>Recipient Name</th>
                                                                        <th>Delivery Address</th>
                                                                        <th class="datatable-nosort">Edit</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td class="table-plus"><%# Eval("OrderNo") %></td>
                                                                <td><%# Eval("OrderDate") %></td>
                                                                <td>
                                                                    <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>' CssClass='<%# Eval("Status").ToString()=="Delivered" ? "badge badge-success" : "badge badge-warning" %>'></asp:Label>
                                                                </td>
                                                                <td><%# Eval("Name") %></td>
                                                                <td><%# Eval("TotalPrice") %></td>
                                                                <td><%# Eval("PaymentMode") %></td>
                                                                <td><%# Eval("RName") %></td>
                                                                <td><%# Eval("Address") %></td>
                                                                <td>
                                                                    <asp:LinkButton ID="lnkEdit" Text="Edit" runat="server" CssClass="badge badge-primary"
                                                                        CausesValidation="false" CommandArgument='<%# Eval("OrderDetailsId") %>' CommandName="edit">
                                                                            <i class="ti-pencil"></i>
                                                                    </asp:LinkButton>
                                                                </td>
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

                                        <div class="col-sm-6 col-md-4 co1-lg-4 mobile-inputs">
                                            <asp:panel id="pUpdateOrderStatus" runat="server">
                                                 <h4 class="sub-title">Update Status</h4>
                                            <div>

                                                <div class="form-group">
                                                    <label>Order Status <span class="text-danger font-weight-bold">*</span></label>
                                                    <div>
                                                        <asp:DropDownList Id="ddlOrderStatus" runat="server" CssClass="form-control">
                                                            <asp:ListItem runat="server" Value="0">-Select-</asp:ListItem>
                                                            <asp:ListItem runat="server" Value="Pending">Pending</asp:ListItem>
                                                            <asp:ListItem runat="server" Value="Delayed">Delayed</asp:ListItem>
                                                            <asp:ListItem runat="server" Value="Out for Delivery">Out for Delivery</asp:ListItem>
                                                            <asp:ListItem runat="server" Value="Delivered">Delivered</asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:requiredfieldvalidator id="rfvDdlOrderStatus" runat="server" errormessage="*Order Status is required*"
                                                             Font-Bold="true" Font-Size="10" ControlToValidate="ddlOrderStatus" Display="Dynamic" ForeColor="Red"
                                                             SetFocusOnError="True" InitialValue="0"></asp:requiredfieldvalidator>
                                                        <asp:hiddenfield id="hdnId" runat="server" value="0" />
                                                        <asp:HiddenField ID="hdnUserId" runat="server" Value="0" />
                                                    </div>
                                                </div>

                                                <div class="pb-5">
                                                    <asp:button id="btnUpdate" runat="server" text="Update" cssclass="btn btn-primary" onclick="btnUpdate_Click" />
                                                    &nbsp;
                                                    <asp:button id="btnCancel" runat="server" text="Cancel" cssclass="btn btn-primary" onclick="btnCancel_Click" />
                                                </div>
                                            </div>
                                            </asp:panel>

                                        </div>

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

