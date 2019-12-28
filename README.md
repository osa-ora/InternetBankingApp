# InternetBankingApp
A Sample internet banking web application

# It is Netbeans project that uses ant, to build it simply run: 

ant -buildfile build.xml clean dist

Then deploy the war file from the dist folder

# The service do expect 5 different environment variables to connect to different backend microservices:

## userAccountService the default is http://localhost:8083/AccountService/V1/accounts/
## customerDataService the default is http://localhost:8085/CustomersService/V1/customers/
## bankingService the default is http://localhost:8086/BankAccountService/V1/bankaccounts/
## loanService the default is http://localhost:8000/LoanService/V1/
## exchangeRateService the default is http://localhost:8881/api/v1/exchange/