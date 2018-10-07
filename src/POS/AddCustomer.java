package POS;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class addInventory
 */
@WebServlet("/AddCustomer")
public class AddCustomer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddCustomer() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		response.setContentType("text/plain");
        String guestcount = request.getParameter("guestcount"); 
        String remarks = request.getParameter("remarks");
        String area_id = request.getParameter("area_id");
        
		Connection conn = DB.getConnection();
		
		Statement stmnt = null;
		try {
			stmnt = conn.createStatement();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		try {
			String sql = "insert into rms_customer(guest_count, details, area_id_f, time_in)"
					+ "values('"+guestcount+"','"+remarks+"', '"+area_id+"',CURRENT_TIMESTAMP)";
			
			stmnt.execute(sql);
			
			
			String sql2 = "UPDATE `rms_area` SET `Area_Status` = 'Unavailable', `reserved_at` = CURRENT_TIMESTAMP WHERE `rms_area`.`Area_Id` = " +area_id;
			
			stmnt.execute(sql2);
			
			PrintWriter out = response.getWriter();	
			out.print(sql);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		



	}

}
