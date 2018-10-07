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
@WebServlet("/GetDishes")
public class GetDishes extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetDishes() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
        String category_id = request.getParameter("category_id"); 
		
		try{
			Connection conn = DB.getConnection();
			String query = "select * from rms_dish_category rdc inner join rms_dishes rd on rd.category_id = rdc.category_id where rdc.category_id = '"+category_id+"' order by Dish_Name";			
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			
			if(rs.next() == false) {
				PrintWriter write = response.getWriter();
				write.print("<div class='fade in' style='text-align:center'>NO DATA</div>");
			} else {
				String view = "<div class='fade in' >" ;
			    do {
					view += "<div class='card col-md-3 simpleCart_shelfItem' style='min-height:380px'>";
						String img = rs.getString("dish_images");
						if( img == "" || img == null ) {
						    view += "<img src='images/ribrage-dishes/no_dish.jpg' class='img-responsive'>";							
						}
						else {							
						    view += "<img src='images/ribrage-dishes/"+rs.getString("dish_images")+"' class='img-responsive'>";
						}
						view += "<span class='item_id'>"+rs.getInt("dish_id")+"</span>";
					    view += "<h4 class='item_name'><b>"+rs.getString("dish_name")+"</b></h4>";
					    view += "<h5 class='item_price'>Price: "+rs.getInt("dish_price")+"</h5>";
					    view += "<h6>"+rs.getString("dish_desc")+"</h6>";
					    view += "<p><a href='javascript:;' class='btn btn-primary item_add'>Add to Order</a></p>";
				    view += "</div>";
			    } while (rs.next());
			    view += "</div>";
			    
			    PrintWriter write = response.getWriter();
				write.print(view);
			}
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch blockPrintWriter write = response.getWriter();
			PrintWriter write = response.getWriter();
			write.print("<div class='fade in' style='text-align:center'>NO DATA</div>");
			e.printStackTrace();
		}
		
		//response.getWriter().append("Served at: ");
	}

	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


	}

}

