# InternetBankingApp
A Sample internet banking web application 

# Solution Components

  <img width="960" alt="solution" src="https://user-images.githubusercontent.com/18471537/71544904-9d0d9380-2995-11ea-882c-4b027a328967.png">

This web application uses 5 different micro-services, optionally you can connect via API Manager or directly to these services.
Three of these Micro-services already uses MySQL to persist and query data, while one services connect to ActiveMQ to send messages to one Queue and another service connect to Redis to cach some results.
These services are:
- UserAccountService : https://github.com/osa-ora/UserAccountService
- CustomerDataService : https://github.com/osa-ora/CustomerDataService
- BankingService : https://github.com/osa-ora/BankingService
- LoanService : https://github.com/osa-ora/LoanService
- ExchangeRateService : https://github.com/osa-ora/ExchangeRateService


# It is a Netbeans based project that uses Apache ANT to build it simply run: 

- ant -buildfile build.xml clean dist

- Then deploy the war file from the dist folder into either Tomcat or Glassfish or any other web container

# The service do expect 5 different environment variables to connect to different backend microservices:

- userAccountService the default is http://localhost:8083/AccountService/V1/accounts/
- customerDataService the default is http://localhost:8085/CustomersService/V1/customers/
- bankingService the default is http://localhost:8086/BankAccountService/V1/bankaccounts/
- loanService the default is http://localhost:8000/LoanService/V1/
- exchangeRateService the default is http://localhost:8881/api/v1/exchange/

