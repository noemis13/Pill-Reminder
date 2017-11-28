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

    AcessaArduino acessaArduino = (AcessaArduino) session.getAttribute("acessaArduino");

   // boolean flag = (boolean) session.getAttribute("flag");

    //if (flag) {
   //     acessaArduino.setDataToArduino(acessaArduino.getSerialPort(), "a");
   //     session.setAttribute("flag", false);
   // } else {
   //     acessaArduino.setDataToArduino(acessaArduino.getSerialPort(), "c");
   //     session.setAttribute("flag", true);
   // }

    DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
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
        <meta HTTP-EQUIV="Refresh" CONTENT="5">
        <link rel="shortcut icon" href="favicon.ico">  
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
        <!-- Global CSS -->
        <link rel="stylesheet" href="assets/plugins/bootstrap/css/bootstrap.min.css">   
        <!-- Plugins CSS -->    
        <link rel="stylesheet" href="assets/plugins/font-awesome/css/font-awesome.css">
        <link rel="stylesheet" href="assets/plugins/elegant_font/css/style.css">

        <!-- Theme CSS -->
        <link id="theme-style" rel="stylesheet" href="assets/css/styles.css">
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
                        out.println("<p style=\"float:right; color:black;\">" + acessaArduino.getDadosArduino() + "</p>");
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

            <section class="cards-section text-center" style="background: #FFF">

                <div class="container">

                    <div id="cards-wrapper" class="cards-wrapper row" >

                        <%
                            List< Medicamento> medicamentos = (List) session.getAttribute("listaMedicamentos");
                            String dataInicio = "";
                            String horaInicio = "";

                            int vezes = 0;
                            int limite = 0;
                            long horas, minutos, segundos;

                            for (Medicamento m : medicamentos) {
                                dataInicio = m.getDtInicio().split(" ")[0];
                                horaInicio = m.getDtInicio().split(" ")[1];

                                vezes = 24 / Integer.parseInt(m.getIntervaloHoras());
                                limite = 1;

                                int contHoras = Integer.parseInt(m.getIntervaloHoras());

                                out.println("<div class=\"item " + cores[cont] + " col-md-4 col-sm-6 col-xs-6\">");
                                out.println("<div class=\"item-inner\">");
                                out.println("<div class=\"icon-holder\">");
                                out.println(" <i class=\"fa fa-medkit\"></i>");
                                out.println("</div>");
                                out.println("<h3 class=\"title\">" + m.getNomeMedicamento() + "</h3>");
                                out.print("<p class=\"intro\">Inicio: " + dataInicio + "</p>");
                                out.print("<p class=\"intro\">Hora " + horaInicio + "</p>");

                                if (m.getDtFim() != null) {
                                    out.println("<p class=\"intro\">Fim: " + m.getDtFim() + "</p>");
                                } else {
                                    out.println("<p class=\"intro\">Fim: Indeterminado </p>");
                                }

                                out.println("<p> Horários por dia: </p>");
                                out.print("<ul>");
                                

                                while (limite <= vezes) {
                                    LocalTime lt = LocalTime.parse(horaInicio.substring(0, horaInicio.lastIndexOf(":")));
                                    LocalTime ltPlus = lt.plusHours(contHoras);
                                    String output = ltPlus.toString();

//                                    out.println("<p class=\"intro\"> AQUII : "+ dateFormat.format(date).split(" ")[1] +" </p>");
                                    Date d1 = dateFF.parse(dateFormat.format(date).split(" ")[1]);
                                    Date d2 = dateFF.parse(output + ":00");
                                    long diff = d2.getTime();
                                   
                                    out.print("<li> Hora: " + output + " </li>");
                                    horas = diff / 3600;
                                    diff = diff - (horas * 3600);
                                    minutos = diff / 60;
                                    diff = diff - (minutos * 60);
                                    segundos = diff;
//                                    out.print("<li> Restante: " + horas + minutos + segundos + " </li>");
                                    limite += 1;
                                    contHoras += Integer.parseInt(m.getIntervaloHoras());
                                }

                                out.print("</ul>");

                                out.println("</div>");
                                out.println("</div>");

                                if (cont < 5) {
                                    cont++;
                                } else {
                                    cont = 0;
                                }
                            }
                         
                        %>
                    </div><!--//cards-->

                </div><!--//container-->
            </section><!--//cards-section-->
        </div><!--//page-wrapper-->

        <footer class="footer text-center">
            <div class="container">
                <!--/* This template is released under the Creative Commons Attribution 3.0 License. Please keep the attribution link below when using for your own project. Thank you for your support. :) If you'd like to use the template without the attribution, you can check out other license options via our website: themes.3rdwavemedia.com */-->
                <small class="copyright">Designed with <i class="fa fa-heart"></i> by <a href="http://themes.3rdwavemedia.com/" target="_blank">Xiaoying Riley</a> for developers</small>

            </div><!--//container-->
        </footer><!--//footer-->


        <!-- Main Javascript -->          
        <script type="text/javascript" src="assets/plugins/jquery-1.12.3.min.js"></script>
        <script type="text/javascript" src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>                                                                     
        <script type="text/javascript" src="assets/plugins/jquery-match-height/jquery.matchHeight-min.js"></script>
        <script type="text/javascript" src="assets/js/main.js"></script>

    </body>
</html> 