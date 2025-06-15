<%@ Page Title="Cravify" Language="C#" MasterPageFile="~/UserScreen/User.master" AutoEventWireup="true" CodeFile="UserHome.aspx.cs" Inherits="UserHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <!-- offer section -->

    <section class="offer_section layout_padding-bottom">
        <div class="offer_container">
            <div class="container ">
                <div class="row">
                    <asp:Repeater ID="rCategory" runat="server">
                        <ItemTemplate>

                            <div class="col-md-6  ">
                                <div class="box ">
                                    <div class="img-box">
                                        <a href="Menu.aspx?id=<%# Eval("CategoryId") %>">

                                            <img src="<%# Utils.GetImageUrl(Eval("ImageUrl"))  %>" alt="">
                                        </a>
                                    </div>
                                    <div class="detail-box">
                                        <h5><%# Eval("Name") %></h5>
                                        <h6><span>20%</span> Off</h6>

                                        <a href='Menu.aspx?id=<%# Eval("CategoryId") %>'>Order Now 
                   
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

                                        </a>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </section>

    <!-- end offer section -->

    <!-- about section -->

    <section class="about_section layout_padding">
        <div class="container  ">

            <div class="row">
                <div class="col-md-6 ">
                    <div class="img-box">
                        <img src="../Templates/images/about-img.png" alt="">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="detail-box">
                        <div class="heading_container">
                            <h2>We Are Cravify</h2>
                        </div>
                        <p>
                         – where cravings meet convenience! From local favorites to exotic delights, we bring a world of flavors straight to your door. Our seamless ordering process ensures a hassle-free experience, so you can focus on what truly matters – enjoying great food. With Cravify, every meal is a moment to savor!
                        </p>
                        <a href="">Read More
            </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- end about section -->

    <!-- client section -->

    <section class="client_section layout_padding-bottom pt-5">
        <div class="container">
            <div class="heading_container heading_center psudo_white_primary mb_45">
                <h2>What Our Customers Say
        </h2>
            </div>
            <%--            <div class="carousel-wrap row ">
                <div class="owl-carousel client_owl-carousel owl-loaded owl-drag">

                    <div class="owl-stage-outer">
                        <div class="owl-stage" style="transform: translate3d(-1755px, 0px, 0px); transition: transform 0.5s ease-in-out; width: 3510px;">
                            <div class="owl-item cloned" style="width: 585px;">
                                <div class="item">
                                    <div class="box">
                                        <div class="detail-box">
                                            <p>
                                                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam
               
                                            </p>
                                            <h6>Moana Michell
                </h6>
                                            <p>
                                                magna aliqua
               
                                            </p>
                                        </div>
                                        <div class="img-box">
                                            <img src="../Templates/images/client1.jpg" alt="" class="box-img">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="owl-item cloned" style="width: 585px;">
                                <div class="item">
                                    <div class="box">
                                        <div class="detail-box">
                                            <p>
                                                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam
               
                                            </p>
                                            <h6>Mike Hamell
                </h6>
                                            <p>
                                                magna aliqua
               
                                            </p>
                                        </div>
                                        <div class="img-box">
                                            <img src="../Templates/images/client2.jpg" alt="" class="box-img">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="owl-item" style="width: 585px;">
                                <div class="item">
                                    <div class="box">
                                        <div class="detail-box">
                                            <p>
                                                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam
               
                                            </p>
                                            <h6>Moana Michell
                </h6>
                                            <p>
                                                magna aliqua
               
                                            </p>
                                        </div>
                                        <div class="img-box">
                                            <img src="../Templates/images/client1.jpg" alt="" class="box-img">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="owl-item active" style="width: 585px;">
                                <div class="item">
                                    <div class="box">
                                        <div class="detail-box">
                                            <p>
                                                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam
               
                                            </p>
                                            <h6>Mike Hamell
                </h6>
                                            <p>
                                                magna aliqua
               
                                            </p>
                                        </div>
                                        <div class="img-box">
                                            <img src="../Templates/images/client2.jpg" alt="" class="box-img">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="owl-item cloned active" style="width: 585px;">
                                <div class="item">
                                    <div class="box">
                                        <div class="detail-box">
                                            <p>
                                                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam
               
                                            </p>
                                            <h6>Moana Michell
                </h6>
                                            <p>
                                                magna aliqua
               
                                            </p>
                                        </div>
                                        <div class="img-box">
                                            <img src="../Templates/images/client1.jpg" alt="" class="box-img">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="owl-item cloned" style="width: 585px;">
                                <div class="item">
                                    <div class="box">
                                        <div class="detail-box">
                                            <p>
                                                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam
               
                                            </p>
                                            <h6>Mike Hamell
                </h6>
                                            <p>
                                                magna aliqua
               
                                            </p>
                                        </div>
                                        <div class="img-box">
                                            <img src="../Templates/images/client2.jpg" alt="" class="box-img">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="owl-nav disabled">
                        <button type="button" role="presentation" class="owl-prev"><i class="fa fa-angle-left" aria-hidden="true"></i></button>
                        <button type="button" role="presentation" class="owl-next"><i class="fa fa-angle-right" aria-hidden="true"></i></button>
                    </div>
                    <div class="owl-dots disabled"></div>
                </div>
            </div>--%>

            <div class="carousel-wrap row" style="position: relative; margin: 0 auto;">
                <div class="owl-carousel client_owl-carousel" style="width: 100%; overflow: hidden;">
                    <div class="item" style="padding: 15px;">
                        <div class="box" style="display: flex; align-items: center; background: #f8f8f8; border-radius: 8px; padding: 20px;">
                            <div class="detail-box" style="flex: 1; padding-right: 20px;">
                                <p>
                                    "Cravify made ordering food so convenient! The variety of options is amazing, and the delivery was super quick. Highly recommended!"                                </p>
                                <h6>Moana Michell</h6>
                                <p>Food Enthusiast</p>
                            </div>
                            <div class="img-box">
                                <img src="https://images.pexels.com/photos/736716/pexels-photo-736716.jpeg?cs=srgb&dl=sea-fashion-man-736716.jpg&fm=jpg" alt="Moana Michell" style="width: 100px; height: 100px; border-radius: 50%; object-fit: cover;">
                            </div>
                        </div>
                    </div>
                    <div class="item" style="padding: 15px;">
                        <div class="box" style="display: flex; align-items: center; background: #f8f8f8; border-radius: 8px; padding: 20px;">
                            <div class="detail-box" style="flex: 1; padding-right: 20px;">
                                <p>
                                    "I love how Cravify keeps me updated with real-time tracking. The food always arrives hot and fresh. Five stars!"                                </p>
                                <h6>Mike Hamell</h6>
                                <p>Regular Customer</p>
                            </div>
                            <div class="img-box">
                                <img src="https://mdclegal.com.au/wp-content/uploads/2016/02/mdc_man_pic.png" alt="Mike Hamell" style="width: 100px; height: 100px; border-radius: 50%; object-fit: cover;">
                            </div>
                        </div>
                    </div>
                    <div class="item" style="padding: 15px;">
                        <div class="box" style="display: flex; align-items: center; background: #f8f8f8; border-radius: 8px; padding: 20px;">
                            <div class="detail-box" style="flex: 1; padding-right: 20px;">
                                <p>
                                    "The user-friendly interface and multiple payment options make Cravify my go-to food ordering app. Great service every time!"                                </p>
                                <h6>Sarah Johnson</h6>
                                <p>Satisfied User</p>
                            </div>
                            <div class="img-box">
                                <img src="https://theconductsoflife.com/wp-content/uploads/2024/01/Dressing-etiquette-for-ladies.jpg" alt="Sarah Johnson" style="width: 100px; height: 100px; border-radius: 50%; object-fit: cover;">
                            </div>
                        </div>
                    </div>
                    <div class="item" style="padding: 15px;">
                        <div class="box" style="display: flex; align-items: center; background: #f8f8f8; border-radius: 8px; padding: 20px;">
                            <div class="detail-box" style="flex: 1; padding-right: 20px;">
                                <p>
                                    "Cravify brings all my favorite restaurants to my doorstep. The seamless ordering experience makes it a must-have for food lovers!"                                </p>
                                <h6>Liam Carter</h6>
                                <p>Food Blogger</p>
                            </div>
                            <div class="img-box">
                                <img src="https://1.bp.blogspot.com/-rH9ibyhCVoQ/UNKzT36xWDI/AAAAAAAAASY/oXAzWWb5WWw/s1600/cute+boys+wallpapers+(1).jpg" alt="Liam Carter" style="width: 100px; height: 100px; border-radius: 50%; object-fit: cover;">
                            </div>
                        </div>
                    </div>

                    <div class="owl-nav">
                        <button type="button" class="owl-prev" style="position: absolute; top: 50%; transform: translateY(-50%); background: #fff; border: none; padding: 10px; cursor: pointer; left: -30px;">
                            <i class="fa fa-angle-left" aria-hidden="true"></i>
                        </button>
                        <button type="button" class="owl-next" style="position: absolute; top: 50%; transform: translateY(-50%); background: #fff; border: none; padding: 10px; cursor: pointer; right: -30px;">
                            <i class="fa fa-angle-right" aria-hidden="true"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- end client section -->
    <script>

        $(document).ready(function () {
            $('.client_owl-carousel').owlCarousel({
                loop: true,
                margin: 00,
                nav: true,
                dots: false,
                autoplay: true,           // Added: Enables automatic sliding
                autoplayTimeout: 2000,    // Added: Sets interval to 1 second (1000ms)
                autoplayHoverPause: true, // Added: Pauses on hover
                smartSpeed: 1000,          // Added: Smoothens transition speed (in ms)
                //center: true,
                responsive: {
                    0: {
                        items: 1,
                    },
                    768: {
                        items: 2,
                    }
                }
            });
        });
    </script>
</asp:Content>
