﻿<%@ Page Title="" Language="C#" MasterPageFile="~/UserScreen/User.master" AutoEventWireup="true" CodeFile="Invoice.aspx.cs" Inherits="UserScreen_Invoice" %>

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

    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-end">
                    <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
                </div>
                <h2>Your Order Invoice</h2>
            </div>
        </div>

        <div class="container">
            <asp:Repeater ID="rOrderItem" runat="server">

                <HeaderTemplate>
                    <table class="table table-responsive-sm table-bordered table-hover" id="tblInvoice">
                        <thead class="bg-dark text-white">
                            <tr>
                                <th>Sl No.</th>
                                <th>Order Number</th>
                                <th>Item Name</th>
                                <th>Unit Price</th>
                                <th>Quantity</th>
                                <th>Total Price</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>

                <ItemTemplate>
                    <tr>
                        <td><%# Eval("SrNo") %></td>
                        <td><%# Eval("OrderNo") %></td>
                        <td><%# Eval("Name") %></td>
                        <td><%# string.IsNullOrEmpty(Eval("Price").ToString())? "" : "₹"+Eval("Price") %></td>
                        <td><%# Eval("Quantity") %></td>
                        <td>₹<%# Eval("TotalPrice") %></td>
                    </tr>
                </ItemTemplate>

                <FooterTemplate>
                    </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>

            <div class="text-center">
                <asp:LinkButton ID="lbDownloadInvoice" runat="server" CssClass="btn btn-info" OnClick="lbDownloadInvoice_Click">
                    <i class="fa fa-file-pdf-o mr-2"></i>
                    Download Invoice
                </asp:LinkButton>
            </div>
        </div>
    </section>
</asp:Content>

