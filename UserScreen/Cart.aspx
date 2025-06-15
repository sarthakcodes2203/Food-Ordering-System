<%@ Page Title="" Language="C#" MasterPageFile="~/UserScreen/User.master" AutoEventWireup="true" CodeFile="Cart.aspx.cs" Inherits="UserScreen_Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>
        (function ($) {
            $(document).ready(function () {
                var proQty = $('.pro-qty');
                proQty.prepend('<span class="dec qtybtn" style="height:50%;line-height:26px;">-</span>');
                proQty.append('<span class="inc qtybtn" style="height:50%;line-height:26px;">+</span>');

                proQty.on('click', '.qtybtn', function () {
                    var $button = $(this);
                    var $input = $button.parent().find('input');
                    var oldValue = $input.val();
                    var newVal;

                    if ($button.hasClass('inc')) {
                        newVal = (oldValue >= 10) ? oldValue : parseFloat(oldValue) + 1;
                    } else {
                        newVal = (oldValue > 1) ? parseFloat(oldValue) - 1 : 1;
                    }
                    $input.val(newVal);
                });
            });
        })(jQuery);
    </script>
    <style>
        .table td{
            vertical-align: unset;
        }

        .qtybtn {
            color: #dfdfdf;
        }

        .pro-qty {
            display: flex;
            align-items: center;
            gap: 10px;
            justify-content: center;
            margin: 10px;
            padding: 0;
            width: 212px;
            border: 0;
        }

        .pro-qty input {
                width: 60px;
                height: 40px;
                text-align: center;
                font-size: 18px;
                border: 2px solid #ccc;
                border-radius: 10px;
        }

        .pro-qty .qtybtn {
                width: 40px;
                border-radius: 50%;
                color: #fff;
                text-align: center;
                user-select: none;
                font-size: 20px;
            }

            .pro-qty .inc {
                background-color: green;
            }

            .pro-qty .dec {
                background-color: red;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-end">
                    <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
                </div>
                <h2>Your Food Basket</h2>
            </div>
        </div>

        <div class="container">
            <asp:Repeater ID="rCartItem" runat="server" OnItemCommand="rCartItem_ItemCommand" OnItemDataBound="rCartItem_ItemDataBound">
                <HeaderTemplate>
                    <table class="table ">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Image</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total Amount</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                        </td>
                        <td>
                            <img width="60" src="<%#Utils.GetImageUrl(Eval("ImageUrl")) %>" alt="IMG" />
                        </td>
                        <td style="width:13rem">
                            ₹<asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Price") %>'></asp:Label>
                            <asp:HiddenField ID="hdnProductId" runat="server" Value='<%# Eval("ProductId") %>' />
                            <asp:HiddenField ID="hdnQuantity" runat="server" Value='<%# Eval("Qty") %>' />
                            <asp:HiddenField ID="hdnPrdQuantity" runat="server" Value='<%# Eval("PrdQty") %>' />
                        </td>
                        <td>
                            <div class="product__details__option">
                                <div class="quantity">
                                    <div class="pro-qty" style="width:110px;padding:0 10px 0 0;border:0;">
                                        <asp:TextBox ID="txtQuantity" runat="server" style="width:33px;" Text='<%# Eval("qty") %>'>
                                        </asp:TextBox>
                                        <asp:RegularExpressionValidator ID="revQuantity" runat="server" ErrorMessage="*" ForeColor="Red" Font-Size="Small" ValidationExpression="[1-9]*" ControlToValidate="txtQuantity" Display="Dynamic" SetFocusOnError="true" EnableClientScript="true"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>₹<asp:Label ID="lblTotalPrice" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:LinkButton ID="lbDelete" runat="server" Text="Remove" CommandName="remove" CommandArgument='<%# Eval("ProductId") %>' OnClientClick="return confirm('Remove this item from bucket?');">
                                <i class="fa fa-close"></i>
                            </asp:LinkButton>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    <tr>
                        <td colspan="3"></td>
                        <td class="pl-lg-3">
                            <b>Payable Bill:</b>
                        </td>
                        <td>
                            ₹<% Response.Write(Session["grandTotalPrice"]); %>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td  class="continue__btn">
                            <a href="Menu.aspx" class="btn btn-info"><i class="fa fa-arrow-circle-left mr-2"></i>Add more</a>
                        </td>
                          <td></td>
                        <td>
                            <asp:LinkButton ID="lbUpdateCart" runat="server" CommandName="updateCart" CssClass="btn btn-warning"><i class="fa fa-refresh ml-2 mr-2 "></i> Update Basket </asp:LinkButton>
                        </td>
                      
                        <td>
                            <asp:LinkButton ID="lbClearCart" runat="server" CommandName="clearCart" CssClass="btn btn-danger">Clear Basket<i class="fa fa-trash ml-2 mr-2 "></i> </asp:LinkButton>
                        </td>
                        <td>
                            <asp:LinkButton ID="lbCheckout" runat="server" CommandName="checkout" CssClass="btn btn-success">Checkout<i class="fa fa-arrow-circle-right ml-2"></i></asp:LinkButton>
                        </td>
                    </tr>
                    </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </section>



</asp:Content>

