package POS;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
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
@WebServlet("/Timeout")
public class Timeout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Timeout() {
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
       
        String area_id = request.getParameter("area_id");
        String payment = request.getParameter("payment");
        String loose_change = request.getParameter("loose_change");
        
		Connection conn = DB.getConnection();
		
		Statement stmnt = null;
		try {
			stmnt = conn.createStatement();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		try {
			
			String updateArea = "UPDATE `rms_area` SET `Area_Status` = 'Available', `reserved_at` = NULL WHERE `rms_area`.`Area_Id` = " +area_id;
			
			stmnt.execute(updateArea);
			
			String updateCustomer = "update `rms_customer` set `time_out` = CURRENT_TIMESTAMP where Area_Id_f = '"+area_id+"' ORDER BY time_in desc limit 1";
			stmnt.execute(updateCustomer);
			
			String sqlPayment = "insert into rms_order_payments (area_id, payment, loose_change) values('"+area_id+"','"+payment+"','"+loose_change+"')";
			stmnt.execute(sqlPayment);

			ResultSet rs = stmnt.executeQuery("select id from rms_order_payments order by created_at desc limit 1");
			rs.next();
			String payment_id = rs.getString("id");

			
			String updateOrder = "update `rms_orders` set `paid_at` = CURRENT_TIMESTAMP, `status`='Paid', `payment_id` = '"+payment_id+"' where status='Unpaid' and area_id = '"+area_id+"' ";
			stmnt.execute(updateOrder);
					
			PrintWriter out = response.getWriter();	
			out.print(payment_id);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		



	}

}
