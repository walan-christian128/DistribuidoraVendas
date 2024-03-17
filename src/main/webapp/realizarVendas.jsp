
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="Model.Clientes"%>
<%@ page import="Model.Produtos"%>
<%@ page import="DAO.ClientesDAO"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
Date dataAtual = new Date();
SimpleDateFormat formatoData = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss"); // Escolha o formato desejado
String dataAtualFormatada = formatoData.format(dataAtual);
%>
<%
Clientes clientes = new Clientes();
%>
<%
Produtos produtos = new Produtos();
%>
<html lang="pt-BR">
<head>
<title>Venda</title>
<link rel="icon"
	href="img/2992655_click_computer_currency_dollar_money_icon.png">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
</head>
<body class="bg-light">
	<%@ include file="menu.jsp"%>
	<main class="container d-flex h-auto d-inline-block">
		<div class="row col-md-9">
			<!-- Formulário de Cliente -->
			<form id="buscarClienteForm" class="row g-3 needs-validation"
				novalidate action="selecionarClienteProdutos" method="POST">
				<div id="Cliente">
					<div class="col-md-8">
						<h2>Cliente</h2>
						<div class="row">
							<div class="col-md-6">
								<label for="cliId" class="form-label">Codigo: </label> <input
									type="text" class="form-control" id="cliId" name="cliId"
									required
									value="<%=request.getAttribute("cliId") != null ? request.getAttribute("cliId").toString() : ""%>"
									readonly>
							</div>
							<div class="col-md-6">
								<label for="dataProd" class="form-label d-flex">Data: </label> <input
									type="text" class="form-control d-flex"
									value="<%=dataAtualFormatada%>" disabled name="data">
							</div>
						</div>
						<div>
							<label for="cliNome" class="form-label">Nome: </label> <input
								type="text" class="form-control" id="cliNome" name="cliNome"
								required
								value="<%=request.getAttribute("cliNome") != null ? request.getAttribute("cliNome").toString() : ""%>"
								readonly>
						</div>
						<div class="col-md-6">
							<label for="validationCustom01" class="form-label">CPF: </label>
							<input type="text" class="form-control" id="validationCustom01"
								name="cliCpf" required
								value="<%=request.getAttribute("cliCpf") != null ? request.getAttribute("cliCpf").toString() : ""%><%clientes.getCpf();%>">
						</div>
						<div class="col-md-6">
							<label for="cliEndereco" class="form-label">Endereço: </label> <input
								type="text" class="form-control" id="cliEndereco"
								name="cliEndereco" required
								value="<%=request.getAttribute("cliEndereco") != null ? request.getAttribute("cliEndereco").toString() : ""%>"
								readonly>
						</div>
						<div class="col-md-2">
							<label for="cliNumero" class="form-label">N°: </label> <input
								type="text" class="form-control" id="cliNumero" name="cliNumero"
								required
								value="<%=request.getAttribute("cliNumero") != null ? request.getAttribute("cliNumero").toString() : ""%>"
								readonly>
						</div>
						<div></div>
					</div>
				</div>
				<div id="Produtos">
					<div class="col-md-8">
						<h2>Produto</h2>
						<div class="col-md-6">
							<label for="validationCustom02" class="form-label">Codigo:
							</label> <input type="text" class="form-control" id="validationCustom02"
								name="idProd" required
								value="<%=request.getAttribute("idProd") != null ? request.getAttribute("idProd").toString() : ""%><%produtos.getId();%>">
						</div>
						<div>
							<label for="desProd" class="form-label">Descricão: </label> <input
								type="text" class="form-control" id="desProd" name="desProd"
								required
								value="<%=request.getAttribute("desProd") != null ? request.getAttribute("desProd").toString() : ""%>"
								readonly>
						</div>
						<div class="row">
							<div class="col-md-6">
								<label for="precoProd" class="form-label">Preço: </label> <input
									type="text" class="form-control" id="precoProd"
									name="precoProd" required
									value="<%=request.getAttribute("precoProd") != null ? request.getAttribute("precoProd").toString() : ""%>"
									readonly>
							</div>
							<div class="col-md-6">
								<label for="qtdProd" class="form-label">QTD: </label> <input
									type="number" class="form-control" id="qtdProd" name="qtdProd"
									required
									value="<%=request.getAttribute("qtdProd") != null ? request.getAttribute("qtdProd").toString() : ""%>">
							</div>
						</div>
						<div class="col-md-6">
							<label for="compraProd" class="form-label">Meu Preço:</label> <input
								type="text" class="form-control" id="compraProd"
								name="compraProd" required
								value="<%=request.getAttribute("compraProd") != null ? request.getAttribute("compraProd").toString() : ""%>"
								readonly>
						</div>
						<div class="d-flex justify-content-between">
							<input class="btn btn-primary mt-3" type="submit"
								value="Pesquisar">
							<button type="submit" class="btn btn-danger mt-3"
								id="adicionarItemBtn">Adicionar item</button>
						</div>
						<div class="d-flex col-md-6"></div>
					</div>
				</div>

			</form>

		</div>
		<div class="row col-md-5">

			<div class="p-3  bg-light">
				<form action="inserirItens" id="carrihodecompra" method="POST">


					<h2 class="d-flex justify-content-center">Itens Da Venda</h2>
					<div>
						<table class="table table-dark table-hover" id="carrinho">
							<thead>
								<tr>
									<th>Codigo</th>
									<th>Produto</th>
									<th>Quantidade</th>
									<th>Preço</th>
									<th>Subtotal</th>
								</tr>
							</thead>
							 <tbody>
        <% 
        @SuppressWarnings("unchecked")
        List<String> linhasTabela = (List<String>) request.getAttribute("linhasTabela");
        if (linhasTabela != null) {
            for (String linha : linhasTabela) {
                out.println(linha);
            }
        }
        %>
    </tbody>
						</table>

					</div>
					<input type="hidden" name="qtdProd" value="valorDaQuantidade">
					<input type="hidden" name="compraProd" value="valorDaCompra">
					<input type="hidden" name="precoProd" value="valorDoPreco">
					<input type="hidden" name="desconto" value="valorDoDesconto">
				</form>

			</div>
			<div class=" col-md-3">
				<label class="form-label">Total Venda:</label> <input type="text"
					class="form-control" name="total" value="">
			</div>
			<div class=" col-md-3">
				<label class="form-label">lucro:</label> <input type="text"
					class="form-control" name="lucro">
			</div>
			<div class=" col-md-3">
				<label class="form-label">Desconto:</label> <input type="text"
					class="form-control" name="desconto">
			</div>
		</div>
	</main>
	<!-- Bootstrap JavaScript Bundle com Popper -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
		crossorigin="anonymous"></script>
	<script>
	document.addEventListener("DOMContentLoaded", function() {
	    // Seleciona o botão "Adicionar item"
	    var adicionarItemBtn = document.querySelector("#adicionarItemBtn");

	    // Adiciona um ouvinte de evento de clique no botão "Adicionar item"
	    adicionarItemBtn.addEventListener("click", function(event) {
	        event.preventDefault();
	        console.log("Botão clicado!");

	        // Coletar os valores dos campos do formulário
	        var idProd = document.querySelector("#validationCustom02").value;
	        var desProd = document.querySelector("#desProd").value;
	        var qtdProd = document.querySelector("#qtdProd").value;
	        var precoProd = document.querySelector("#precoProd").value;
	        var compraProd = document.querySelector("#compraProd").value;

	        // Criar um objeto FormData para enviar os dados para o servlet
	        var formData = new FormData();
	        formData.append("idProd", idProd);
	        formData.append("desProd", desProd);
	        formData.append("qtdProd", qtdProd);
	        formData.append("precoProd", precoProd);
	        formData.append("compraProd", compraProd);

	        // Faça uma solicitação AJAX para enviar os dados do formulário para o servlet
	        var xhr = new XMLHttpRequest();
	        xhr.open("POST", "inserirItens");
	        xhr.onload = function() {
	            // Verifica se a solicitação foi bem-sucedida
	            if (xhr.status === 200) {
	                // Aqui você pode fazer qualquer manipulação adicional do resultado, se necessário
	                // Por exemplo, atualizar a tabela do carrinho sem recarregar a página
	                // Ou exibir uma mensagem de sucesso
	                alert('Item adicionado com sucesso!');
	            } else {
	                // Exibe um alerta em caso de erro
	                alert('Erro ao processar a solicitação. Tente novamente.');
	            }
	        };
	        xhr.send(formData);
	    });
	});

</script>


</body>
</html>