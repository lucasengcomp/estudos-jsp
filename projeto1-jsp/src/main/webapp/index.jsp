<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
	crossorigin="anonymous">

<title>Curso JSP</title>

<style type="text/css">
form {
	position: absolute;
	top: 40%;
	left: 33%;
	right: 33%;
}

h5 {
	position: absolute;
	top: 30%;
	left: 33%;
}

.msg {
	position: absolute;
	top: 20%;
	left: 33%;
	font-size: 15px;
	color: red;
}
</style>

</head>
<body>
	<h5>Faça seu Login</h5>

	<form action="ServletLogin" method="post"
		class="row g-3 needs-validation" novalidate>

		<input type="hidden" value="<%=request.getParameter("url")%>"
			name="url">

		<div class="md-3">
			<label class="form-label" for="login">Login</label> <input
				class="form-control" id="login" name="login" type="text" required>
			<div class="invalid-feedback">Campo obrigatório</div>
			<div class="valid-feedback">Tudo certo!</div>
		</div>

		<div class="md-3">
			<label class="form-label" for="senha">Senha</label> <input
				class="form-control" id="senha" name="senha" type="password"
				required>
			<div class="invalid-feedback">Campo obrigatório</div>
			<div class="valid-feedback">Tudo certo!</div>
		</div>
		<input type="submit" value="Acessar" class="btn btn-primary">
	</form>

	<h5 class="msg">${msg}</h5>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4"
		crossorigin="anonymous"></script>

	<script type="text/javascript">
		(function() {
			'use strict'
			var forms = document.querySelectorAll('.needs-validation')

			// Loop over them and prevent submission
			Array.prototype.slice.call(forms).forEach(function(form) {
				form.addEventListener('submit', function(event) {
					if (!form.checkValidity()) {
						event.preventDefault()
						event.stopPropagation()
					}
					form.classList.add('was-validated')
				}, false)
			})
		})()
	</script>
</body>
</html>