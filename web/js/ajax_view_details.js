var xmlHttp3 = null;
function viewDetails(accountNo) {
    createXmlHttpRequest3();
    xmlHttp3.onreadystatechange = handleViewDetailsRequest;
    xmlHttp3.open("POST", "DataServlet?action=3&account_no=" + accountNo, true);
    xmlHttp3.send("<?XML version=\"1.0\" encoding=\"UTF-8\"?>");
}
function createXmlHttpRequest3() {
    if (window.ActiveXObject) {
        xmlHttp3 = new ActiveXObject("Microsoft.XMLHTTP");
    } else if (window.XMLHttpRequest) {
        xmlHttp3 = new XMLHttpRequest();
    }
}
function handleViewDetailsRequest() {
    if (xmlHttp3.readyState == 4) {
        xmlvalue = xmlHttp3.responseText;
        if (xmlvalue == null) {
            xmlvalue = xmlHttp3.responseXML;
        }
        console.log(xmlvalue);
        //alert(xmlvalue);
        if (xmlvalue == -1) {
            document.getElementById("account_details").innerHTML = '<td colspan="3">Service Currently Not Available</td>';
        } else {
            details = JSON.parse(xmlvalue);
            html='<td>'+details.account_no+"</td><td>"+details.balance+"</td><td>"+details.currency;
            document.getElementById("account_details").innerHTML = html;
            objArray=details.transactions;
            //alert(objArray);
            html='<table border="1" style="border-color: red;"><tr><th>Amount</th><th>Date</th><th>Details</th></tr>';
            for (var i = 0; i < objArray.length; i++) {
                var obj = objArray[i];
                //alert(obj);
                //console.log(obj.id);
                html+='<tr><td>'+obj.transaction+"</td><td>"+obj.date+"</td><td>"+obj.details+"</td></tr>";
            }
            html+='</table>'
            //alert(html);
            document.getElementById("transaction_details").innerHTML = html;
        }
    }
}
