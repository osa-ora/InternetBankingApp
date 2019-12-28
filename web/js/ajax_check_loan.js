var xmlHttp1 = null;
function checkLoan() {
    createXmlHttpRequest();
    xmlHttp1.onreadystatechange = handleLoanRequest;
    xmlHttp1.open("POST", "DataServlet?action=1&amount="+
            document.getElementById("loanAmount").value+"&monthlyIncome="+document.getElementById("monthlyIncome").value, true);
    xmlHttp1.send("<?XML version=\"1.0\" encoding=\"UTF-8\"?>");
}
function createXmlHttpRequest() {
    if (window.ActiveXObject) {
        xmlHttp1 = new ActiveXObject("Microsoft.XMLHTTP");
    } else if (window.XMLHttpRequest) {
        xmlHttp1 = new XMLHttpRequest();
    }
}
function handleLoanRequest() {
    if (xmlHttp1.readyState == 4) {
        xmlvalue = xmlHttp1.responseText;
        if (xmlvalue == null) {
            xmlvalue = xmlHttp1.responseXML;
        }
        console.log(xmlvalue);
        //alert(xmlvalue);
        if(xmlvalue==-1){
            document.getElementById("loanResult").innerHTML = 'Service Currently Not Available';
        }else{
            obj = JSON.parse(xmlvalue);
            //alert(obj.status);
            if(obj.status==true) obj.status='Can be Approved'; else obj.status='Will be Rejected';
            document.getElementById("loanResult").innerHTML = 'Loan Request Result ('+obj.status+') <br>Reason ('+obj.reason+")";
        }
    }
}
