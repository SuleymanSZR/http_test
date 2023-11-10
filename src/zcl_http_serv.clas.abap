**********************************************************************
*CLASS zcl_http_serv DEFINITION
*  PUBLIC
*  CREATE PUBLIC .
*
*  PUBLIC SECTION.
*
*    INTERFACES if_http_service_extension .
*  PROTECTED SECTION.
*  PRIVATE SECTION.
*ENDCLASS.
*
*
*
*CLASS zcl_http_serv IMPLEMENTATION.
*
*
*  METHOD if_http_service_extension~handle_request.
*    response->set_text( 'Merhaba kullancı, bu bir HTTP çalışmasıdır!' ).
*
*  ENDMETHOD.
*ENDCLASS.

**********************************************************************

CLASS zcl_http_serv DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension . "Standard Interface
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS: get_html RETURNING VALUE(html) TYPE string. "GET Request HTML Generator Method
    METHODS: post_html                                   "POST Request HTML Generator Method
      IMPORTING
                Ad          TYPE string
                Soyad       TYPE string
                Tanım       TYPE string
                Sirket      TYPE string
                Numara      TYPE string
                mail        TYPE string
      RETURNING VALUE(html) TYPE string.

    CLASS-DATA url TYPE string.

ENDCLASS.



CLASS zcl_http_serv IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request. "Standard Method Which Handles the HTTP request
    url = 'https://c75f608d-4148-434a-88e1-64b75d24911a.abap-web.us10.hana.ondemand.com:443/sap/bc/http/sap/Z_HTTP_SERV?sap-client=100'. " URL For the HTTP service #Generated while creation
    CASE request->get_method( ). "Getting the  request's HTTP method ie GET , POST ,PUT , PATCH ,DELETE Etc .

      WHEN CONV string( if_web_http_client=>get ). "if its a GET Request

        response->set_text( get_html( ) ).         " Sets the response text  as an HTML file , so that the browser could show a web page as response.

      WHEN CONV string( if_web_http_client=>post ). "if its a Post  Request

        DATA(Ad) = request->get_form_field(  `ad` ). "gets the parameters values Sent by POST request Using the  parameter name
        DATA(Soyad) = request->get_form_field(  `lname` ).
        DATA(Tanım) = request->get_form_field(  `Designation` ).
        DATA(Sirket) = request->get_form_field(  `Company` ).
        DATA(Numara) = request->get_form_field(  `phno` ).
        DATA(mail) = request->get_form_field( 'mail' ).

        response->set_text( post_html(
                                      EXPORTING Ad     = Ad "Sets the response text  as an HTML file , so that the browser could show a web page as response .
                                                Soyad  = Soyad
                                                Tanım  = Tanım
                                                Sirket = Sirket
                                                Numara = Numara
                                                Mail   = Mail
                                        ) ).
    ENDCASE.

  ENDMETHOD.


  METHOD get_html.    "Response HTML for GET request """ HTTP de gösterilen kısım

    html = |<html> \n| &&
  |<body> \n| &&
  |<title>Registration Form </title> \n| &&            " The HTML page has few input fields and a submit button while clicking the submit button the page sends the
  |<form action="{ url }" method="POST">\n| &&         " values entered in the input fields as a POST request .
  |<H2>Blogger Kayıt Arayüzüne Hoşgeldiniz! </H2> \n| &&

  |<label for="fname">Adınız : </label> \n| &&
  |<input type="text" id="ad" name="ad" required ><br><br> \n| &&

  |<label for="lname">Soyadınız :</label> | &&
  |<input type="text" id="lname" name="lname" required ><br><br> \n | &&

  |<label for="Designation">Tanım :</label> | &&
  |<input type="text" id="Designation" name="Designation" required ><br><br> \n | &&

  |<label for="Company">Şirket :</label> | &&
  |<input type="text" id="Company" name="Company" required ><br><br> \n | &&

  |<label for="Mail">Mail :</label> | &&
  |<input type="text" id="Mail" name="Mail" required ><br><br> \n | &&

  |<label for="phno">Telefon Numarası :</label> | &&
  |<input type="number" id="phno" name="phno" required ><br><br> \n | &&

  |<input type="submit" value="Submit"> \n| &&
  |</form> | &&
  |</body> \n| &&
  |</html> | .

  ENDMETHOD.

  METHOD post_html.  "Response HTML for POST request

    html = |<html> \n| &&
   |<body> \n| &&
   |<title>Registration Form </title> \n| && " HTML page is the response page after the submit happens from First page
   |<form action="{ url }" method="Get">\n| &&
   |<H2>Blogger Kayıt İşlemi Başarılı! </H2> \n| &&
   |<p> { sirket } firmasında { tanim } olarak çalışan { ad } { soyad } teşekkür ederiz, </p> | &&
   |<p> Daha ileri işlemler için sizinle { numara } numaralı telefondan ve { mail } adresinden iletişime geçeceğiz.  </p> | &&
   |<input type="submit" value="Go Back"> \n| &&
   |</form> | &&
   |</body> \n| &&
   |</html> | .
  ENDMETHOD.
ENDCLASS.
