<%@ Page Title="Menu" Language="C#" MasterPageFile="~/UserScreen/User.master" AutoEventWireup="true" CodeFile="Menu.aspx.cs" Inherits="UserScreen_Menu" %>

<%--<%@ Import Namespace ="Foodie" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>
        $(window).on('load', function () {
            $('.filters_menu li').click(function () {
                $('.filters_menu li').removeClass('active');
                $(this).addClass('active');

                var data = $(this).attr('data-filter');
                $grid.isotope({
                    filter: data
                })
            });

            var $grid = $(".grid").isotope({
                itemSelector: ".all",
                percentPosition: false,
                masonry: {
                    columnWidth: ".all"
                }
            })

            $(document).ready(function () {
                function getUrlVars() {
                    var vars = [], hash;
                    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
                    for (var i = 0; i < hashes.length; i++) {
                        hash = hashes[i].split('=');
                        vars.push(hash[0]);
                        vars[hash[0]] = hash[1];
                    }
                    return vars;
                }
                var id = getUrlVars()["id"];
                if (id > 0) {
                    $('.filters_menu li').removeClass('active');
                }
                $('.filters_menu li').each(function () {
                    if (id == this.attributes["data-id"].value) {
                        $(this).closest("li").addClass("active");
                        var data = $(this).attr('data-filter');
                        $grid.isotope({
                            filter: data
                        })
                        return;
                    }
                });
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <!-- food section -->

    <section class="food_section layout_padding">
        <div class="container">
            <div class="heading_container heading_center">
                <%-- <div class="align-self-end">
                    <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
                </div>--%>



                <h2>Our Menu
                </h2>
            </div>

            <ul class="filters_menu">
                <li class="active" data-filter="*" data-id="0">All</li>
                <asp:repeater id="rCategory" runat="server">
                    <ItemTemplate>
                        <li data-filter=".<%# Regex.Replace( Eval("Name").ToString().ToLower() ,@"\s+","")%>"
                            data-id="<%# Eval("CategoryId") %>">
                            <%# Eval("Name") %>
                        </li>
                    </ItemTemplate>
                </asp:repeater>

            </ul>

            <div class="filters-content">
                <div class="row grid">

                    <asp:repeater id="rProducts" runat="server" onitemcommand="rProducts_ItemCommand">
                        <ItemTemplate>

                            <div class="col-sm-6 col-lg-4 all <%# Regex.Replace( Eval("CategoryName").ToString().ToLower() ,@"\s+","") %>">
                                <div class="box">
                                    <div>
                                        <div class="img-box">
                                            <img src="<%# Utils.GetImageUrl(Eval("ImageUrl"))  %>" alt="">
                                        </div>
                                        <div class="detail-box">
                                            <h5><%# Eval("Name") %></h5>
                                            <p><%# Eval("Description") %></p>
                                            <div class="options">
                                                <h6>₹<%# Eval("Price") %></h6>
                                                <asp:LinkButton runat="server" ID="lbAddToCart" CommandName="addToCart" CommandArgument='<%# Eval("ProductId") %>'>
                                                    <svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 456.029 456.029" style="enable-background: new 0 0 456.029 456.029;" xml:space="preserve">
                                                        <g>
                                                            <g>
                                                                <path d="M345.6,338.862c-29.184,0-53.248,23.552-53.248,53.248c0,29.184,23.552,53.248,53.248,53.248
                         c29.184,0,53.248-23.552,53.248-53.248C398.336,362.926,374.784,338.862,345.6,338.862z" />
                                                            </g>
                                                        </g>
                                                        <g>
                                                            <g>
                                                                <path d="M439.296,84.91c-1.024,0-2.56-0.512-4.096-0.512H112.64l-5.12-34.304C104.448,27.566,84.992,10.67,61.952,10.67H20.48
                         C9.216,10.67,0,19.886,0,31.15c0,11.264,9.216,20.48,20.48,20.48h41.472c2.56,0,4.608,2.048,5.12,4.608l31.744,216.064
                         c4.096,27.136,27.648,47.616,55.296,47.616h212.992c26.624,0,49.664-18.944,55.296-45.056l33.28-166.4
                         C457.728,97.71,450.56,86.958,439.296,84.91z" />
                                                            </g>
                                                        </g>
                                                        <g>
                                                            <g>
                                                                <path d="M215.04,389.55c-1.024-28.16-24.576-50.688-52.736-50.688c-29.696,1.536-52.224,26.112-51.2,55.296
                         c1.024,28.16,24.064,50.688,52.224,50.688h1.024C193.536,443.31,216.576,418.734,215.04,389.55z" />
                                                            </g>
                                                        </g>
                                                        <g>
                                                        </g>
                                                        <g>
                                                        </g>
                                                        <g>
                                                        </g>
                                                        <g>
                                                        </g>
                                                        <g>
                                                        </g>
                                                        <g>
                                                        </g>
                                                        <g>
                                                        </g>
                                                        <g>
                                                        </g>
                                                        <g>
                                                        </g>
                                                        <g>
                                                        </g>
                                                        <g>
                                                        </g>
                                                        <g>
                                                        </g>
                                                        <g>
                                                        </g>
                                                        <g>
                                                        </g>
                                                        <g>
                                                        </g>
                                                    </svg>
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </ItemTemplate>

                    </asp:repeater>


                </div>
            </div>
            <%--  <div class="btn-box">
                <a href="">View More
                </a>
            </div>--%>
        </div>
    </section>

    <!-- end food section -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.isotope/3.0.6/isotope.pkgd.min.js"></script>

    <script>
        $(document).ready(function () {
            var $grid = $('.grid').isotope({
                itemSelector: '.col-sm-6', // Ensure this class is applied to each item
                layoutMode: 'fitRows'
            });

            $('.filters_menu li').on('click', function () {
                $('.filters_menu li').removeClass('active');
                $(this).addClass('active');

                var filterValue = $(this).attr('data-filter');
                console.log("Filtering by:", filterValue); // Debugging

                $grid.isotope({ filter: filterValue });
            });
        });

        // Get category ID from URL
        var urlParams = new URLSearchParams(window.location.search);
        var categoryId = urlParams.get('id');

        if (categoryId) {
            console.log("Filtering for Category ID:", categoryId); // Debugging

            // Find the corresponding filter value
            var $selectedCategory = $('.filters_menu li[data-id="' + categoryId + '"]');

            if ($selectedCategory.length > 0) {
                $('.filters_menu li').removeClass('active');
                $selectedCategory.addClass('active');

                var filterValue = $selectedCategory.attr('data-filter');
                console.log("Applying filter:", filterValue); // Debugging

                $grid.isotope({ filter: filterValue });
            }
        }



    </script>
    <!-- Add this at the bottom of your ASPX page, before the closing </body> tag -->
    <div id="notification-container" style="position: fixed; bottom: 20px; left: 50%; transform: translateX(-50%); z-index: 1000; display: none;">
        <asp:label id="lblMsg" runat="server" visible="false"
            style="padding: 10px 20px; border-radius: 5px; background-color: #28a745; color: white; box-shadow: 0 2px 10px rgba(0,0,0,0.2); animation: slideUp 0.5s ease-in-out; display: inline-block;"
            cssclass="notification-message"></asp:label>
    </div>

    <!-- Add this style block in the <head> section since animations can't be fully inlined -->
    <style>
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(100px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeOut {
            from {
                opacity: 1;
            }

            to {
                opacity: 0;
            }
        }

        .fade-out {
            animation: fadeOut 0.5s ease-in-out forwards;
        }
    </style>
</asp:Content>

