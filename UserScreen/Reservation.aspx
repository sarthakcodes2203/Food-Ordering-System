<%@ Page Title="" Language="C#" MasterPageFile="~/UserScreen/User.master" AutoEventWireup="true" CodeFile="Reservation.aspx.cs" Inherits="UserScreen_Reservation" %>

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

    <!-- book section -->
    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-end">
                    <asp:Label ID="lblMsg" runat="server"></asp:Label>
                </div>
                <h2>Enjoy Your Dine</h2>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form_container">

                        <div>
                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Name is required" ControlToValidate="txtName" Font-Bold="true" Font-Size="10" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Your Name" ToolTip="Name"></asp:TextBox>
                        </div>
                        <div>
                            <asp:RegularExpressionValidator ID="revMobile" runat="server" ErrorMessage="Mobile No. must have 10 digits"
                                Font-Bold="true" Font-Size="10" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationExpression="[0-9]{10}$"
                                ControlToValidate="txtMobile"></asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ErrorMessage="Phone Number is required" ControlToValidate="txtMobile" Font-Bold="true" Font-Size="10" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" placeholder="Contact Number" ToolTip="Mobile No."></asp:TextBox>
                        </div>
                        <div>
                            <asp:RegularExpressionValidator ID="revEmail" runat="server" ErrorMessage="Invalid Email ID"
                                Font-Bold="true" Font-Size="10" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationExpression="^[A-Za-z0-9._%+-]+@gmail\.com$"
                                ControlToValidate="txtEmail"></asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Email ID is required" ControlToValidate="txtEmail" Font-Bold="true" Font-Size="10" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email ID" ToolTip="Email"></asp:TextBox>
                        </div>
                        <div>
                            <asp:DropDownList ID="ddlPersons" runat="server" CssClass="form-control nice-select wide" AppendDataBoundItems="true">
                                <asp:ListItem Text="How many persons?" Value="" Disabled="true" Selected="true"></asp:ListItem>
                                <asp:ListItem Text="2 persons" Value="2"></asp:ListItem>
                                <asp:ListItem Text="3 persons" Value="3"></asp:ListItem>
                                <asp:ListItem Text="4 persons" Value="4"></asp:ListItem>
                                <asp:ListItem Text="5 persons" Value="5"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvPersons" runat="server" ErrorMessage="Please select number of persons" ControlToValidate="ddlPersons" ForeColor="Red" Display="Dynamic" InitialValue="" SetFocusOnError="true"></asp:RequiredFieldValidator>
                        </div>
                        <%-- <div>
                                <asp:DropDownList ID="ddlRestaurants" runat="server" CssClass="form-control nice-select wide" AppendDataBoundItems="true">
                                <asp:ListItem Text="Where do you want to dine?" Value="" Disabled="true" Selected="true"></asp:ListItem>
                                <asp:ListItem Text="Kohinoor" Value="2"></asp:ListItem>
                                <asp:ListItem Text="Delta Suites" Value="3"></asp:ListItem>
                                <asp:ListItem Text="The Banquet" Value="4"></asp:ListItem>
                                <asp:ListItem Text="City Residency" Value="5"></asp:ListItem>
                                </asp:DropDownList>                                          
                                <asp:RequiredFieldValidator ID="rfvRestaurants" runat="server" ErrorMessage="Please select number of persons" ControlToValidate="ddlPersons" ForeColor="Red" Display="Dynamic" InitialValue="" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </div>--%>
                        <%--<div>
                                <label for="txtDate">Select your Date:</label>
                                <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvDate" runat="server" ErrorMessage="Date is required" ControlToValidate="txtDate" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </div>
                            <div>
                                <label for="txtDate">Select your Time:</label>
                                <asp:TextBox ID="txtTimeSlot" runat="server" CssClass="form-control" TextMode="Time"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvTimeSlot" runat="server" ErrorMessage="Time slot is required" ControlToValidate="txtTimeSlot" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </div>--%>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="txtDate" class="form-label">Select your Date:</label>
                                <asp:RequiredFieldValidator ID="rfvDate" runat="server" ErrorMessage="Date is required" ControlToValidate="txtDate" Font-Bold="true" Font-Size="10" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label for="txtTimeSlot" class="form-label">Select your Time:</label>
                                <asp:RequiredFieldValidator ID="rfvTimeSlot" runat="server" ErrorMessage="Time slot is required" ControlToValidate="txtTimeSlot" Font-Bold="true" Font-Size="10" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtTimeSlot" runat="server" CssClass="form-control" TextMode="Time"></asp:TextBox>
                            </div>
                        </div>

                        <div class="btn_box">
                            <asp:Button ID="btnSubmit" runat="server" Text="Confirm" CssClass="btn btn-success rounded-pill pl-4 pr-4 text-white" OnClick="btnSubmit_Click" />
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                             <div class="img-box">
            <img src="../Templates/images/reserve.jpeg" alt="">
          </div>
        </div>
                            </div>

                </div>
            </div>
        </div>
    </section>
    <!-- end book section -->

</asp:Content>

