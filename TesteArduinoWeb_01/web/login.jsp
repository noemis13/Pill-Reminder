
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
    <head>
        <meta charset="UTF-8">
        <title>PillReminder</title>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">

        <link rel='stylesheet prefetch' href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700,900|RobotoDraft:400,100,300,500,700,900'>
        <link rel='stylesheet prefetch' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'>

        <link rel="stylesheet" href="assets/css/style.css">


    </head>

    <body>

        <!-- Mixins-->
        <!-- Pen Title-->
        <div class="pen-title">
            <h1>PillReminder</h1><span>Desenvolvido<i class='fa fa-code' style="color:#ff9900;"></i> por Maisa Barreto e Noemi Scherer</span>
        </div>
        <!--<div class="rerun"><a href="">Rerun Pen</a></div>-->
        <div class="container">
            <div class="card" ></div>
            <div class="card" >
                <h3 style="color:orange; margin-left: 30%;" >${mensagemCadastrado}</h3>
                <h3 style="color:red; margin-left: 30%; margin-bottom: 5%;">${erroLogin}</h3>
                <h1 class="title" style="color:#ffad33;">Login</h1>
                <form action="LoginServlet" method="POST">
                    <div class="input-container">
                        <input type="" id="" name="useremail" required="required"/>
                        <label for="#">Usuario</label>
                        <div class="bar"></div>
                    </div>
                    <div class="input-container">
                        <input type="password" id="" name="userpass" required="required"/>
                        <label for="">Senha</label>
                        <div class="bar"></div>
                    </div>
                    <div class="button-container">
                        <button type="submit" value="Login" name="op"/><span>Entrar</span></button>
                    </div>
                    <div class="footer" style="color:#ffcc80"><a href="#">Esqueceu sua senha?</a></div>
                </form>
            </div>
            <div class="card alt">
                <div class="toggle" style="background-color:#ff9900;"></div>
                <h1 class="title">Cadastro
                    <div class="close"></div>
                </h1>
                <form action="CadastroServlet" method="POST">
                    <div class="input-container">
                        <input type="text"  name="username" id="" required="required"/>
                        <label for="">Nome do usuário</label>
                        <div class="bar"></div>
                    </div>
                    <div class="input-container">
                        <input type="text" id="" name="useremail" required="required"/>
                        <label for="">E-mail</label>
                        <div class="bar"></div>
                    </div>
                    <div class="input-container">
                        <input type="password" id="" name="userpass" required="required"/>
                        <label for="">Senha</label>
                        <div class="bar"></div>
                    </div>

                    <div class="button-container">
                        <button value="Cadastro" name="op"><span style="color:#ffad33;">Cadastrar</span></button>
                    </div>
                </form>
            </div>
        </div>
        <!-- Portfolio<a id="portfolio" href="http://andytran.me/" title="View my portfolio!"><i class="fa fa-link"></i></a>
         CodePen<a id="codepen" href="https://codepen.io/andytran/" title="Follow me!"><i class="fa fa-codepen"></i></a>-->
        <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>

        <script  src="assets/js/index.js"></script>

    </body>
</html> 

