<%@ Page Title="" Language="C#" MasterPageFile="~/AdminScreen/Admin.master" AutoEventWireup="true" CodeFile="Reservations.aspx.cs" Inherits="AdminScreen_Reservations" %>

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
    
   <%-- <div class="pcoded-inner-content pt-0">
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

                                        <div class="col-12 mobile-inputs">
                                            <h4 class="sub-title">Reservations List</h4>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">

                                                    <asp:repeater id="rptrReservations" runat="server" onitemcommand="rptrReservations_ItemCommand">
                                                        <HeaderTemplate>
                                                            <table class="table data-table-export table-hover nowrap">
                                                                <thead>
                                                                    <tr>
                                                                        <th class="table-plus">SrNo</th>
                                                                        <th>Name</th>
                                                                        <th>Phone No.</th>
                                                                        <th>Number of Persons</th>
                                                                        <th>Reservation Date</th>
                                                                        <th>Reservation Time</th>
                                                                        <th>Creation Date</th>
                                                                        <th class="datatable-nosort">Action</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td class="table-plus"><%# Eval("ReservationId") %></td>
                                                                <td><%# Eval("Name") %></td>
                                                                <td><%# Eval("PhoneNo") %></td>
								                                <td><%# Eval("NumOfPersons") %></td>
                                                                <td><%# Eval("ForDate") %></td>
                                                                <td><%# Eval("ForTime") %></td>
                                                                <td><%# Eval("CreatedAt") %></td>
                                                                <td>
                                                                    <asp:LinkButton ID="lnkDelete" Text="Delete" runat="server" CommandName="delete"
                                                                        CausesValidation="false" CssClass="badge bg-danger" CommandArgument='<%# Eval("ReservationId") %>'
                                                                        OnClientClick="return confirm('Do you want to delete this Reservation?');">
                                                                            <i class="ti-trash"></i>
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

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>--%>
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
                                            <h4 class="sub-title">Reservations List</h4>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">

                                                    <asp:repeater id="rReservationStatus" runat="server" onitemcommand="rReservationStatus_ItemCommand">
                                                        <HeaderTemplate>
                                                            <table class="table data-table-export table-hover nowrap">
                                                                <thead>
                                                                    <tr>
                                                                        <th class="table-plus">Rev No.</th>
                                                                        <th>Name</th>
                                                                        <th>Rev Date</th>
                                                                        <th>Rev Time</th>
                                                                        <th>Status</th>
                                                                        <th>Phone No.</th>
                                                                        <th>Email ID</th>
                                                                        <th>Number of Persons</th>
                                                                        <th class="datatable-nosort">Edit</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                             <tr>
                                                                <td class="table-plus"><%# Eval("ReservationId") %></td>
                                                                <td><%# Eval("Name") %></td>
                                                                <td><%# Eval("ForDate") %></td>
                                                                <td><%# Eval("ForTime") %></td>
                                                                <td>
                                                                    <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>' CssClass='<%# Eval("Status").ToString()=="Confirmed" ? "badge badge-success" : "badge badge-warning" %>'></asp:Label>
                                                                </td>
                                                                <td><%# Eval("PhoneNo") %></td>
                                                                <td><%# Eval("Email") %></td>
                                                                <td><%# Eval("NumOfPersons") %></td>
                                                                <td>
                                                                    <asp:LinkButton ID="lnkEdit" Text="Edit" runat="server" CommandName="edit"
                                                                        CausesValidation="false" CssClass="badge bg-primary" CommandArgument='<%# Eval("ReservationId") %>'>
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
                                            <asp:panel id="pUpdateReservationStatus" runat="server">
                                                 <h4 class="sub-title">Update Status</h4>
                                            <div>

                                                <div class="form-group">
                                                    <label>Reservation Status <span class="text-danger font-weight-bold">*</span></label>
                                                    <div>
                                                        <asp:DropDownList Id="ddlReservationStatus" runat="server" CssClass="form-control">
                                                            <asp:ListItem runat="server" Value="0">-Select-</asp:ListItem>
                                                            <asp:ListItem runat="server" Value="Pending">Pending</asp:ListItem>
                                                            <asp:ListItem runat="server" Value="Declined">Declined</asp:ListItem>
                                                            <asp:ListItem runat="server" Value="Confirmed">Confirmed</asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:requiredfieldvalidator id="rfvDdlReservationStatus" runat="server" errormessage="*Reservation Status is required*"
                                                             Font-Bold="true" Font-Size="10" ControlToValidate="ddlReservationStatus" Display="Dynamic" ForeColor="Red"
                                                             SetFocusOnError="True" InitialValue="0"></asp:requiredfieldvalidator>
                                                        <asp:hiddenfield id="hdnId" runat="server" value="0" />
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

