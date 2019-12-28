var xmlHttp4 = null;
function doTransfer() {
    createXmlHttpRequest4();
    xmlHttp4.onreadystatechange = handleTransferRequest;
    xmlHttp4.open("POST", "DataServlet?action=4&amount="+
            document.getElementById("transferAmount").value+"&from="+document.getElementById("fromAccount").value+
            "&to="+document.getElementById("toAccount").value+"&notes="+document.getElementById("notes").value, true);
    xmlHttp4.send("<?XML version=\"1.0\" encoding=\"UTF-8\"?>");
}
function createXmlHttpRequest4() {
    if (window.ActiveXObject) {
        xmlHttp4 = new ActiveXObject("Microsoft.XMLHTTP");
    } else if (window.XMLHttpRequest) {
        xmlHttp4 = new XMLHttpRequest();
    }
}
function handleTransferRequest() {
    if (xmlHttp4.readyState == 4) {
        xmlvalue = xmlHttp4.responseText;
        if (xmlvalue == null) {
            xmlvalue = xmlHttp4.responseXML;
        }
        //alert(xmlvalue);
        console.log(xmlvalue);
        details = JSON.parse(xmlvalue);
        document.getElementById("transferResult").innerHTML = details.result;
    }
}
