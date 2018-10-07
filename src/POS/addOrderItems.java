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
@WebServlet("/addOrderItems")
public class addOrderItems extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addOrderItems() {
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
		
        String dish_id = request.getParameter("dish_id"); 
        String dish_name = request.getParameter("dish_name");
        String dish_price = request.getParameter("dish_price");
        String dish_quantity= request.getParameter("dish_quantity");
        String dish_total_price = request.getParameter("dish_total_price");
        String order_id = request.getParameter("order_id");
        
        
		Connection conn = DB.getConnection();
		
		Statement stmnt = null;
		try {
			stmnt = conn.createStatement();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		try {
			
			String sql = "insert into rms_order_items(dish_id, dish_name, price, quantity, total_cost, order_id)"
					+ "values('"+dish_id+"','"+dish_name+"', '"+dish_price+"', '"+dish_quantity+"', '"+dish_total_price+"', '"+order_id+"')";
			
			stmnt.execute(sql);
			
			 

						
			PrintWriter out = response.getWriter();	
			out.print(sql);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		



	}

}
