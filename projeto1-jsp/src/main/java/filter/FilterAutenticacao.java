package filter;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import connection.SingleConnectionBanco;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@WebFilter(urlPatterns = { "/principal/*" }) /* Intercepta as requisições */
public class FilterAutenticacao implements Filter {

	private static Connection connection;

	public FilterAutenticacao() {

	}

	/* Encerra os processos quando o servidor é parado, banco, conexões, etc.. */
	public void destroy() {
		try {
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/*
	 * Intercepta as requisições e dá as respostas do sistema. Tudo passa aqui:
	 * autenticação, commit e rolback no banco, redirecionamentos
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		try {
			HttpServletRequest req = (HttpServletRequest) request;
			HttpSession session = req.getSession();

			String usuarioLogado = (String) session.getAttribute("usuario");
			String urlParaAutenticar = req.getServletPath(); // Url que está sendo acessada

			// Validar se está logado senão redireciona para a tela de login
			if (usuarioLogado == null || (usuarioLogado != null && usuarioLogado.isEmpty())
					&& !urlParaAutenticar.equalsIgnoreCase("/principal/ServletLogin")) {// Não está logado

				RequestDispatcher redireciona = request.getRequestDispatcher("/index.jsp?url=" + urlParaAutenticar);
				request.setAttribute("msq", "Por favor realize o login!");
				redireciona.forward(request, response);
				return;// Para a execução e redireciona para o login
			} else {
				chain.doFilter(request, response);// chain do Filter deixa o processo do software continuar
			}
			connection.commit();

		} catch (Exception e) {
			e.printStackTrace();
			try {
				connection.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
	}

	/*
	 * Inicia os processos ou recursos quando starta o projeto, banco, api externa,
	 * etc..
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		connection = SingleConnectionBanco.getConnection();
	}
}
