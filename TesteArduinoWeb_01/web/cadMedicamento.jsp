<%@page import="java.sql.Time"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.List"%>
<%@page import="model.Medicamento"%>
<%@page import="java.util.ArrayList"%>
<%

    String[] cores = {"item-green", "item-pink", "item-blue", "item-purple", "item-primary", "item-orange"};

    int cont = 0;

    if (session.getAttribute("isLogado") == null) {
        response.sendRedirect("login.jsp");
    }

    DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    DateFormat dateFormatBar = new SimpleDateFormat("dd/MM/yyyy  HH:mm:ss");
    DateFormat dateFF = new SimpleDateFormat("hh:mm:ss");
    Date date = new Date();
    //System.out.println(dateFormat.format(date)); //2016/11/16 12:08:43 


%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->  
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->  
<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->  
    <head>
        <title>Pill Reminder</title>
        <!-- Meta -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">  
        <meta HTTP-EQUIV="Refresh" CONTENT="60">
        <link rel="shortcut icon" href="favicon.ico">  
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
        <!-- Global CSS -->
        <link rel="stylesheet" href="assets/plugins/bootstrap/css/bootstrap.min.css">   
        <!-- Plugins CSS -->    
        <link rel="stylesheet" href="assets/plugins/font-awesome/css/font-awesome.css">
        <link rel="stylesheet" href="assets/plugins/elegant_font/css/style.css">

        <!-- Theme CSS -->
        <link id="theme-style" rel="stylesheet" href="assets/css/styles.css">
        <script>
            jQuery(function ($) {
                $("#campoData").mask("99/99/9999");
                $("#campoTelefone").mask("(999) 999-9999");
                $("#campoSenha").mask("***-****");
            });
        </script>
    </head> 

    <body class="landing-page">   

        <!--FACEBOOK LIKE BUTTON JAVASCRIPT SDK-->
        <div id="fb-root"></div>
        <script>(function (d, s, id) {
                var js, fjs = d.getElementsByTagName(s)[0];
                if (d.getElementById(id))
                    return;
                js = d.createElement(s);
                js.id = id;
                js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.5";
                fjs.parentNode.insertBefore(js, fjs);
            }(document, 'script', 'facebook-jssdk'));</script>

        <div class="page-wrapper">
            <!-- ******Header****** -->
            <header class="header text-center" style="background: #ffad33;">
                <div class="container">
                    <% out.println("<p style=\"float:right; color:black;\">" + dateFormat.format(date) + "</p>");

                    %>
                    <div class="branding">
                        <h1 class="logo">
                            <span aria-hidden="true"><img src="assets/icons/capsules-128.png"></span>
                            <span class="text-highlight" style="color:#000;">Pill</span><span class="text-bold">Reminder</span>
                        </h1>
                    </div><!--//branding-->
                    <div class="tagline">
                        <p>Bem vindo <strong><%=session.getAttribute("nome_usuario")%></strong></p>
                        <!--                        <p>Desenvolvido com <i class="fa fa-heart"></i> e carinho</p>-->
                    </div><!--//tagline-->
                </div><!--//container-->
            </header><!--//header-->
            <nav class="navbar navbar-default">
                <div class="container-  fluid">
                    <div class="navbar-header">
                        <a class="navbar-brand" href="#"></a>
                    </div>
                    <ul class="nav navbar-nav">
                        <li><a href="LoginServlet?op=home">Home <i class="fa fa-home"></i></a></li>
                        <li><a href="#"> Usuario <i class="fa fa-user"></i></a></li>
                        <li class="active"><a href="#"> Medicamento <i class="fa fa-plus-circle"></i></a></li>
                        <li><a href="LoginServlet?op=wiki"> Sobre <i class="fa fa-question-circle"></i></a></li>
                        <li><a href="LoginServlet?op=sair"> Sair <i class="fa fa-sign-out"></i></a></li>
                    </ul>
                    <ul class="nav navbar-nav" style="float: right; margin-right: 1%; color:#000">
                        <li><a href="#"><i class="fa fa-clock-o  "></i> <%=dateFormatBar.format(date)%></a></li> 
                    </ul> 
                </div>
            </nav>

            <section class="cards-section text-center" style="background: #FFF">

                <div class="container">

                    <form action="LoginServlet" method="POST">
                        <div class="form-group">
                            <label style="float: left;">Nome Medicamento</label>
                            <input type="text" name="nomeMed" class="form-control" aria-describedby="emailHelp" placeholder="Digite o nome do medicamento">
                        </div>
                        <div class="form-group">
                            <label style="float: left;" >Data de inicio</label>
                            <input type="text" name="dataIniMed" id="campoData" maxlength="10" class="form-control" placeholder="##/##/####">
                        </div>

                        <div class="form-group">
                            <label style="float: left;" >Horário de inicio</label>
                            <input type="text" name="horaIniMed" maxlength="8" class="form-control" placeholder="##:##:##">
                        </div>

                        <div class="form-group">
                            <label style="float: left;" >Data Termino</label>
                            <input type="text" name="dataFimMed" id="campoData" maxlength="10" class="form-control" placeholder="##/##/####">
                        </div>

                        <div class="form-group">
                            <label style="float: left;" >Horário Termino</label>
                            <input type="text" name="horaFimMed" maxlength="8" class="form-control" placeholder="##:##:##">
                        </div>

                        <div class="form-group">
                            <label style="float: left;" >Intervalo Horas</label>
                            <input type="text" name="interMed" class="form-control" placeholder="Digite a quantidade de horas">
                        </div>


                        <button type="submit" value="CadastroMed" name="op" class="btn btn-primary">Cadastrar</button>
                    </form>

                </div><!--//container-->
            </section><!--//cards-section-->
        </div><!--//page-wrapper-->

        <footer class="footer text-center">
            <div class="container">
                <small class="copyright">Desenvolvido com <i class="fa fa-heart"></i></small>

            </div><!--//container-->
        </footer><!--//footer-->


        <!-- Main Javascript -->          
        <script type="text/javascript" src="assets/plugins/jquery-1.12.3.min.js"></script>
        <script type="text/javascript" src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>                                                                     
        <script type="text/javascript" src="assets/plugins/jquery-match-height/jquery.matchHeight-min.js"></script>
        <script type="text/javascript" src="assets/js/main.js"></script>

    </body>
</html> 