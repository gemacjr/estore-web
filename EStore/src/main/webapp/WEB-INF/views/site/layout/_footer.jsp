<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!-- Footer-->
<footer class="footer bg-dark pt-5">
    <div class="container">
        <div class="row pb-2">
            <div class="col-md-4 col-sm-6">
                <div class="widget widget-links widget-light pb-2 mb-4">
                    <h3 class="widget-title text-light"><spring:message code="ft.widget.title"/></h3>
                    <ul class="widget-list">
                        <li class="widget-list-item"><a class="widget-list-link" href="#"><spring:message code="ft.widget.item1"/></a></li>
                        <li class="widget-list-item"><a class="widget-list-link" href="#"><spring:message code="ft.widget.item2"/></a></li>
                        <li class="widget-list-item"><a class="widget-list-link" href="#"><spring:message code="ft.widget.item3"/></a></li>
                        <li class="widget-list-item"><a class="widget-list-link" href="#"><spring:message code="ft.widget.item4"/></a></li>
                        <li class="widget-list-item"><a class="widget-list-link" href="#"><spring:message code="ft.widget.item5"/></a></li>
                        <li class="widget-list-item"><a class="widget-list-link" href="#"><spring:message code="ft.widget.item6"/></a></li>
                    </ul>
                </div>
            </div>
            <div class="col-lg-4 col-md-3 col-sm-6">
                <div class="widget widget-links widget-light pb-2 mb-4">
                    <h3 class="widget-title text-light"><spring:message code="ft.widget2.title"/></h3>
                    <ul class="widget-list">
                        <li class="widget-list-item"><a class="widget-list-link" href="#"><spring:message code="ft.widget2.item1"/></a></li>
                        <li class="widget-list-item"><a class="widget-list-link" href="#"><spring:message code="ft.widget2.item2"/></a></li>
                        <li class="widget-list-item"><a class="widget-list-link" href="#"><spring:message code="ft.widget2.item3"/></a></li>
                        <li class="widget-list-item"><a class="widget-list-link" href="#"><spring:message code="ft.widget2.item4"/></a></li>
                    </ul>
                </div>
            </div>
            <div class="col-lg-4 col-md-5">
                <div class="widget pb-2 mb-4">
                    <h3 class="widget-title text-light pb-1"><spring:message code="ft.subscribe_title"/></h3>
                    <form class="subscription-form validate" action="https://studio.us12.list-manage.com/subscribe/post?u=c7103e2c981361a6639545bd5&amp;id=29ca296126"
                        name="mc-embedded-subscribe-form" method="POST" name="mc-embedded-subscribe-form" target="_blank" novalidate>
                        <div class="input-group flex-nowrap"><i
                                class="ci-mail position-absolute top-50 translate-middle-y text-muted fs-base ms-3"></i>
                            <input class="form-control rounded-start" type="email" name="EMAIL"
                                   placeholder="<spring:message code='global.your_email'/>" required>
                            <button class="btn btn-primary" type="submit" name="subscribe"><spring:message code="global.subscribe"/>*</button>
                        </div>
                        <!-- real people should not fill this in and expect good things - do not remove this or risk form bot signups-->
                        <div style="position: absolute; left: -5000px;" aria-hidden="true">
                            <input class="subscription-form-antispam" type="text"
                                name="b_c7103e2c981361a6639545bd5_29ca296126" tabindex="-1">
                        </div>
                        <div class="form-text text-light opacity-50"><spring:message code="ft.subscribe_info"/></div>
                        <div class="subscription-status"></div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</footer>
<!-- Toolbar for handheld devices (Default)-->
<div class="handheld-toolbar">
    <div class="d-table table-layout-fixed w-100">
        <!-- <a class="d-table-cell handheld-toolbar-item" href="account-wishlist.html">
            <span class="handheld-toolbar-icon"><i class="ci-heart"></i></span>
            <span class="handheld-toolbar-label">Wishlist</span>
        </a> -->
        <a class="d-table-cell handheld-toolbar-item" href="javascript:void(0)" data-bs-toggle="collapse"
            data-bs-target="#navbarCollapse" onclick="window.scrollTo(0, 0)">
            <span class="handheld-toolbar-icon">
                <i class="ci-menu"></i>
            </span>
            <span class="handheld-toolbar-label">Menu</span></a>
        <a class="d-table-cell handheld-toolbar-item" href="shop-cart.html">
            <span class="handheld-toolbar-icon">
                <i class="ci-cart"></i>
                <span class="badge bg-primary rounded-pill ms-1">4</span>
            </span>
            <span class="handheld-toolbar-label">$265.00</span>
        </a>
    </div>
</div>
<!-- Back To Top Button-->
<a class="btn-scroll-top" href="#top" data-scroll>
    <span class="btn-scroll-top-tooltip text-muted fs-sm me-2">Top</span>
    <i class="btn-scroll-top-icon ci-arrow-up"></i>
</a>