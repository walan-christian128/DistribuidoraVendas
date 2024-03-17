package Controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import DAO.ClientesDAO;
import DAO.ProdutosDAO;
import DAO.VendasDAO;
import Model.Clientes;
import Model.Produtos;
import Model.Vendas;

/**
 * Servlet implementation class vendasServer
 */
@WebServlet(urlPatterns = { "/selecionarClienteProdutos" ,"/inserirItens"})
public class vendasServer extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Vendas obj = new Vendas();
	VendasDAO dao = new VendasDAO();
	double total, preco, subtotal, preco_de_compra, preco_de_venda;
    double lucro, desconto;
    int qtd;
    List<String> linhasTabela = new ArrayList<>();
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public vendasServer() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		String action = request.getServletPath();
		System.out.println(action);
		if (action.equals("/selecionarClienteProdutos")) {
			selecionarClienteProd(request, response);

		} else if(action.equals("/inserirItens")) {
			  inserirItens(request, response);
			
		}

		else {

		}

	}

	private void inserirItens(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  // Função para limpar o carrinho
        HttpSession session = request.getSession();
        session.removeAttribute("carrinho");
        
        // Obter os valores dos campos de entrada
        String idProd = request.getParameter("idProd");
        String desProd = request.getParameter("desProd");
        int qtdProd = Integer.parseInt(request.getParameter("qtdProd"));
        double precoProd = Double.parseDouble(request.getParameter("precoProd"));
        double compraProd = Double.parseDouble(request.getParameter("compraProd"));
        
        // Calcular o subtotal
        double subtotal = qtdProd * precoProd;
        
        // Atualizar o total da venda
        double total = (Double) session.getAttribute("total");
        total += subtotal;
        session.setAttribute("total", total);
        
        // Calcular o lucro
        double itemLucro = (precoProd - compraProd) * qtdProd;
        double lucro = (Double) session.getAttribute("lucro");
        lucro += itemLucro;
        session.setAttribute("lucro", lucro);
        
        // Adicionar os valores à lista de itens do carrinho
        StringBuilder carrinho = (StringBuilder) session.getAttribute("carrinho");
        if (carrinho == null) {
            carrinho = new StringBuilder();
        }
        carrinho.append("<tr><td>").append(idProd).append("</td><td>").append(desProd).append("</td><td>").append(qtdProd).append("</td><td>").append(precoProd).append("</td><td>").append(subtotal).append("</td></tr>");
        request.setAttribute("linhasTabela", carrinho.toString());   
        session.setAttribute("carrinho", carrinho.toString());
        
        
        // Redirecionar para a página realizarVendas.jsp
        response.sendRedirect("realizarVendas.jsp");
        
        System.out.println(idProd);
        System.out.println(desProd);
        System.out.println(qtdProd);
        System.out.println(precoProd);
        System.out.println(total);
        System.out.println(subtotal);
        System.out.println(lucro);
    }
	


	

	private void selecionarClienteProd(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String cpfCli = request.getParameter("cliCpf");
		String idProdStr =  request.getParameter("idProd");
		int idProd = Integer.parseInt(idProdStr);
		
		Produtos prod = new Produtos();
		ProdutosDAO  prodDAO = new ProdutosDAO();
		Clientes cli = new Clientes();
		ClientesDAO cliDAO = new ClientesDAO();
		
		
		
		

		try {
		    cli = cliDAO.consultarClientesPorcpf(cpfCli);
			request.setAttribute("cliId", cli.getId());
			request.setAttribute("cliNome", cli.getNome());
			request.setAttribute("cliCpf", cli.getCpf());
			request.setAttribute("cliEndereco", cli.getEndereco());
			request.setAttribute("cliNumero", cli.getNumero());
			prod = prodDAO.consultarPorCodigo(idProd);
			request.setAttribute("idProd", prod.getId());
			request.setAttribute("desProd", prod.getDescricao());
			request.setAttribute("compraProd", prod.getPreco_de_compra());
			request.setAttribute("precoProd", prod.getPreco_de_venda());
			
			RequestDispatcher rd = request.getRequestDispatcher("realizarVendas.jsp");
			rd.forward(request, response);

		} catch (Exception e) {
			 
		}
		   
	}

	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		doGet(request, response);
	}
	

}
