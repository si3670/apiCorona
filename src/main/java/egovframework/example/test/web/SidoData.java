package egovframework.example.test.web;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.json.simple.JSONObject;

@WebServlet("/SidoData.do")
public class SidoData extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public SidoData() {
		super();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		

		String addr = "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson?serviceKey="; //uri
		String serviceKey = "BKk%2B0sack1Bq9UNR1WeJK8IVAiu6yw4KtwaMG5jUcHalBqqQw5X91m%2FCaAXadKZDfJQlRCopa7%2FXhjrvm6qWhQ%3D%3D";
		String parameter = "";
		PrintWriter out = response.getWriter();
		parameter = parameter + "&" + "pageNo=1";
		parameter = parameter + "&" + "numOfRows=10";
		parameter = parameter + "&" + "startCreateDt=20210812";
		parameter = parameter + "&" + "endCreateDt=20210812";
		parameter = parameter + "&" + "_type=json";
		
		addr = addr + serviceKey + parameter;
		URL url = new URL(addr);
		
		System.out.println(addr);
		
		InputStream in = url.openStream();
		ByteArrayOutputStream bos1 = new ByteArrayOutputStream();
		IOUtils.copy(in, bos1);
		in.close();
		bos1.close();
		
		String mbos = bos1.toString("UTF-8");
		System.out.println("mbos: "+mbos);
	    
		byte[] b = mbos.getBytes("UTF-8");
		String s = new String(b, "UTF-8");
		out.println(s);
		
		JSONObject json = new JSONObject();
		json.put("data", s);
//		json.put("data", data);
		System.out.println("json: "+json);
	}
	
}
