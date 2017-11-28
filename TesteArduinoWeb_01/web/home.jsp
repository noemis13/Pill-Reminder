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
    List<Medicamento> medicamentos = new ArrayList<>();

    medicamentos = DAO.buscaRemediosUsuarios((Integer) session.getAttribute("id_usuario"));

    AcessaArduino acessaArduino = (AcessaArduino) session.getAttribute("acessaArduino");

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
                <%                   // out.println("<strong style=\"float:right; margin-right:10%; color:black;\">" + dateFormat.format(date) + "</strong>");
                    //out.println("<p style=\"float:right; color:black;\">" + acessaArduino.getDadosArduino() + "</p>");
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
                        <li class="active"><a href="#">Home <i class="fa fa-home"></i></a></li>
                        <li><a href="#"> Usuario <i class="fa fa-user"></i></a></li>
                        <li><a href="LoginServlet?op=cadmedicamento"> Medicamento <i class="fa fa-plus-circle"></i></a></li>
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

                    <div id="cards-wrapper" class="cards-wrapper row" >

                        <%
                            String dataInicio = "";
                            String horaInicio = "";

                            int vezes = 0;
                            int limite = 0;
                            long horas, minutos, segundos;

                            for (Medicamento m : medicamentos) {

//                                horasPorRemedio.put(m.getIdMedicamento(), new ArrayList<>());
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
                                out.println("<p> Próximos horários </p> ");
                                out.print("<ul class=\"list-group\" >");

                                while (limite <= vezes) {
                                    LocalTime lt = LocalTime.parse(horaInicio.substring(0, horaInicio.lastIndexOf(":")));
                                    LocalTime ltPlus = lt.plusHours(contHoras);
                                    String output = ltPlus.toString();
//
//
                                    SimpleDateFormat formatter = new SimpleDateFormat("kk:mm");
                                    Date aux1 = formatter.parse(output);
                                    Date aux2 = formatter.parse(dateFF.format(date));

                                    long difMilli = aux1.getTime() - aux2.getTime();
                                    int timeInSeconds = (int) difMilli / 1000;
                                    int hours, minutes, seconds;
                                    hours = timeInSeconds / 3600;
                                    timeInSeconds = timeInSeconds - (hours * 3600);
                                    minutes = timeInSeconds / 60;
                                    timeInSeconds = timeInSeconds - (minutes * 60);
                                    seconds = timeInSeconds;

                                    out.print("<li class=\"list-group-item\" style=\"border:none; background:none; \">" + output + " </li>");

                                    //out.print("<li class=\"list-group-item\" style=\"border:none; background:none; \"> Restam " + hours + ":" + minutes + "  </li>");
//                                    out.print("<li class=\"list-group-item\" style=\"border:none; background:none; \"> DIA " +  date.toString().substring(0,date.toString().indexOf(" "))+"  </li>");
                                    limite += 1;
                                    contHoras += Integer.parseInt(m.getIntervaloHoras());

                                    if ((hours <= 0) && (hours > -1) && (minutes <= 0) && (minutes > -1)) {
                                        System.out.println("PEGOU 0 -----" + hours + minutes + " " + output);

                                        if (date.toString().substring(0, date.toString().indexOf(" ")).equals("Mon")) {
                                            acessaArduino.setDataToArduino(acessaArduino.getSerialPort(), "1");

                                        } else if (date.toString().substring(0, date.toString().indexOf(" ")).equals("Tue")) {
                                            acessaArduino.setDataToArduino(acessaArduino.getSerialPort(), "2");
                                            System.out.println("terçAAAA ----");

                                        } else if (date.toString().substring(0, date.toString().indexOf(" ")).equals("Wed")) {
                                            acessaArduino.setDataToArduino(acessaArduino.getSerialPort(), "3");
                                            //     session.setAttribute("flag", false);
                                        } else if (date.toString().substring(0, date.toString().indexOf(" ")).equals("Thurs")) {
                                            acessaArduino.setDataToArduino(acessaArduino.getSerialPort(), "4");
                                        }//     session.setAttribute("flag", false);
                                        else if (date.toString().substring(0, date.toString().indexOf(" ")).equals("Fri")) {
                                            acessaArduino.setDataToArduino(acessaArduino.getSerialPort(), "5");
                                        }//     session.setAttribute("flag", false);
                                        else if (date.toString().substring(0, date.toString().indexOf(" ")).equals("Sat")) {
                                            acessaArduino.setDataToArduino(acessaArduino.getSerialPort(), "6");
                                        }//     session.setAttribute("flag", false);
                                        else if (date.toString().substring(0, date.toString().indexOf(" ")).equals("Sun")) {
                                            acessaArduino.setDataToArduino(acessaArduino.getSerialPort(), "7");
                                        }//     session.setAttribute("flag", false);
                                        // } else {
                                        //     acessaArduino.setDataToArduino(acessaArduino.getSerialPort(), "c");
                                        //     session.setAttribute("flag", true);
                                        // }
                                        //alarme arduino UP
                                        //acende led dia da semana  -- date.toString().substring(0,date.toString().indexOf(" "));
                                        //Mon Tue Wed Thurs Fri Sat Sun
                                    }
//                                    horasPorRemedio.get(m.getIdMedicamento()).add(String.valueOf(hours) + String.valueOf(minutes));
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