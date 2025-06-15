<%@ Page Title="" Language="C#" MasterPageFile="~/UserScreen/User.master" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="UserScreen_Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- book section -->
    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-end">
                    <asp:Label ID="lblMsg" runat="server"></asp:Label>
                </div>

                <h2>Send Your Query</h2>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form_container">
                            <div>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Your Name"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Name is required" ControlToValidate="txtName" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </div>
                            <div>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Your Email Address" TextMode="Email"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Email is required" ControlToValidate="txtEmail" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>

                            </div>
                            <div>
                                <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" placeholder="Whats the Issue?" ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvSubject" runat="server" ErrorMessage="Let us know about your Issue" ControlToValidate="txtSubject" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </div>
                            <div>
                                <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" placeholder="Detailed Query/Feedback" ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvMessage" runat="server" ErrorMessage="Please type-in your Query or Feedback" ControlToValidate="txtMessage" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </div>
                            <div class="btn_box">
                                <asp:Button ID="btnSubmit" runat="server" Text="Send" CssClass="btn btn-warning rounded-pill pl-4 pr-4 text-white" OnClick="btnSubmit_Click" />
                            </div>
                    </div>
                </div>
                <%--<div class="col-md-6">
                    <div class="map_container ">
                        <div id="googleMap">
            <img src="../Templates/images/location.png" alt="">
        
        </div>
                    </div>
                </div>--%>

                <div class="col-md-6">
  <div class="img-box">
<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3002.2152726657696!2d73.19021687516349!3d33.74629893382401!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x38dfc30055c9dc6d%3A0xfeb43c2741eb20fc!2sCravify!5e1!3m2!1sen!2sin!4v1749487328156!5m2!1sen!2sin" width="500" height="350" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>  </div>
</div>

            </div>
        </div>
    </section>
    <!-- end book section -->

</asp:Content>
