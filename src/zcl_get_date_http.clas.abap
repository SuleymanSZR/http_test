*CLASS zcl_get_date_http DEFINITION
*  PUBLIC
*  CREATE PUBLIC .
*
*  PUBLIC SECTION.
*
*    INTERFACES if_http_service_extension.
*
*  PROTECTED SECTION.
*  PRIVATE SECTION.
*ENDCLASS.
*
*
*
*CLASS zcl_get_date_http IMPLEMENTATION.
*
*
*  METHOD if_http_service_extension~handle_request.
*    response->set_text( ' hello ' ).
*  ENDMETHOD.
*ENDCLASS.

**********************************************************************

CLASS zcl_get_date_http DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .

    METHODS: get_html RETURNING VALUE(ui_html) TYPE string
                      RAISING   cx_abap_context_info_error.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_get_date_http IMPLEMENTATION.



  METHOD get_html.

    DATA(user_formatted_name) = cl_abap_context_info=>get_user_formatted_name( ).
    DATA(system_date) = cl_abap_context_info=>get_system_date( ).
    DATA(system_time) = cl_abap_context_info=>get_system_time( ).

    ui_html =  |<html> \n| &&
    |<body> \n| &&
    |<title>General Information</title> \n| &&
    |<p style="color:DodgerBlue;"> Hello there, { user_formatted_name } </p> \n | &&
    |<p> Today, the date is:  { system_date }, { system_time }| &&
    |<p> | &&
    |</body> \n| &&
    |</html> | .

  ENDMETHOD.

  METHOD if_http_service_extension~handle_request.
    TRY.
        response->set_text( get_html(  ) ).
      CATCH cx_web_message_error cx_abap_context_info_error.
        "additional exception handling
    ENDTRY.
  ENDMETHOD.

ENDCLASS.

