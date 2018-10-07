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
@WebServlet("/GetOrderData")
public class GetOrderData extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetOrderData() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
        String area_id = request.getParameter("area_id"); 
		String query = "SELECT * from rms_orders `order` inner join rms_order_items `items` on `order`.order_id = `items`.order_id where status= 'Unpaid' and `order`.area_id = " + area_id;			
		
		
	    
		try{
			Connection conn = DB.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			
			if(rs.next() == false) {
				PrintWriter write = response.getWriter();
				write.print("<div class='fade in' style='text-align:center'>NO DATA</div>");
			} else {
				
				Double grandTotal=0.00;// = rs.getDouble("total_cost");
				
				String view = "";
				
				do {
					grandTotal += rs.getDouble("total_cost");
	                view += "<tr>";
	                view +=	"<td class=''>"+rs.getString("dish_name")+"</td>";
	                view += "<td class='' style='text-align:right'>"+rs.getString("quantity")+"</td>";
	                view += "<td class='' style='text-align:right'>Php "+ String.format("%.0f", rs.getDouble("total_cost")) +"</td>";
	                view += "</tr>";
			    }while (rs.next());

			    view += "<tr>";
			    		view += "<td class='text-right' colspan='2'>";
			    		view += "<p><strong></strong></p>";
			    		view += "<p><strong>Sub Total: </strong></p>";
			    		view += "</td>";
							
			    view += "<td>";
			    	view += "<p><strong></strong><p>";
			    	view += "<p><strong>Php "+String.format("%.0f", grandTotal)+"</strong><p>";
			    	view += "</td>";
			    view += "</tr>";
			    view += "<tr>";
			    	view += "<td class='text-right' colspan='2'><h2><strong>Grand Total: </strong></h2></td>";
			    	view += "<td class='text-left text-danger'><h2><strong>Php <span id='grandTotal'> "+String.format("%.0f", grandTotal)+" </span></strong></h2></td>";
	            view += "</tr>";
	            

	            
	            String sql4 = "update `rms_customer` set `total_pay` = '"+grandTotal+"' where area_id_f = '"+area_id+"' ";
					stmt.execute(sql4);

	            
			    PrintWriter write = response.getWriter();
				write.print(view);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch blockPrintWriter write = response.getWriter();
			PrintWriter write = response.getWriter();
			write.print("<tr><td colspan='3' style='text-align:center'>NO DATA</td></tr>");

			e.printStackTrace();
		}
		

	}

	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


	}

}

