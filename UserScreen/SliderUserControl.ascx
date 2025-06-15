<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SliderUserControl.ascx.cs" Inherits="UserScreen_SliderUserControl" %>

<!-- slider section -->
<section class="slider_section ">
    <div id="customCarousel1" class="carousel slide" data-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <div class="container ">
                    <div class="row">
                        <div class="col-md-7 col-lg-6 ">
                            <div class="detail-box">
                                <h1>🍽️ Endless Choices</h1>
                                <p>
                                    From local favorites to gourmet delights, Cravify offers a wide range of dishes to satisfy every craving. Explore diverse cuisines, customize your meals, and enjoy top-quality food from trusted restaurants—all in just a few taps!                                </p>
                                <div class="btn-box">
                                    <a href="Menu.aspx" class="btn1">Order Now</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="carousel-item ">
                <div class="container ">
                    <div class="row">
                        <div class="col-md-7 col-lg-6 ">
                            <div class="detail-box">
                                <h1>🚀 Fast & Fresh</h1>
                                <p>
                                    No more waiting! Cravify ensures quick deliveries while keeping your food fresh and delicious. Whether it's breakfast, lunch, or a midnight snack, we bring your orders straight to your doorstep—hot, tasty, and right on time.
                   
                                </p>
                                <div class="btn-box">
                                    <a href="Menu.aspx" class="btn1">Order Now</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="container ">
                    <div class="row">
                        <div class="col-md-7 col-lg-6 ">
                            <div class="detail-box">
                                <h1>❤️ Seamless Experience</h1>
                                <p>
                                    Ordering food has never been easier! With a user-friendly interface, real-time tracking, and secure payments, Cravify makes your food journey smooth and hassle-free. Enjoy a seamless ordering experience designed for true food lovers!
                                </p>
                                <div class="btn-box">
                                    <a href="Menu.aspx" class="btn1">Order Now</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <ol class="carousel-indicators">
                <li data-target="#customCarousel1" data-slide-to="0" class="active"></li>
                <li data-target="#customCarousel1" data-slide-to="1"></li>
                <li data-target="#customCarousel1" data-slide-to="2"></li>
            </ol>
        </div>
    </div>
</section>
<!-- end slider section -->

<script>
    $(document).ready(function () {
        $('#customCarousel1').carousel({
            interval: 5000 // Adjust the interval as needed
        });
    });
</script>
