<%@ Page Title="Menu" Language="C#" MasterPageFile="~/UserScreen/User.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="UserScreen_Login" %>

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
                    <asp:Label ID="lblMsg" runat="server"></asp:Label>
                </div>
                <h2>Login</h2>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form_container">
                        <img id="userLogin" src="../Images/login.jpg" alt="" class="img-thumbnail" />
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form_container">
                        <div>
                            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ErrorMessage="Username is required" ControlToValidate="txtUsername"
                                ForeColor="Red" Font-Size="10" Display="Dynamic" SetFocusOnError="true" Font-Bold="true"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter Username"></asp:TextBox>
                        </div>
                        <div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Password is required" ControlToValidate="txtPassword"
                                ForeColor="Red" Font-Size="10" Display="Dynamic" SetFocusOnError="true" Font-Bold="true"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Enter Password" textmode="Password"></asp:TextBox>
                        </div>
                        <div class="btn_box">
                            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-success rounded-pill pl-4 pr-4 text-white"
                                OnClick="btnLogin_Click" />
                            <span class="pl-3 text-info">New User? &nbsp; <a href="SignUp.aspx" class="badge badge-info">Register Now..</a></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>
