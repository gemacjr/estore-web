package com.eshop.utils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;

/**
 * Cung cấp các phương thức đọc/ghi attribute trong các scope
 */
@Service
public class ScopeUtils {
	@Autowired
	private HttpServletRequest request;

	/**
	 * Tạo attribute trong request scope
	 *
	 * @param name  tên attribute
	 * @param value giá trị của attribute
	 */
	public void setRequest(String name, Object value) {
		request.setAttribute(name, value);
	}

	/**
	 * Đọc attribute trong request scope
	 *
	 * @param name tên attribute
	 * @return Giá trị của attribute hoặc null nếu không tồn tại
	 */
	@SuppressWarnings("unchecked")
	public <T> T getRequest(String name) {
		return (T) request.getAttribute(name);
	}

	/**
	 * Xóa attribute trong request scope
	 *
	 * @param name tên attribute cần xóa
	 */
	public void removeRequest(String name) {
		request.removeAttribute(name);
	}

	/**
	 * Tạo attribute trong session scope
	 *
	 * @param name  tên attribute
	 * @param value giá trị của attribute
	 */
	public void setSession(String name, Object value) {
		request.getSession().setAttribute(name, value);
	}

	/**
	 * Đọc attribute trong session scope
	 *
	 * @param name tên attribute
	 * @return Giá trị của attribute hoặc null nếu không tồn tại
	 */
	@SuppressWarnings("unchecked")
	public <T> T getSession(String name) {
		return (T) request.getSession().getAttribute(name);
	}

	/**
	 * Xóa attribute trong session scope
	 *
	 * @param name tên attribute cần xóa
	 */
	public void removeSession(String name) {
		request.getSession().removeAttribute(name);
	}

	/**
	 * Tạo attribute trong application scope
	 *
	 * @param name  tên attribute
	 * @param value giá trị của attribute
	 */
	public void setApplication(String name, Object value) {
		request.getServletContext().setAttribute(name, value);
	}

	/**
	 * Đọc attribute trong application scope
	 *
	 * @param name tên attribute
	 * @return Giá trị của attribute hoặc null nếu không tồn tại
	 */
	@SuppressWarnings("unchecked")
	public <T> T getApplication(String name) {
		return (T) request.getServletContext().getAttribute(name);
	}

	/**
	 * Xóa attribute trong application scope
	 *
	 * @param name tên attribute cần xóa
	 */
	public void removeApplication(String name) {
		request.getServletContext().removeAttribute(name);
	}
}
