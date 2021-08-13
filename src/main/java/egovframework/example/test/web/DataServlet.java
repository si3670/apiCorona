package egovframework.example.test.web;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 * 전국현황 test
 * */

@WebServlet("/dataServlet")
public class DataServlet extends HttpServlet implements Servlet{
	private static final long serialVersionUID = 1L;

	public DataServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/xml;charset=UTF-8");

		BufferedReader br = null;
		try {
			String urlstr = "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson?serviceKey=" +  "BKk%2B0sack1Bq9UNR1WeJK8IVAiu6yw4KtwaMG5jUcHalBqqQw5X91m%2FCaAXadKZDfJQlRCopa7%2FXhjrvm6qWhQ%3D%3D" + "&pageNo=1&numOfRows=10&startCreateDt=20200310&endCreateDt=20200315";
			URL url = new URL(urlstr);
			HttpURLConnection urlconnection = (HttpURLConnection) url.openConnection();
			urlconnection.setRequestMethod("GET");
			br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream(), "UTF-8"));
			String result = "";
			String line;
			while ((line = br.readLine()) != null) {
				result = result + line + "\n";
			}
			response.getWriter().append(result);
		} catch (Exception e) {
			response.getWriter().append("<?xml version=\"1.0\" encoding=\"UTF-8\"?><response><header><resultCode>-999</resultCode><resultMsg>알 수 없는 오류</resultMsg></header></response>");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
