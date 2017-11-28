<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="dao.DAO"%>
<%@page import="arduino.AcessaArduino"%>
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
//    List<Medicamento> medicamentos = new ArrayList<>();
//
//    medicamentos = DAO.buscaRemediosUsuarios((Integer) session.getAttribute("id_usuario"));
//
//    AcessaArduino acessaArduino = (AcessaArduino) session.getAttribute("acessaArduino");
//
    DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    DateFormat dateFormatBar = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
    DateFormat dateFF = new SimpleDateFormat("hh:mm:ss");
    Date date = new Date();

//    Map<Integer, ArrayList<String>> horasPorRemedio = new HashMap<>();

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

        <script language="JavaScript">

            function mascara(t, mask) {
                var i = t.value.length;
                var saida = mask.substring(1, 0);
                var texto = mask.substring(i)
                if (texto.substring(0, 1) != saida) {
                    t.value += texto.substring(0, 1);
                }
            }
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
                <%//                    out.println("<strong style=\"float:right; margin-right:10%; color:black;\">" + dateFormat.format(date) + "</strong>");
//                        out.println("<p style=\"float:right; color:black;\">" + acessaArduino.getDadosArduino() + "</p>");
%>
                <div class="container">
                    <div class="branding">
                        <h1 class="logo">
                            <span aria-hidden="true"><img src="assets/icons/capsules-128.png"></span>
                            <span class="text-highlight" style="color:#000;">Pill</span><span class="text-bold">Reminder</span>
                        </h1>
                    </div><!--//branding-->
                    <div class="tagline">
                        <p>Bem vindo(a) <strong><%=session.getAttribute("nome_usuario")%></strong></p>
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
                        <li><a href="LoginServlet?op=cadmedicamento"> Medicamento <i class="fa fa-plus-circle"></i></a></li>
                        <li class="active"><a href="#"> Sobre <i class="fa fa-question-circle"></i></a></li>
                        <li><a href="LoginServlet?op=sair"> Sair <i class="fa fa-sign-out"></i></a></li>
                    </ul>
                    <ul class="nav navbar-nav" style="float: right; margin-right: 1%; color:#000">
                        <li><a href="#"><i class="fa fa-clock-o  "></i> <%=dateFormatBar.format(date)%></a></li> 
                    </ul> 
                </div>
            </nav>

            <section class="cards-section text-left" style="background: #FFF">



                <div id="cards-wrapper" class="cards-wrapper row" style= " margin-left: 8%; " >
                    <h1>Pill Reminder</h1>
                    <small style="margin-left: 2%;">Por: Maísa Barreto, Noemi Pereira Scherer</small>
                    <br/>
                    <br/>
                    <h3>Objetivo</h3>
                    <br/>
                    <p style="margin-left: 2%;"> Esse projeto tem como objetivo auxiliar pessoas a tomar remédio. De forma geral, existe um sistema no qual cadastra pessoas e seus respectivos remédios a serem tomados, assim como o intervalo de horas, data inicial e final. Feito isso, é verificado o horário do mesmo, e se esse coincidir com o intervalo de horas cadastrado, é tocado um alarme e acendido o LED na caixa de remédio, informando que está na hora de tomar determinado comprimido. O alarme só para quando for pressionado um botão próximo a caixa de remédio.
                        Ao acessar o sistema, é solicitado o login do usuário, que é representado na Figura 1.</p>
                    <br/>
                    <h3>Componentes eletrônicos utilizados</h3>
                    <br/>
                    <ul>
                        <li>Uma protoboard;</li>
                        <li>Uma placa arduino;</li>
                        <li>Cabo USB para conectar o Arduino ao computador;</li>
                        <li>Um sensor de botão;</li>
                        <li>LEDs;</li>
                        <li>Um sensor Buzzer;</li>
                        <li>Fios Jumpers;</li>
                        <li>Uma caixa porta remédios;</li>
                        <li>Um computador com a IDE e drivers do arduino instalado;</li>
                        <li>Um computador com banco de dados MYSQL instalado</li>
                        <li>Um computador com a IDE Netbeans;</li>
                        <li>Biblioteca RXTX instalada;</li>
                    </ul>
                    <br/>
                    <h3>Materiais auxiliares utilizados</h3>
                    <br/>
                    <ul>
                        <li>Uma caixa de sapato</li>
                        <li>Cola quente</li>
                        <li>Estilete</li>
                    </ul>
                    <br/>
                    <h3>Esquematização</h3>
                    <br/>
                    <br/>
                    <h3>Montagem do projeto</h3>
                    <br/>
                    <ul>
                        <li>Foi utilizado um porta remédio como mostra a Figura 2;
                        </li>
                        <li>Dentro da caixa de sapato foi posicionado a protoboard e o arduino, na parte superior foi seccionada na largura e comprimento do porta remédio para esse ficar exposto, assim como no tamanho do botão e do cabo USB;
                        </li>
                        <li>A cola quente foi utilizada para colar o botão, impedindo que esse caísse quando pressionado;</li>
                    </ul>
                    <br/>
                    <h3>Como utilizar o projeto</h3>
                    <br/>
                    <ul>
                        <li>Conecte o arduíno ao computador e compile o arquivo  <strong>sketch.ino</strong></li>
                        <li>Abra a IDE NetBeans e execute o projeto WEB</li>
                        <li>Vá para o navegador aberto pela execução do projeto e aproveita a aplicação!</li>
                    </ul>
                </div>
            </section><!--//cards-section-->
        </div><!--//page-wrapper-->

        <footer class="footer text-center">
            <div class="container">
                <!--/* This template is released under the Creative Commons Attribution 3.0 License. Please keep the attribution link below when using for your own project. Thank you for your support. :) If you'd like to use the template without the attribution, you can check out other license options via our website: themes.3rdwavemedia.com */-->
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