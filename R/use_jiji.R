use_jiji <- function(){
  htmltools::tagList(

    # Call jquery 3.6.1 (22/10)
    htmltools::tags$script(
      "var script = document.createElement('script');
      script.src = 'https://code.jquery.com/jquery-3.6.1.min.js';
      script.integrity = 'sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=';
      script.crossorigin = 'anonymous';
      document.getElementsByTagName('head')[0].appendChild(script);"
    ),

    htmltools::tags$div( # button ui
      id = "ss-connect-dialog",
      style = "",
      # Set right down always
    ),
    htmltools::tags$script( # define mail contents
      "declare_data = function(){
        var data = {
        service_id: 'service_24ofle8',
        user_id: 'lPibe18UrAdvFTEJu',
        template_id: 'template_uq7be2p',
        template_params: {
            'from_name': $('#user_name').val(),
            'to_name': 'jhk0530',
            'message': $('#mail_message').val()
          }
        };
        return data;
      }"
    ),
    htmltools::tags$div( # overlay ui
      id = "ss-overlay",
      style = "display: none;",
      HTML(
        paste0(
          '<textarea id="user_name">Your name here</textarea>',
          '<textarea id="mail_message">Message here</textarea>',
          '<button id = "send_mail" ',
          'onclick="',
          "data = declare_data();",
          "$.ajax('https://api.emailjs.com/api/v1.0/email/send', {
          type: 'POST',
          data: JSON.stringify(data),
          contentType: 'application/json'
          }).done(function() {
            alert('Your mail is sent!');
          }).fail(function(error) {
            alert('Oops... ' + JSON.stringify(error));
          });",
          "$('#send_mail').hide();",
          '">Send</button>'
        )
      )
    ),
    htmltools::tags$head(
      htmltools::tags$style(
        glue::glue(
          .open = "{{", .close = "}}",

          "#shiny-disconnected-overlay { display: none !important; }",

          "#ss-overlay {
             background-color: {{overlayColour}} !important;
             opacity: {{overlayOpacity}} !important;
             position: fixed !important;
             top: 0 !important;
             left: 0 !important;
             bottom: 0 !important;
             right: 0 !important;
             z-index: 99998 !important;
             overflow: hidden !important;
             cursor: not-allowed !important;
          }",

          "#ss-connect-dialog {
             background: {{background}} !important;
             color: {{colour}} !important;
             width: {{width}} !important;
             transform: translateX(-50%) translateY({{ytransform}}) !important;
             font-size: {{size}}px !important;
             top: {{top}} !important;
             position: fixed !important;
             bottom: auto !important;
             left: 50% !important;
             padding: 0.8em 1.5em !important;
             text-align: center !important;
             height: auto !important;
             opacity: 1 !important;
             z-index: 99999 !important;
             border-radius: 3px !important;
             box-shadow: rgba(0, 0, 0, 0.3) 3px 3px 10px !important;
          }",

          "#ss-connect-dialog::before { content: '{{text}}' }",

          "#ss-connect-dialog label { display: none !important; }",

          "#ss-connect-dialog a {
             display: {{ if (refresh == '') 'none' else 'block' }} !important;
             color: {{refreshColour}} !important;
             font-size: 0 !important;
             margin-top: {{size}}px !important;
             font-weight: normal !important;
          }",

          "#ss-connect-dialog a::before {
            content: '{{refresh}}';
            font-size: {{size}}px;
          }",

          "#ss-connect-dialog { {{ htmltools::HTML(css) }} }"
        )
      )
    )
  )
}
