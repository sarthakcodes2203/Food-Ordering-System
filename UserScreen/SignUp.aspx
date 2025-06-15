<%@ Page Title="" Language="C#" MasterPageFile="~/UserScreen/User.master" AutoEventWireup="true" CodeFile="SignUp.aspx.cs" Inherits="UserScreen_SignUp" %>

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
    <script>
        function imagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=imgUser.ClientID %>').prop('src', e.target.result).width(200).height(200);
                };
                reader.readAsDataURL(input.files[0]);
                }
            }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-end">
                    <asp:label id="lblMsg" runat="server" visible="false"></asp:label>
                </div>
                <asp:label id="lblHeaderMsg" runat="server" text="<h2>User Registration</h2>"></asp:label>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form_container">
                        <div>
                            <asp:requiredfieldvalidator id="rfvName" runat="server" errormessage="Name is required" controltovalidate="txtName"
                                forecolor="Red" font-size="10" display="Dynamic" setfocusonerror="true" font-bold="true"></asp:requiredfieldvalidator>
                            <asp:regularexpressionvalidator id="revName" runat="server" errormessage="Name must be in characters only"
                                font-bold="true" font-size="10" display="Dynamic" forecolor="Red" setfocusonerror="true" validationexpression="^[a-zA-Z\s]+$"
                                controltovalidate="txtName"></asp:regularexpressionvalidator>
                            <asp:textbox id="txtName" runat="server" cssclass="form-control" placeholder="Enter Full Name"
                                tooltip="Full Name"></asp:textbox>
                        </div>
                        <div>
                            <asp:requiredfieldvalidator id="rfvUsername" runat="server" errormessage="Username is required" controltovalidate="txtUsername"
                                forecolor="Red" font-size="10" display="Dynamic" setfocusonerror="true" font-bold="true"></asp:requiredfieldvalidator>
                            <asp:textbox id="txtUsername" runat="server" cssclass="form-control" placeholder="Enter Username"
                                tooltip="Username"></asp:textbox>
                        </div>
                        <div>
                              <asp:RegularExpressionValidator ID="revEmail" runat="server" errormessage="Invalid Email ID"
                                font-bold="true" font-size="10" display="Dynamic" forecolor="Red" setfocusonerror="true" validationexpression="^[A-Za-z0-9._%+-]+@gmail\.com$"
                                controltovalidate="txtEmail"></asp:RegularExpressionValidator>
                            <asp:requiredfieldvalidator id="rfvEmail" runat="server" errormessage="Email is required" controltovalidate="txtEmail"
                                forecolor="Red" font-size="10" display="Dynamic" setfocusonerror="true" font-bold="true"></asp:requiredfieldvalidator>
                            <asp:textbox id="txtEmail" runat="server" cssclass="form-control" placeholder="Enter Email"
                                tooltip="Email"></asp:textbox>
                        </div>
                        <div>
                            <asp:requiredfieldvalidator id="rfvMobile" runat="server" errormessage="Mobile No. is required" controltovalidate="txtMobile"
                                forecolor="Red" font-size="10" display="Dynamic" setfocusonerror="true" font-bold="true"></asp:requiredfieldvalidator>
                            <asp:regularexpressionvalidator id="revMobile" runat="server" errormessage="Mobile No. must have 10 digits"
                                font-bold="true" font-size="10" display="Dynamic" forecolor="Red" setfocusonerror="true" validationexpression="[0-9]{10}$"
                                controltovalidate="txtMobile"></asp:regularexpressionvalidator>
                            <asp:textbox id="txtMobile" runat="server" cssclass="form-control" placeholder="Enter Mobile No."
                                tooltip="Mobile No." textmode="Number"></asp:textbox>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form_container">
                        <div>
                            <asp:requiredfieldvalidator id="rfvAddress" runat="server" errormessage="Address is required" controltovalidate="txtAddress"
                                forecolor="Red" font-size="10" display="Dynamic" setfocusonerror="true" font-bold="true"></asp:requiredfieldvalidator>
                            <asp:textbox id="txtAddress" runat="server" cssclass="form-control" placeholder="Enter Address"
                                tooltip="Address" textmode="MultiLine"></asp:textbox>
                        </div>
                        <div>
                            <asp:requiredfieldvalidator id="rfvPostCode" runat="server" errormessage="Post/Zip Code is required" controltovalidate="txtPostCode"
                                forecolor="Red" font-size="10" display="Dynamic" setfocusonerror="true" font-bold="true"></asp:requiredfieldvalidator>
                            <asp:regularexpressionvalidator id="revPostCode" runat="server" errormessage="Post/Zip Code must be of 6 digits"
                                font-bold="true" font-size="10" display="Dynamic" forecolor="Red" setfocusonerror="true" validationexpression="[0-9]{6}$"
                                controltovalidate="txtPostCode"></asp:regularexpressionvalidator>
                            <asp:textbox id="txtPostCode" runat="server" cssclass="form-control" placeholder="Enter Post/Zip Code"
                                tooltip="Post/Zip Code" textmode="Number"></asp:textbox>
                        </div>
                        <div>
                            <asp:fileupload id="fuUserImage" runat="server" cssclass="form-control" tooltip="User Image" onchange="imagePreview(this);" />
                        </div>
                        <div>
                            <asp:requiredfieldvalidator id="rfvPassword" runat="server" errormessage="Password is required" controltovalidate="txtPassword"
                                forecolor="Red" font-size="10" display="Dynamic" setfocusonerror="true" font-bold="true"></asp:requiredfieldvalidator>
                            <asp:textbox id="txtPassword" runat="server" cssclass="form-control" placeholder="Enter Password"
                                tooltip="Password" textmode="Password"></asp:textbox>
                        </div>
                    </div>
                </div>

                <div class="row pl-4">
                    <div class="btn_box">
                        <asp:button id="btnRegister" runat="server" text="Register" cssclass="btn btn-success rounded-pill pl-4 pr-4 text-white" onclick="btnRegister_Click" />
                        <asp:label id="lblAlreadyUser" runat="server" cssclass="pl-3 text-black-100*"
                            text="Already registered? &nbsp; <a href='Login.aspx' class='badge badge-info'>Login Here..</a>"></asp:label>
                    </div>
                </div>

                <div class="row p-5">
                    <div style="align-items: center">
                        <asp:image id="imgUser" runat="server" cssclass="img-thumbnail" />
                    </div>
                </div>
            </div>
    </section>

</asp:Content>
