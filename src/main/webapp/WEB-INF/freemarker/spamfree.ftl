<html xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset=utf-8 />
    <title>SPAM FREE</title>
    <link rel="stylesheet" href="css/style.css" />
    <script type="text/javascript" src="js/jquery-1.11.0.min.js"></script>

    <#--<script type="text/javascript">-->
        <#--var onloadCallback = function() {-->
            <#--grecaptcha.render('html_element', {-->
                <#--'sitekey' : '6LeM5gsTAAAAAFkEKyFhLLCWtnVB5cjolaqfoS01'-->
            <#--});-->
        <#--};-->
    <#--</script>-->
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
</head>
<body>

    <h1>SPAM FREE</h1>
    <form id="fakeaction" action="nospam.html" method="post">
        <div>
            <div>
                <label>Name: </label>
                <input id="real_name" type="text" name="real_name"/>
            </div>
            <div>
                <label>Email: </label>
                <input id="real_email" type="text" name="real_email"/>
                <input id="test_email" type="text" name="email" value=""/>
            </div>
            <div>
                <input type="button" value="Send" onclick="submitForm();" />
            </div>
        </div>
    </form>


    <h1>SPAM FREE WITH CAPTCHA</h1>
    <form id="recaptcha" action="recaptcha.html" method="post">
        <div>
            <div>
                <label>Name: </label>
                <input id="recaptcha_name" type="text" name="recaptcha_name"/>
            </div>
            <div>
                <label>Email: </label>
                <input id="recaptcha_email" type="text" name="recaptcha_email"/>
                <#--<input id="test_email" type="text" name="email" value=""/>-->
            </div>
            <div class="g-recaptcha"
                 data-sitekey="6Lem5wsTAAAAABMSLFYT4Vwblqn7a331OqQfuBxL"></div>
            <div>
                <input type="submit" value="Send" />
            </div>
        </div>
    </form>

    <script type="text/javascript">
        function submitForm(){
            if ($('#test_email').val() != "") {
                alert("Spam fill in this form !!!");
                //Prevent the submit event and remain on the screen
                e.preventDefault();
                return false;
            } else{
                document.getElementById('fakeaction').action = "submit.html";
                document.getElementById('fakeaction').submit();
            }
        }
    </script>

</body>
</html>