var xmlHttp2 = null;
function checkExchange() {
    createXmlHttpRequest2();
    xmlHttp2.onreadystatechange = handleExchangeRequest;
    xmlHttp2.open("POST", "DataServlet?action=2&amount="+
            document.getElementById("exchangeAmount").value+"&from="+document.getElementById("exchangeFrom").value+
            "&to="+document.getElementById("exchangeTo").value, true);
    xmlHttp2.send("<?XML version=\"1.0\" encoding=\"UTF-8\"?>");
}
function createXmlHttpRequest2() {
    if (window.ActiveXObject) {
        xmlHttp2 = new ActiveXObject("Microsoft.XMLHTTP");
    } else if (window.XMLHttpRequest) {
        xmlHttp2 = new XMLHttpRequest();
    }
}
function handleExchangeRequest() {
    if (xmlHttp2.readyState == 4) {
        xmlvalue = xmlHttp2.responseText;
        if (xmlvalue == null) {
            xmlvalue = xmlHttp2.responseXML;
        }
        //alert(xmlvalue);
        console.log(xmlvalue);
        document.getElementById("exchangeResult").innerHTML = xmlvalue;
    }
}
