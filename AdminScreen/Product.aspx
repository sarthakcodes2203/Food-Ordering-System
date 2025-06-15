<%@ Page Title="Products" Language="C#" MasterPageFile="~/AdminScreen/Admin.master" AutoEventWireup="true" CodeFile="Product.aspx.cs" Inherits="AdminScreen_Product" %>

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
    <script>
        function imagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=imgProduct.ClientID %>').prop('src', e.target.result).width(200).height(200);
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
                                            <h4 class="sub-title">Product Lists</h4>
                                            <div>

                                                <div class="form-group">
                                                    <label>Product Name <span class="text-danger font-weight-bold">*</span></label>
                                                    <div>
                                                        <asp:textbox id="txtName" runat="server" cssclass="form-control" placeholder="Enter Product Name"></asp:textbox>
                                                        <asp:hiddenfield id="hdnId" runat="server" value="0" />
                                                        <asp:requiredfieldvalidator id="rfvName" runat="server" errormessage="Name is required"
                                                             Font-Bold="true" Font-Size="10" ControlToValidate="txtName" Display="Dynamic" ForeColor="Red"
                                                             SetFocusOnError="True"></asp:requiredfieldvalidator>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>Product Description <span class="text-danger font-weight-bold">*</span></label>
                                                    <div>
                                                        <asp:textbox id="txtDescription" runat="server" cssclass="form-control" placeholder="Enter Product Description"
                                                            textmode="MultiLine"></asp:textbox>
                                                        <asp:requiredfieldvalidator id="rfvDescription" runat="server" errormessage="Description is required"
                                                             Font-Bold="true" Font-Size="10" ControlToValidate="txtDescription" Display="Dynamic" ForeColor="Red"
                                                             SetFocusOnError="True"></asp:requiredfieldvalidator>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>Product Price(₹) <span class="text-danger font-weight-bold">*</span></label>
                                                    <div>
                                                        <asp:textbox id="txtPrice" runat="server" cssclass="form-control" placeholder="Enter Product Price"></asp:textbox>
                                                        <asp:requiredfieldvalidator id="rfvPrice" runat="server" errormessage="Price is required"
                                                             Font-Bold="true" Font-Size="10" ControlToValidate="txtPrice" Display="Dynamic" ForeColor="Red"
                                                             SetFocusOnError="True"></asp:requiredfieldvalidator>
                                                        <asp:regularexpressionvalidator id="revPrice" runat="server" errormessage="Price must be in Decimal"
                                                            Font-Bold="true" Font-Size="10" ControlToValidate="txtPrice" Display="Dynamic" ForeColor="Red" 
                                                            SetFocusOnError="True" validationexpression="^\d{0,8}(\.\d{1,4})?$"></asp:regularexpressionvalidator>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>Product Quantity <span class="text-danger font-weight-bold">*</span></label>
                                                    <div>
                                                        <asp:textbox id="txtQuantity" runat="server" cssclass="form-control" placeholder="Enter Product Quantity"></asp:textbox>
                                                        <asp:requiredfieldvalidator id="rfvQuantity" runat="server" errormessage="Quantity is required"
                                                             Font-Bold="true" Font-Size="10" ControlToValidate="txtQuantity" Display="Dynamic" ForeColor="Red"
                                                             SetFocusOnError="True"></asp:requiredfieldvalidator>
                                                        <asp:regularexpressionvalidator id="revQuantity" runat="server" errormessage="Quantity must be Non Negative"
                                                            Font-Bold="true" Font-Size="10" ControlToValidate="txtQuantity" Display="Dynamic" ForeColor="Red" 
                                                            SetFocusOnError="True" validationexpression="^(0|[1-9]\d*)$"></asp:regularexpressionvalidator>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>Product Image</label>
                                                    <div>
                                                        <asp:fileupload id="fuProductImage" runat="server" cssclass="form-control" onchange="imagePreview(this);" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>Product Category <span class="text-danger font-weight-bold">*</span></label>
                                                    <div>
                                                        <asp:dropdownlist id="ddlCategory" runat="server" cssclass="form-control" DataSourceID="sqlCategory" 
                                                            DataTextField="Name" DataValueField="CategoryId" appenddatabounditems="true">
                                                            <asp:listitem value="0">Select Category</asp:listitem>
                                                        </asp:dropdownlist>
                                                        <asp:requiredfieldvalidator id="rfvddlCategory" runat="server" errormessage="Category is required"
                                                             Font-Bold="true" Font-Size="10" ControlToValidate="ddlCategory" Display="Dynamic" ForeColor="Red"
                                                             SetFocusOnError="True" initialvalue="0"></asp:requiredfieldvalidator>
                                                        <asp:sqldatasource id="sqlCategory" runat="server" ConnectionString="<%$ ConnectionStrings:cn %>" 
                                                            SelectCommand="SELECT [CategoryId], [Name] FROM [tbl_Categories]"></asp:sqldatasource>
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
                                                    <asp:image id="imgProduct" runat="server" cssclass="img-thumbnail" Visible="false" />
                                                </div>

                                            </div>
                                        </div>

                                        <div class="col-sm-6 col-md-8 co1-lg-8 mobile-inputs">
                                            <h4 class="sub-title">Category Lists</h4>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">

                                                    <asp:Repeater id="rptrProduct" runat="server" OnItemCommand="rptrProduct_ItemCommand" OnItemDataBound="rptrProduct_ItemDataBound">
                                                        <HeaderTemplate>
                                                            <table class="table data-table-export table-hover nowrap">
                                                                <thead>
                                                                    <tr>
                                                                        <th class="table-plus">Name</th>
                                                                        <th>Image</th>
                                                                        <th>Price(₹)</th>
                                                                        <th>Quantity</th>
                                                                        <th>Category</th>
                                                                        <th>IsActive</th>
                                                                        <th>Description</th>
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
                                                                    <img alt="" width="40" height="50" src="<%# Utils.GetImageUrl(Eval("ImageUrl")) %>" />
                                                                </td>
                                                                <td><%# Eval("Price") %></td>
                                                                <td>
                                                                    <asp:Label ID="lblQuantity" runat="server" Text='<%# Eval("Quantity") %>'></asp:Label>
                                                                </td>
                                                                <td><%# Eval("CategoryName") %></td>
                                                                <td>
                                                                    <asp:Label ID="lblIsActive" runat="server" Text='<%# Eval("IsActive") %>'></asp:Label>
                                                                </td>
                                                                <td><%# Eval("Description") %></td>
                                                                <td><%# Eval("CreationDate") %></td>
                                                                <td>
                                                                    <asp:LinkButton ID="lnkEdit" Text="Edit" runat="server" CssClass="badge badge-primary"
                                                                        CausesValidation="false" CommandArgument='<%# Eval("ProductId") %>' CommandName="edit">
                                                                            <i class="ti-pencil"></i>
                                                                    </asp:LinkButton>
                                                                    <asp:LinkButton ID="lnkDelete" Text="Delete" runat="server" CommandName="delete"
                                                                        CausesValidation="false" CssClass="badge bg-danger" CommandArgument='<%# Eval("ProductId") %>'
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