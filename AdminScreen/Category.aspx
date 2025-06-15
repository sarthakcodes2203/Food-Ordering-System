<%@ Page Title="Category" Language="C#" MasterPageFile="~/AdminScreen/Admin.master" AutoEventWireup="true" CodeFile="Category.aspx.cs" Inherits="AdminScreen_Category" %>

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
                    $('#<%=imgCategory.ClientID %>').prop('src', e.target.result).width(200).height(200);
                };
                reader.readAsDataURL(input.files[0]);
                }
            }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

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

                                        <div class="col-sm-6 col-md-4 co1-lg-4">
                                            <h4 class="sub-title">Category</h4>
                                            <div>

                                                <div class="form-group">
                                                    <label>Category Name <span class="text-danger font-weight-bold">*</span></label>
                                                    <div>
                                                        <asp:textbox id="txtName" runat="server" cssclass="form-control" placeholder="Enter Category Name"></asp:textbox>
                                                        <asp:hiddenfield id="hdnId" runat="server" value="0" />
                                                        <asp:requiredfieldvalidator id="rfvName" runat="server" errormessage="*Name is required*"
                                                             Font-Bold="true" Font-Size="10" ControlToValidate="txtName" Display="Dynamic" ForeColor="Red"
                                                             SetFocusOnError="True"></asp:requiredfieldvalidator>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>Category Image</label>
                                                    <div>
                                                        <asp:fileupload id="fuCategoryImage" runat="server" cssclass="form-control" onchange="imagePreview(this);" />
                                                    </div>
                                                </div>

                                                <div class="form-check pl-4">
                                                    <asp:checkbox id="cbIsActive" runat="server" text="&nbsp; IsActive" cssclass="form-check-input" />
                                                </div>

                                                <div class="pb-5">
                                                    <asp:button id="btnAddOrUpdate" runat="server" text="Add" cssclass="btn btn-primary" onclick="btnAddOrUpdate_Click" />
                                                    &nbsp;
                                                    <asp:button id="btnClear" runat="server" text="Clear" cssclass="btn btn-primary" causesvalidation="false" onclick="btnClear_Click" />
                                                </div>

                                                <div>
                                                    <asp:image id="imgCategory" runat="server" cssclass="img-thumbnail" Visible="false" />
                                                </div>

                                            </div>
                                        </div>

                                        <div class="col-sm-6 col-md-8 co1-lg-8 mobile-inputs">
                                            <h4 class="sub-title">Category Lists</h4>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">

                                                    <asp:Repeater id="rptrCategory" runat="server" OnItemCommand="rptrCategory_ItemCommand" OnItemDataBound="rptrCategory_ItemDataBound">
                                                        <HeaderTemplate>
                                                            <table class="table data-table-export table-hover nowrap">
                                                                <thead>
                                                                    <tr>
                                                                        <th class="table-plus">Name</th>
                                                                        <th>Image</th>
                                                                        <th>IsActive</th>
                                                                        <th>Creation Date</th>
                                                                        <th class="datatable-nosort">Action</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td class="table-plus"><%# Eval("Name") %></td>
                                                                <td>
                                                                    <img alt="" width="40" height="50" src="<%# Utils.GetImageUrl(Eval("ImageUrl")) %>" /></td>
                                                                <td>
                                                                    <asp:Label ID="lblIsActive" runat="server" Text='<%# Eval("IsActive") %>'></asp:Label></td>
                                                                <td><%# Eval("CreationDate") %></td>
                                                                <td>
                                                                    <asp:LinkButton ID="lnkEdit" Text="Edit" runat="server" CssClass="badge badge-primary"
                                                                        CausesValidation="false" CommandArgument='<%# Eval("CategoryId") %>' CommandName="edit">
                                                                            <i class="ti-pencil"></i>
                                                                    </asp:LinkButton>
                                                                    <asp:LinkButton ID="lnkDelete" Text="Delete" runat="server" CommandName="delete"
                                                                        CausesValidation="false" CssClass="badge bg-danger" CommandArgument='<%# Eval("CategoryId") %>'
                                                                        OnClientClick="return confirm('Do you want to delete this category?');">
                                                                            <i class="ti-trash"></i>
                                                                    </asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            </tbody>
                                                            </table>
                                                        </FooterTemplate>
                                                    </asp:Repeater>

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
    </div>

</asp:Content>
