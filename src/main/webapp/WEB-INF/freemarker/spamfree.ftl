<html xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset=utf-8 />
    <title>SPAM FREE</title>
    <link rel="stylesheet" href="css/style.css" />
    <script type="text/javascript" src="js/jquery-1.11.0.min.js"></script>

</head>
<body>
<h1>SPAM FREE</h1>
        <div>
            <form id="fakeaction" action="nospam.html" method="post">
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
            </form>
        </div>

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