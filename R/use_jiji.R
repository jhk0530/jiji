#' @export
#'
#' @import htmltools
#' @import glue
#'
use_jiji <- function(service_id = NULL, user_id = NULL, template_id = NULL, receiver_name = 'jhk0530', success_msg = 'Your mail is sent!', fail_msg = 'Oops... ') {


  # Error
  if (is.null(service_id)) {
    print("jiji requires emailjs information")
    return()
  }

  htmltools::tagList(
    # Define JS function to build mail contents
    htmltools::tags$script(
      glue::glue(
        .open = "{{", .close = "}}",
        "declare_data = function(){
      var data = {
      service_id: '{{service_id}}',
      user_id: '{{user_id}}',
      template_id: '{{template_id}}',
      template_params: {
          'from_name': $('#user_name').val(),
          'to_name': '{{receiver_name}}',
          'message': $('#mail_message').val()
        }
      };
      return data;
    }")
    ),
    htmltools::tags$div( # jiji UI
      id = "shiny-jiji",
      style = "position: absolute;
      right: 10px; bottom: 10px;
      z-index: 99998 !important;
      overflow: hidden !important;
      cursor: not-allowed !important;",
      textAreaInput(
        inputId = 'user_name',
        label = NULL,
        value = "",
        placeholder = 'Your name here'
      ),
      textAreaInput(
        inputId = 'mail_message',
        label = NULL,
        value = "",
        placeholder = 'Message Here'
      ),
      actionButton(
        inputId = "send_mail",
        label = 'Send',
        icon = icon('envelope',class = 'fa-regular'),
        onclick = glue::glue(
          .open = "{{", .close = "}}",
          "data = declare_data(); ",
          "$.ajax('https://api.emailjs.com/api/v1.0/email/send', {
          type: 'POST',
          data: JSON.stringify(data),
          contentType: 'application/json'
          }).done(function() {
            alert('{{success_msg}}');
          }).fail(function(error) {
            alert('{{fail_msg}}' + JSON.stringify(error));
          });",
          "$('#send_mail').hide();" # one time mail send.
        )
      )
    )
  )
}
